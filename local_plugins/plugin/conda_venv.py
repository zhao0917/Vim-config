import sys
import os
import re
import platform


#  得到正确的版本，从而设置正确的路径
def Venv_set_python_venv(venv_base, py_ver, is_replace):

    os_platform = platform.system().lower()

    venv_paths = []

    #    平台不同，目录结构不一样
    if os_platform == 'linux':
        venv_base = os.path.join(venv_base, 'lib')

        # */lib/pythonxx.zip
        venv_paths.append(os.path.join(venv_base, 'python' +
                                       "".join(py_ver.split('.')) + '.zip'))

        venv_base = os.path.join(venv_base, 'python' + py_ver)
        # */lib/pythonx.x
        venv_paths.append(venv_base)

        # */lib/pythonx.x/lib-dynload
        venv_paths.append(os.path.join(venv_base, 'lib-dynload'))
        # */lib/pythonx.x/site-packages
        venv_paths.append(os.path.join(venv_base, 'site-packages'))
    elif os_platform == 'windows':
        venv_paths.append(venv_base)
        #    */Library/bin
        venv_paths.append(os.path.join(venv_base, 'Library', 'bin'))

        #    */Scripts
        venv_paths.append(os.path.join(venv_base, 'Scripts'))

        #    */lib/site-packages
        venv_paths.append(os.path.join(venv_base, 'lib', 'site-packages'))
    # 然后根据conda 虚拟环境是否启用来判断该替换 sys.path的前4项，还是插入4项
    if is_replace:
        if os_platform == 'linux':
            for i in range(len(venv_paths)):
                sys.path[i] = venv_paths[i]
        elif os_platform == 'windows':
            i = 0
            while i < len(sys.path) and i < 10:
                if 'python' in sys.path[i].lower():
                    del sys.path[i]
                else:
                    i += 1
            for i in range(len(venv_paths)):
                sys.path.insert(0, venv_paths[i])
    else:
        for i in range(len(venv_paths)):
            sys.path.insert(0, venv_paths[i])
