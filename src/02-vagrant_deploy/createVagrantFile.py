import os
instructions = []

def add_proxy():
    ip = os.environ['http_proxy']
    if ip.__eq__(''):
        ip = os.environ['HTTP_PROXY']
    #print(ip)
    global instructions
    msg = "export http_proxy=\"{}\"".format(ip)
    instructions.append(msg)
    msg = "export https_proxy=\"{}\"".format(ip)
    instructions.append(msg)

def test():
    print("TEXT")

def handle_instructions(line):
    cases = ['PROXY', 'TEST']
    functions = [add_proxy, test]
    for case in cases:
        try:
            line.index(case)
            print("Encontrada coincidencia de ",case)
            index = cases.index(case)
            functions[index]()
        except:
            print("NO Encontrada coincidencia de ",case)

def parse_file():
    global instructions
    with open('Vagrantfile.skeleton') as source:
        for line in source:
            line = line.strip()
            if not line.startswith('#') and not line.__eq__('') and not line.startswith('*'):
                instructions.append(line)
            elif line.startswith('# -*-'):
                try:
                    line.index('MOCONINJA')
                    handle_instructions(line)
                except:
                    instructions.append(line)

def assemble_file():
    global instructions
    with open('Vagrantfile', 'w') as file:
        for line in instructions:
            file.write(line)
            file.write('\n')

parse_file()
assemble_file()
