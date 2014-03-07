#!python
from Tkinter import *
import sys, os.path, shutil


# only when stylesheet level
def get_dw_version():
    # Read current dWVersion from dwversion.txt file
    curdir = '.'
    verfile = curdir + os.path.sep + 'dwversion.txt'
    print open(verfile).read().strip()


# Use this subroutine when you have author packages with two
# different schema/stylesheet levels.
def set_dw_version():
    # Read current dWVersion from dwversion.txt file
    pass


def copy_project_files(pname, ptype):

    #create the new project directory
    newdir = '.' + os.sep + pname
    if not os.path.isdir(newdir): os.mkdir(newdir)

    # update the template according to type
    if ptype == 3: #knowledge path
        shutil.copyfile('tools' + os.sep + 'myphoto.jpg',newdir + os.sep + 'myphoto.jpg')
        shutil.copyfile('tools' + os.sep + 'pixelruler580.gif',newdir + os.sep + 'pixelruler580.gif')
	shutil.copyfile('tools' + os.sep + 'template-dw-knowledge-path-6.0.xml',newdir + os.sep + 'index.xml')

    elif ptype == 2: #tutorial
        shutil.copyfile('tools' + os.sep + 'myphoto.jpg',newdir + os.sep + 'myphoto.jpg')
        shutil.copyfile('tools' + os.sep + 'pixelruler580.gif',newdir + os.sep + 'pixelruler580.gif')
	shutil.copyfile('tools' + os.sep + 'template-dw-tutorial-6.0.xml',newdir + os.sep + 'index.xml')
	
    elif ptype == 1: # article
        shutil.copyfile('tools' + os.sep + 'myphoto.jpg',newdir + os.sep + 'myphoto.jpg')
        shutil.copyfile('tools' + os.sep + 'pixelruler580.gif',newdir + os.sep + 'pixelruler580.gif')
	shutil.copyfile('tools' + os.sep + 'template-dw-article-6.0.xml',newdir + os.sep + 'index.xml')

    else: print 'Content type not recognized'


class MyDialog:

    def __init__(self, parent):

        top = self.top = Toplevel(parent)

        Label(top, text="Project name").pack()

        self.e = Entry(top)
        self.e.pack(padx=5)

        b = Button(top, text="OK", command=self.ok)
        b.pack(pady=5)

    def ok(self):

        print "value is", self.e.get()

        self.top.destroy()

def main():
    pass


### BUILD THE UI #############################################
root = Tk()
root.title('Author template')
master = Frame(root)
master.pack()

l = Label(master, text="Enter the name of the DIRECTORY\n you want to create for your project").pack(pady=10)

e = Entry(master)
e.pack(pady=10)
e.focus_set()

def create():
    if not len(e.get()):
        print "You didn't enter a project/directory name."
    else:
        dirname = e.get()
	copy_project_files(dirname,var.get())
        sys.exit()
    

var = IntVar()
bx = Button(master,text="Create",command=create)
bx.pack(side=RIGHT,padx=5,pady=5)

bt = Radiobutton(master, text="Tutorial", value=1, variable=var)
ba = Radiobutton(master, text="Article", value=2, variable=var)
bk = Radiobutton(master, text="Knowledge Path", value=3, variable=var)

var.set(2)
ba.pack(side=RIGHT,padx=5)
bt.pack(side=RIGHT,padx=5)
bk.pack(side=RIGHT,padx=5)


root.mainloop()
