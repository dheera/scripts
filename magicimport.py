import venv
import os
import sys
import importlib.util
import hashlib
import pip

def get_cache_directory():
    home_dir = os.path.expanduser('~')
    cache_dir = os.path.join(home_dir, '.magic_import')
    if not os.path.exists(cache_dir):
        os.makedirs(cache_dir)
    return cache_dir

def get_unique_subdirectory(file_path, module_name, version):
    # Create a unique subdirectory name based on the file path, module name, and version
    unique_string = f"{file_path}:{module_name}:{version}"
    unique_hash = hashlib.md5(unique_string.encode('utf-8')).hexdigest()
    return os.path.join(get_cache_directory(), unique_hash)

def create_virtualenv_and_install(venv_dir, module_name, version):
    # Create the virtual environment
    venv.create(venv_dir, with_pip=True)

    # Find the path to the virtual environment's pip executable
    if os.name == 'nt':  # Windows
        pip_executable = os.path.join(venv_dir, 'Scripts', 'pip')
    else:  # Unix/Linux/Mac
        pip_executable = os.path.join(venv_dir, 'bin', 'pip')

    # Install the specified version of the module in the virtual environment
    pip.main(['install', f"{module_name}=={version}", '--target', os.path.join(venv_dir, 'lib', f"python{sys.version_info.major}.{sys.version_info.minor}", 'site-packages')])

def import_from_virtualenv(venv_dir, module_name):
    # Construct the path to the site-packages directory of the virtual environment
    site_packages_path = os.path.join(venv_dir, 'lib', f"python{sys.version_info.major}.{sys.version_info.minor}", 'site-packages')

    # Add the site-packages directory to sys.path
    sys.path.insert(0, site_packages_path)

    # Import the module
    module = importlib.import_module(module_name)

    # Optionally, remove the site-packages directory from sys.path to clean up
    sys.path.pop(0)

    return module

def magicimport(module_name, version='latest'):
    # Get the path of the current script
    current_file_path = os.path.abspath(__file__)

    # If version is 'latest', use an empty string for the version hash part
    version_hash_part = '' if version == 'latest' else version

    # Get the unique subdirectory for this file, module, and version
    venv_dir = get_unique_subdirectory(current_file_path, module_name, version_hash_part)

    # Create the virtual environment and install the module if it doesn't already exist
    if not os.path.exists(venv_dir):
        create_virtualenv_and_install(venv_dir, module_name, version)

    # Import the module from the virtual environment
    return import_from_virtualenv(venv_dir, module_name)

# Example usage
if __name__ == "__main__":
    module_name = 'requests'  # Replace with the desired module name
    version = '2.25.1'  # Replace with the desired version, or use 'latest' for the latest version
    module = magicimport(module_name, version)
    print(module)
