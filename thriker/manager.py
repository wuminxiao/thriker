# -*- coding: utf-8 -*-
from os import path

import glob
import thriftpy
import contextlib

from thrift_connector import (
    ThriftPyCyClient,
    ClientPool,
)


class ClientPoolManager(object):
    def __init__(self):
        self.connection_pools = {}
        self.connection_class = ThriftPyCyClient
        self.connection_pool_class = ClientPool
        self.thrift_mappings = {}

        current_path = path.dirname(path.abspath(__file__))
        self.thrift_files = glob.glob(path.join(current_path,
                                      'draenor_thrifts', "*.thrift"))
        self.draenor_thrift = \
            dict((path.splitext(path.basename(t))[0], t) for t in self.thrift_files)

    def load_config(self, config):
        # DRAENOR_THRIFT_SETTINGS = {
            # 'dos': {
                # 'host': 'testing',
                # 'port': 27021,
            # },
            # 'dus': {
                # 'host': 'testing',
                # 'port': 27022,
            # },
            # 'dss': {
                # 'host': 'testing',
                # 'port': 27023,
            # },
            # 'src_path': '/srv/draenor',
        # }

        self.config = config
        self.load_all_services()
        self.add_connection_pool()

    def load_all_services(self):
        for service_name in self.config.keys():
            self._load_service(service_name)

    def _load_service(self, service_name):
        connection_info = self.config.get(service_name)
        if not connection_info:
            raise RuntimeError(
                'Service %s connection info not configured' % service_name
            )

        self.generate_thrift_mapping(service_name)

    def add_connection_pool(self):
        for service_name in self.thrift_mappings.keys():
            thrift = self.thrift_mappings[service_name]
            service = getattr(thrift,
                              filter(lambda name: name.endswith("Service"),
                                     thrift.__dict__.iterkeys())[0])
            self._add_connection_pool(
                service,
                self.config.get(service_name)['host'],
                self.config.get(service_name)['port'],
                name=service_name
            )

    def generate_thrift_mapping(self, service_name):
        if service_name not in self.thrift_mappings:
            sys_module_name = "%s_thrift" % service_name
            thrift_file_path = self.draenor_thrift[service_name]
            thrift = thriftpy.load(thrift_file_path, sys_module_name)
            self.thrift_mappings[service_name] = thrift

    def _add_connection_pool(self, service, host, port, timeout=30, name=None):
        if not all((service, host, port)):
            raise TypeError("Not sufficient parameters")

        pool = self.connection_pool_class(
            service=service, host=host, port=port, timeout=timeout, name=name,
            raise_empty=self.raise_empty, max_conn=self.max_conn,
            connction_class=self.connection_class, keepalive=self.keepalive,
            tracking=False,
        )

        for i in pool.keys():
            if i in self.connection_pools:
                raise KeyError("Key already registered: %s: %s" % (
                    self.connection_pools[i], i
                ))

        for i in pool.keys():
            self.connection_pools[i] = pool

    @contextlib.contextmanager
    def make_client(self, service_name):
        pool = self[service_name]
        with pool.connection_ctx() as conn:
            yield conn.client

    def __getitem__(self, name):
        if name not in self.connection_pools:
            self._load_service(name)

        pool = self.connection_pools.get(name)
        if not pool:
            raise KeyError("Service not registered: %s" % name)
        return pool
