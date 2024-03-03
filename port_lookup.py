import argparse

def main(args):
    with open(f"out/jupyter.o{args.jobid}", "r") as file:
        for line in file:
            if "http://localhost:" in line:
                port = line.split(":")[-1].strip()
                port = port.split("/")[0]
                print(f"Port number for the jupyter notebook is {port}")
                break

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Lookup port number")
    parser.add_argument("--jobid", type=int, help="Job id for the batch job for setting up the jupyter notebook")
    args = parser.parse_args()
    main(args)