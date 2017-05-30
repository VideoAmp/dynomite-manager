#!/usr/bin/env python2.7

from fabric.api import env, hosts, put, sudo
from fabric.context_managers import settings
import yaml


env.use_ssh_config = True
with open('dynomite-manager/conf/membership.yml', 'r') as membership_file:
    roles = {}
    membership_yaml = yaml.load(membership_file)
    env.roledefs = dict([(dc, [node.split(" ")[0] for rack in membership_yaml[dc] for node in membership_yaml[dc][rack]]) for dc in membership_yaml])


def status():
    sudo('curl localhost:8080/REST/v1/admin/status')


def start():
    sudo('curl localhost:8080/REST/v1/admin/start')


def stop():
    sudo('curl localhost:8080/REST/v1/admin/stop')


def startstorageprocess():
    sudo('curl localhost:8080/REST/v1/admin/startstorageprocess')


def stopstorageprocess():
    sudo('curl localhost:8080/REST/v1/admin/stopstorageprocess')


def backup():
    sudo('curl localhost:8080/REST/v1/admin/backup')


def restore():
    sudo('curl localhost:8080/REST/v1/admin/restore')


def cluster_describe():
    sudo('curl localhost:8080/REST/v1/admin/cluster_describe')


def repair():
    sudo('curl localhost:8080/REST/v1/admin/repair')


def disable_thp():
    sudo('echo never > /sys/kernel/mm/transparent_hugepage/enabled')
