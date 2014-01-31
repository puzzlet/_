#!/usr/bin/env python3.2
import logging
import os
import subprocess
import sys


IGNORE = [
    '.git',
    'deploy.cmd',
    'vendor',
    os.path.basename(__file__),
]
if sys.platform not in ['win32']:
    # vim's resolve() doesn't work for Windows' symlinks
    IGNORE.append('.vim')
SKIP_LINK = [
    '.irssi/config',
]


def main():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    for root, dirs, files in os.walk(base_dir):
        _, _, rel_root = root.partition(base_dir)
        rel_root = rel_root.strip(os.sep)
        if any(_ in rel_root.split(os.sep) for _ in IGNORE):
            continue
        for path in files:
            if path in IGNORE:
                if path in dirs:
                    dirs.remove(path)
                continue
            rel_path = os.path.join(rel_root, path)
            logging.debug(rel_path)
            make_link(rel_path)


def make_link(rel_path):
    base_dir = os.path.dirname(os.path.abspath(__file__))
    source_path = os.path.join(base_dir, rel_path)
    target_path = os.path.join(os.path.expanduser('~'), rel_path)
    target_dir = os.path.dirname(target_path)
    if os.path.isdir(target_path):
        logging.info("`{}' is a directory".format(target_path))
        return
    if os.path.isfile(target_path):
        if os.path.islink(target_path):
            link_path = os.path.join(target_dir, os.readlink(target_path))
            if link_path == source_path:
                return
            logging.info("`{}' is a symbolic link to {}".format(
                target_path, link_path))
        else:
            if open(source_path, 'rb').read() != open(target_path, 'rb').read():
                vimdiff(source_path, target_path)
            if rel_path in SKIP_LINK:
                return
            while True:
                ans = input("Keep? (Y/n) ").strip()
                if not ans or ans in 'yY':
                    return
                if ans in 'nN':
                    break
        os.unlink(target_path)
    if not os.path.exists(target_dir):
        os.makedirs(target_dir, exist_ok=True)
    os.symlink(source_path, target_path)


def vimdiff(a, b):
    cmd = []
    if sys.platform in ['win32']:
        cmd += ['C:\\Program Files (x86)\\Vim\\vim73\\gvim.exe', '-d']
    else:
        cmd += ['vimdiff']
    subprocess.check_call(cmd + [a, b])


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    main()
