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
        conda_base_win = get_conda_base_dir_win(venv_base)
        if conda_base_win != "":
            venv_paths.append(os.path.join(conda_base_win, 'Library', 'bin'))
            venv_paths.append(os.path.join(
                conda_base_win, 'Library', 'mingw-w64', 'bin'))
            conda_base_win = os.path.join(
                conda_base_win, 'lib', 'site-packages')
            venv_paths.append(conda_base_win)
            venv_paths.append(os.path.join(conda_base_win, 'win32'))
            venv_paths.append(os.path.join(conda_base_win, 'win32', 'lib'))
            venv_paths.append(os.path.join(conda_base_win, 'pythonwin'))

        venv_paths.append(venv_base)

        venv_paths.append(os.path.join(venv_base, 'bin'))
        venv_paths.append(os.path.join(venv_base, 'DLLs'))
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
            while i < len(sys.path):
                if 'python' in sys.path[i].lower():
                    del sys.path[i]
                else:
                    i += 1
            for i in range(len(venv_paths)):
                sys.path.insert(0, venv_paths[i])
    else:
        for i in range(len(venv_paths)):
            sys.path.insert(0, venv_paths[i])


def get_conda_base_dir_win(venv_base):
    venv_base = venv_base.split("\\")
    is_find = -1
    for i in range(len(venv_base)):
        if venv_base[i] == 'envs':
            is_find = i
            break
    if is_find >= 0:
        return "\\".join(venv_base[:is_find])
    else:
        return ""
