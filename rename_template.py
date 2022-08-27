import os
import sys
def replace_in_file(filepath, target, replacement):
    full_text = None
    with open(filepath, 'r') as read_file:
        full_text = read_file.read()
    with open(filepath, 'w') as write_file:
        if full_text is not None:
            corrected_text = full_text.replace(target, replacement)
            write_file.write(corrected_text)

if __name__ == '__main__':
    new_name = sys.argv[1]
    old_name = sys.argv[2] if len(sys.argv) > 2 else "project"
    replace_in_file("{}/bin/dune".format(old_name), old_name, new_name)
    replace_in_file("{}/dune-project".format(old_name), "name {}".format(old_name), "name {}".format(new_name))
    os.rename(old_name, new_name)