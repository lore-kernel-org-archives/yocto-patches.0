Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AFCD47CA7
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 23:43:50 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.846.1768520625026140749
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 15:43:45 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60FNhbjm2408772;
	Thu, 15 Jan 2026 17:43:42 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 17/20] makewrappers: improve error handling and robustness
Date: Thu, 15 Jan 2026 17:43:33 -0600
Message-Id: <1768520616-7289-18-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 23:43:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2989

From: Mark Hatle <mark.hatle@amd.com>

Add several robustness improvements to the makewrappers Python script:

* Add null checks for self.type and arg.name to prevent AttributeError
  when processing malformed function declarations

* Add validation for comment format to ensure '=' is present before
  attempting to parse comments into dictionaries

* Replace incorrect poll() calls with returncode attribute when
  checking subprocess completion status

* Add proper file error handling with context managers (with statements)
  and OSError exceptions when reading/writing wrapper files

* Add argument validation to ensure wrapper function arguments are
  properly specified before generating code

These changes prevent crashes when processing invalid input and improve
error reporting when file operations fail.

AI-Generated: Suggested by GitHub Copilot (Claude Sonnet 4.5)

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 makewrappers | 73 ++++++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/makewrappers b/makewrappers
index c9f6ad5..326f70e 100755
--- a/makewrappers
+++ b/makewrappers
@@ -12,7 +12,6 @@ import sys
 import re
 import os.path
 import platform
-import string
 import subprocess
 from templatefile import TemplateFile
 
@@ -152,9 +151,11 @@ class Argument:
 
         # spacing between type and name, needed if type ends with a character
         # which could be part of an identifier
-        if re.match('[_a-zA-Z0-9]', self.type[-1]):
+        if self.type and re.match('[_a-zA-Z0-9]', self.type[-1]):
             self.spacer = ' '
 
+        return
+
     def decl(self, comment=False, wrap=False):
         """Produce the declaration form of this argument."""
         if self.function_pointer:
@@ -274,13 +275,13 @@ class Function:
             # ignore varargs, they never get these special treatments
             if arg.vararg:
                 pass
-            elif arg.name.endswith('dirfd'):
+            elif arg.name and arg.name.endswith('dirfd'):
                 if len(arg.name) > 5:
                     self.specific_dirfds[arg.name[:-5]] = True
                 self.dirfd = 'dirfd'
             elif arg.name == 'flags':
                 self.flags = '(flags & AT_SYMLINK_NOFOLLOW)'
-            elif arg.name.endswith('path'):
+            elif arg.name and arg.name.endswith('path'):
                 self.paths_to_munge.append(arg.name)
             elif arg.name == 'fd':
                 self.fd_arg = "fd"
@@ -304,6 +305,10 @@ class Function:
         # handle special comments, such as flags=AT_SYMLINK_NOFOLLOW
         if self.comments:
             comments = self.comments.replace('==','<equals>')
+            # Validate the comments
+            for mod in comments.split(','):
+                if '=' not in mod:
+                    raise Exception("Parse error invalid comment '%s'" % (comments))
             # Build a dictionary of key=value, key=value pairs
             modifiers = dict(mod.split("=") for mod in comments.split(','))
             # Strip all leading/trailing whitespace
@@ -535,7 +540,8 @@ additional ports to include.
         if os.path.exists(self.portfile("preports")):
             subport_proc = subprocess.Popen([self.portfile("preports"), self.name], stdout=subprocess.PIPE)
             portlist = subport_proc.communicate()[0]
-            retcode = subport_proc.poll()
+            portlist = portlist.decode("utf-8")
+            retcode = subport_proc.returncode
             if retcode:
                 raise Exception("preports script failed for port %s" % self.name)
 
@@ -546,7 +552,8 @@ additional ports to include.
         if os.path.exists(self.portfile("subports")):
             subport_proc = subprocess.Popen([self.portfile("subports"), self.name], stdout=subprocess.PIPE)
             portlist = subport_proc.communicate()[0]
-            retcode = subport_proc.poll()
+            portlist = portlist.decode("utf-8")
+            retcode = subport_proc.returncode
             if retcode:
                 raise Exception("subports script failed for port %s" % self.name)
 
@@ -622,20 +629,23 @@ def process_wrapfuncs(port):
     funcs = {}
     directory = os.path.dirname(filename)
     sys.stdout.write("%s: " % filename)
-    funclist = open(filename)
-    for line in funclist:
-        line = line.rstrip()
-        if line.startswith('#') or not line:
-            continue
-        try:
-            func = Function(port, line)
-            func.directory = directory
-            funcs[func.name] = func
-            sys.stdout.write(".")
-        except Exception as e:
-            print("Parsing failed:", e)
-            exit(1)
-    funclist.close()
+    try:
+        with open(filename, "r") as funclist:
+            for line in funclist:
+                line = line.rstrip()
+                if line.startswith('#') or not line:
+                    continue
+                try:
+                    func = Function(port, line)
+                    func.directory = directory
+                    funcs[func.name] = func
+                    sys.stdout.write(".")
+                except Exception as e:
+                    print("Parsing failed:", e)
+                    exit(1)
+    except OSError as e:
+        print("Unable to open file %s" % filename)
+        exit(1)
     print("")
     return funcs
 
@@ -645,13 +655,19 @@ def main(argv):
     sources = []
 
     for arg in argv:
+        if '=' not in arg:
+            print("Invalid argument '%s', must be of the form name=value" % arg)
+            exit(1)
         name, value = arg.split('=')
         os.environ["port_" + name] = value
 
     # error checking helpfully provided by the exception handler
-    copyright_file = open('guts/COPYRIGHT')
-    TemplateFile.copyright = copyright_file.read()
-    copyright_file.close()
+    try:
+        with open('guts/COPYRIGHT') as copyright_file:
+            TemplateFile.copyright = copyright_file.read()
+    except OSError as e:
+        print("Unable to open file guts/COPYRIGHT")
+        exit(1)
 
     for path in glob.glob('templates/*'):
         try:
@@ -665,16 +681,7 @@ def main(argv):
             print("Invalid or malformed template %s.  Aborting." % path)
             exit(1)
 
-    try:
-        port = Port('common', sources)
-
-    except KeyError:
-        print("Unknown uname -s result: '%s'." % uname_s)
-        print("Known system types are:")
-        print("%-20s %-10s %s" % ("uname -s", "port name", "description"))
-        for key in host_ports:
-            print("%-20s %-10s %s" % (key, host_ports[key],
-                                      host_descrs[host_ports[key]]))
+    port = Port('common', sources)
 
     # the per-function stuff
     print("Writing functions...")
-- 
2.43.0


