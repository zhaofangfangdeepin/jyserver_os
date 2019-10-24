#!/usr/bin/env python3
# coding=utf-8
from datetime import datetime
import os,subprocess,sys,signal,csv,time,pdb
import psutil

def windows_check(appname):
	cmd=["xdotool","search","--onlyvisible","get_desktop_for_window"]
	cmd.insert(3,appname)
	with subprocess.Popen(cmd,stdout=subprocess.PIPE,stderr=subprocess.PIPE) as p:
		p.wait()
		if p.communicate()[0] == b'0\n':
			return 0
		else:
			return 1


def check_and_kill_process(appname):
	for i in psutil.pids():
		if psutil.Process(i).name() == appname:
			os.kill(i,signal.SIGKILL)
			time.sleep(2)
def main():
	app_time = []
	with open('app_time.csv','r+') as f:
		reader=csv.reader(f)
		header_row=next(reader)
		header_row.append('第{}次启动'.format(len(header_row)))
		app_time.append(header_row)
		for row in reader:
			time.sleep(5)
			check_and_kill_process(row[0])
			starttime=datetime.now()
			with subprocess.Popen(row[0],shell=True,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL) as proc:
				while True :
					if windows_check(proc.args) == 0:
						row.append(datetime.now()-starttime)
						app_time.append(row)
						break
					else :
						continue
				proc.terminate()
				check_and_kill_process(row[0])
		f.close()
	with open('app_time.csv','w+') as f:
		try:
			writer=csv.writer(f)
			for row in app_time:
				writer.writerow(row)
		finally:
			f.close()

if __name__ == '__main__':
	main()
