#!/usr/bin/env python3

import openai
import sys
import os
import time

# Ensure you have set your OpenAI API key as an environment variable
openai.api_key = os.getenv("OPENAI_API_KEY")
client = openai.OpenAI()

def get_command(cmd, task_description):
    # Call the OpenAI API with the task description
    response = client.chat.completions.create(
        model="gpt-4",
        messages=[
            {"role":"system", "content":"You are an expert in {cmd} commands on a Linux system. Given the following English description of a task, you respond with the correct {cmd} command. Do not include any other information in your response except for the command only."},
            {"role":"user", "content":task_description},
        ],
        max_tokens=150,
        temperature=0.5
    )
    command = response.choices[0].message.content.strip()
    return command

def main():
    if len(sys.argv) < 3:
        print("Usage: g <cmd> <task_description>", file=sys.stderr)
        sys.exit(1)
    
    cmd = sys.argv[1]
    task_description = " ".join(sys.argv[2:])
    command = get_command(cmd, task_description)

    # some basic guardrails
    assert(command.startswith(f"{cmd} "))

    print(f"Executing command in 5 seconds (^C to cancel):")
    print(f"  {command}")
    print("")
    time.sleep(5)
    os.system(command)

if __name__ == "__main__":
    main()

