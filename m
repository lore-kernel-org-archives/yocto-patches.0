Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4203.1793444097346063742
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 31 Oct 2026 03:54:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wDnatyTyOVqEokAAA--.3174S3;
	Sat, 31 Oct 2026 18:53:07 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowADnd2g5yOVqwUUpAA--.12327S3;
	Sat, 31 Oct 2026 18:51:44 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [meta-selinux][PATCH 2/2] oeqa: reach sysadm_r through newrole in the SELinux tests
Date: Sat, 31 Oct 2026 18:54:43 +0800
Message-ID: <20261031105443.1845695-2-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031105443.1845695-1-chenqi_hycx@cetc.com.cn>
References: <20261031105443.1845695-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowADnd2g5yOVqwUUpAA--.12327S3
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYRCmrkntAG-QAEsj
X-CM-DELIVERINFO: =?B?g+Cf66c9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOKTjTTQ5s7jdRVG0VsmhYxzONdRJZIhK10Xt2dOtq/nh83XIB7hhH+zLRupPhb0PNCRk
	u3JMGF2BMHtxSqX5RJ/hFsFzZ6HwMcgNdv09dTj1VAQePamXF9DTFfXWQkMlNQ==
X-Coremail-Antispam: 1Uk129KBj9fXoWfJF13KFW7Gr4kXF1UXry3WrX_yoW8Gr4xAo
	Z5Aw4kZ3WkJ3y3Cr1UKan8GrZxXF4F9F1fAws5tF4rKa4aqr1Utay8Aw15Ja43ta4xKw4D
	Xa1rGan7Jr4fJFn3l-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn5kqx4xG64xvF2IEw4CE5I8CrVC2j2Wlc2xSY4AK67AK6r4DYxn0WfAS
	r-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI
	8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJ
	M28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwAKzVCY07xG64k0F24lc2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxUFCzuDUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 10:55:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5192
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

An ssh login as root lands in staff_t with refpolicy-mcs, which cannot read
the policy store, the audit log or the kernel ring buffer, so the cases that
need those used to skip.  Run them in sysadm_r via newrole instead.

Assisted-by: Codewhale:deepseek-v4-flash
Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 lib/oeqa/runtime/cases/selinux.py | 169 +++++++++++++++++++++++-------
 1 file changed, 129 insertions(+), 40 deletions(-)

diff --git a/lib/oeqa/runtime/cases/selinux.py b/lib/oeqa/runtime/cases/selinux.py
index 2559c31..af79b39 100644
--- a/lib/oeqa/runtime/cases/selinux.py
+++ b/lib/oeqa/runtime/cases/selinux.py
@@ -18,15 +18,20 @@
 # The cases that inspect or change system state need an administrative domain
 # (sysadm_t, unconfined_t, secadm_t).  With refpolicy-mcs an ssh login as root
 # lands in staff_t, which cannot read the policy store, the audit log or the
-# kernel ring buffer, so those cases skip.  A console login as root gets
-# sysadm_r:sysadm_t; to get the same over ssh, uncomment the system_r:sshd_t
-# line in the policy's contexts/users/root.
+# kernel ring buffer, so those cases run their commands through newrole:
+#
+#     newrole -r sysadm_r -t sysadm_t -- -c '<command>'
+#
+# The '--' arguments are the arguments of the login shell newrole execs, hence
+# the -c.  This needs a root account PAM can authenticate without a prompt,
+# i.e. IMAGE_FEATURES "empty-root-password"; without that the cases skip.
 #
 # The denial, module and AVC cases additionally need a policy that confines
 # administrators (the mcs and mls variants).  The targeted and minimum variants
 # run admins as unconfined_t on purpose, so those cases skip there.
 
 import re
+import shlex
 import time
 
 from oeqa.runtime.case import OERuntimeTestCase
@@ -35,7 +40,9 @@ from oeqa.core.decorator.data import skipIfNotFeature
 from oeqa.runtime.decorator.package import OEHasPackage
 
 
-# Domains that are allowed to administer the SELinux configuration.
+# Domains that may administer SELinux.  With refpolicy-mcs an ssh login as
+# root lands in staff_t, but newrole can assume sysadm_r from there, which is
+# how the cases below reach an administrative domain on a stock image.
 ADMIN_DOMAINS = ('sysadm_t', 'unconfined_t', 'secadm_t')
 
 # Policy variants in which refpolicy confines administrators.  The targeted and
@@ -47,9 +54,14 @@ CONFINING_POLICIES = ('mcs', 'mls')
 # Name of the policy module built by SELinuxModuleTest.
 TEST_MODULE_NAME = 'oeqa-local'
 
-# Scratch directory for the policy module sources on the target.
+# Directory on the target used for scratch files and for the output files of
+# commands run through newrole.
 TEST_MODULE_DIR = '/tmp/oeqa-selinux'
 
+# newrole execs the login shell, so the command has to be given as the shell's
+# own arguments: 'newrole ... -- -c <command>', not 'newrole ... -- <command>'.
+NEWROLE = 'newrole -r sysadm_r -t sysadm_t -- -c '
+
 # Source of the test module.  It grants the administrative domain the access
 # refpolicy withholds by default, so loading and removing the module can be
 # observed with an existing file instead of needing a reboot or a relabel.
@@ -87,6 +99,10 @@ def parse_sestatus(output):
 class SELinuxTest(OERuntimeTestCase):
     """Helpers shared by the SELinux runtime cases."""
 
+    # Cached result of probing whether newrole reaches an admin domain; None
+    # until the first test asks.  Shared by all the cases.
+    _admin_domain = None
+
     def run_cmd(self, command, timeout=None):
         status, output = self.target.run(command, timeout=timeout)
         self.logger.debug('%s\n-> %d\n%s' % (command, status, output))
@@ -117,23 +133,92 @@ class SELinuxTest(OERuntimeTestCase):
 
     def require_admin(self):
         """
-        Skip unless the session runs in a domain that may administer SELinux.
+        Return the domain administrative commands run in, or skip.
 
-        staff_t and user_t can query some of the configuration, but they cannot
-        write the policy store, read the audit log or read the kernel ring
-        buffer, so tests that poke at those cannot be meaningful.
+        The session itself may already be administrative; if it is not, the
+        commands are run through newrole, which needs the root password to be
+        empty so that PAM can authenticate without a prompt.
         """
-        domain = self.selinux_domain()
-        if domain not in ADMIN_DOMAINS:
+        domain = self.admin_domain()
+        if not domain:
             self.skipTest(
                 'This test needs an administrative SELinux domain, but the '
-                'session runs as %r.  With refpolicy-mcs an ssh login as root '
-                'lands in staff_t because contexts/users/root has no '
-                'system_r:sshd_t entry; a console login gets '
-                'sysadm_r:sysadm_t.'
-                % (domain or self.process_context()))
+                'session runs as %r and newrole cannot assume sysadm_r.  '
+                'The command then needs policycoreutils-newrole installed and '
+                'a root account PAM authenticates without a prompt, i.e. '
+                'IMAGE_FEATURES "empty-root-password"'
+                % (self.selinux_domain() or self.process_context()))
         return domain
 
+    def admin_domain(self):
+        """
+        Return the domain the administrative commands end up in, or ''.
+
+        Probed once per class, because the probe costs a command round trip.
+        """
+        if self.selinux_domain() in ADMIN_DOMAINS:
+            return self.selinux_domain()
+
+        cls = type(self)
+        if cls._admin_domain is None:
+            status, output = self.run_admin('cat /proc/self/attr/current')
+            domain = ''
+            if status == 0:
+                parts = output.replace('\x00', '').strip().split(':')
+                if len(parts) > 2 and parts[2] in ADMIN_DOMAINS:
+                    domain = parts[2]
+            cls._admin_domain = domain
+            self.logger.info('newrole gives domain %r' % domain)
+        return cls._admin_domain
+
+    def _newrole(self, command):
+        """
+        Build a shell command line running `command' through newrole.
+
+        newrole's child inherits the ssh pipes, but its output is not reliably
+        readable from them, and some of the tools used here (auditctl,
+        semanage, semodule) print nothing when their stdout is a regular file.
+        So the command's output is piped through cat into a file, and the exit
+        status of the left-hand side of the pipeline is recorded with
+        PIPESTATUS.
+        """
+        redirect = ('{ %s ; } 2>&1 | cat > %s/out; echo "${PIPESTATUS[0]}" > %s/rc'
+                    % (command, TEST_MODULE_DIR, TEST_MODULE_DIR))
+        return 'mkdir -p %s; %s%s' % (TEST_MODULE_DIR, NEWROLE,
+                                      shlex.quote(redirect))
+
+    def run_admin(self, command, timeout=None):
+        """Run `command' in an administrative domain, return (status, output)."""
+        if self.selinux_domain() in ADMIN_DOMAINS:
+            return self.run_cmd(command, timeout)
+
+        self.run_cmd(self._newrole(command), timeout)
+        # The output file may not end in a newline, so emit one before the
+        # marker or the marker would be glued onto the last output line.
+        status, output = self.run_cmd(
+            "cat %s/out 2>/dev/null; echo; echo OEQA-RC; cat %s/rc 2>/dev/null"
+            % (TEST_MODULE_DIR, TEST_MODULE_DIR))
+        body, _, tail = output.rpartition('\nOEQA-RC\n')
+        body = body.replace('\x00', '')
+        try:
+            rc = int(tail.strip())
+        except ValueError:
+            # newrole itself did not run, e.g. policycoreutils-newrole is not
+            # installed; report no status rather than failing here, so that
+            # require_admin() can turn it into a skip.
+            self.logger.info('newrole did not run %r; it printed:\n%s'
+                             % (command, output))
+            return None, ''
+        self.logger.debug('newrole: %s\n-> %d\n%s' % (command, rc, body))
+        return rc, body
+
+    def run_admin_ok(self, command, timeout=None):
+        status, output = self.run_admin(command, timeout)
+        self.assertEqual(status, 0,
+                         "Command '%s' failed in the admin domain with status "
+                         "%s:\n%s" % (command, status, output))
+        return output
+
     def require_confining_policy(self):
         """
         Skip unless the loaded policy confines administrative domains.
@@ -260,7 +345,7 @@ class SELinuxToolTest(SELinuxTest):
         # domains only.
         self.require_admin()
 
-        status, output = self.run_cmd('setenforce 0')
+        status, output = self.run_admin('setenforce 0')
         self.assertEqual(status, 0,
                          'setenforce 0 failed:\n%s' % output)
         try:
@@ -271,7 +356,7 @@ class SELinuxToolTest(SELinuxTest):
                 'setenforce 0 did not reach the kernel')
         finally:
             # Never leave the target permissive behind us.
-            self.run_ok('setenforce 1')
+            self.run_admin_ok('setenforce 1')
 
         self.assertEqual(self.run_ok('getenforce').strip(), 'Enforcing',
                          'setenforce 1 did not switch back to enforcing mode')
@@ -294,7 +379,7 @@ class SELinuxToolTest(SELinuxTest):
     def test_matchpathcon_verify(self):
         # Needs getattr on shadow_t, which only the admin domains have.
         self.require_admin()
-        output = self.run_ok('matchpathcon -V /etc/shadow')
+        output = self.run_admin_ok('matchpathcon -V /etc/shadow')
         # Success is exactly "<path> verified."; a mismatch prints
         # "<path> has context ..., should be ...", so anchor the whole line
         # rather than looking for a word that other messages may contain.
@@ -309,30 +394,32 @@ class SELinuxToolTest(SELinuxTest):
         self.require_admin()
 
         # Queries.
-        output = self.run_ok('semanage login -l')
+        output = self.run_admin_ok('semanage login -l')
         self.assertIn('__default__', output,
                       'semanage login -l did not list the default mapping:\n%s'
                       % output)
-        self.run_ok('semanage boolean -l')
-        self.run_ok('semanage fcontext -l')
+        self.run_admin_ok('semanage boolean -l')
+        self.run_admin_ok('semanage fcontext -l')
 
         # Add/list/remove round trip.  -N keeps the running policy untouched;
         # the rule is committed to the local store and listed from there.
         fcontext = TEST_MODULE_DIR + '/alt(/.*)?'
         token = TEST_MODULE_DIR + '/alt'
         try:
-            self.run_ok("semanage fcontext -N -a -t tmp_t '%s'" % fcontext)
-            output = self.run_ok("semanage fcontext -l | grep -F '%s'" % token)
+            self.run_admin_ok("semanage fcontext -N -a -t tmp_t '%s'"
+                              % fcontext)
+            output = self.run_admin_ok("semanage fcontext -l | grep -F '%s'"
+                                       % token)
             self.assertIn(fcontext, output,
                           'Added fcontext rule is missing from the listing:\n%s'
                           % output)
         finally:
             # Ignore failures here so that a failed add does not mask itself
             # with a failed delete.
-            self.run_cmd("semanage fcontext -N -d '%s'" % fcontext)
+            self.run_admin("semanage fcontext -N -d '%s'" % fcontext)
 
-        status, output = self.run_cmd("semanage fcontext -l | grep -F '%s'"
-                                     % token)
+        status, output = self.run_admin("semanage fcontext -l | grep -F '%s'"
+                                        % token)
         self.assertNotEqual(status, 0,
                             'Removed fcontext rule is still listed:\n%s'
                             % output)
@@ -369,26 +456,28 @@ class SELinuxToolTest(SELinuxTest):
             self.run_ok(checkmodule)
             self.run_ok('semodule_package -o %s -m %s' % (pp, mod))
 
-            self.run_ok('semodule -i %s' % pp)
-            self.assertIn(TEST_MODULE_NAME, self.run_ok('semodule -l'),
+            self.run_admin_ok('semodule -i %s' % pp)
+            self.assertIn(TEST_MODULE_NAME, self.run_admin_ok('semodule -l'),
                           'Installed module is not listed by semodule -l')
 
             # The new rule allows the domain to read /etc/shadow.
-            status, output = self.run_cmd('cat /etc/shadow')
+            status, output = self.run_admin('cat /etc/shadow')
             self.assertEqual(status, 0,
                              'Reading /etc/shadow is still denied after loading '
                              '%s for %s:\n%s'
                              % (TEST_MODULE_NAME, domain, output))
         finally:
-            self.run_cmd('semodule -r %s' % TEST_MODULE_NAME)
+            self.run_admin('semodule -r %s' % TEST_MODULE_NAME)
 
-        output = self.run_ok('semodule -l')
+        output = self.run_admin_ok('semodule -l')
         self.assertNotIn(TEST_MODULE_NAME, output,
                          'Removed module is still listed by semodule -l:\n%s'
                          % output)
-        self.assertTrue(self.shadow_read_denied(),
-                        'Reading /etc/shadow is still allowed after removing '
-                        '%s' % TEST_MODULE_NAME)
+        status, output = self.run_admin('cat /etc/shadow')
+        self.assertNotEqual(status, 0,
+                            'Reading /etc/shadow is still allowed after '
+                            'removing %s:\n%s'
+                            % (TEST_MODULE_NAME, output))
 
 
 class SELinuxAuditTest(SELinuxTest):
@@ -418,18 +507,18 @@ class SELinuxAuditTest(SELinuxTest):
         self.require_admin()
 
         if 'systemd' in self.td.get('VIRTUAL-RUNTIME_init_manager', ''):
-            status, output = self.run_cmd('systemctl is-active auditd.service')
+            status, output = self.run_admin('systemctl is-active auditd.service')
             self.assertEqual(status, 0,
                              'auditd.service is not active:\n%s' % output)
         else:
-            self.run_ok('pidof auditd')
+            self.run_admin_ok('pidof auditd')
 
     @skipIfNotFeature('selinux', 'Test requires selinux in DISTRO_FEATURES')
     @OEHasPackage('auditd')
     @OETestDepends(['selinux.SELinuxAuditTest.test_auditd_running'])
     def test_auditctl_status(self):
         self.require_admin()
-        output = self.run_ok('auditctl -s')
+        output = self.run_admin_ok('auditctl -s')
 
         # 'enabled' is the kernel audit state: 0 = off, 1 = on,
         # 2 = on and locked until reboot.
@@ -453,8 +542,8 @@ class SELinuxAuditTest(SELinuxTest):
         # moment to flush the record it just received.
         deadline = time.time() + 15
         while True:
-            status, ausearch = self.run_cmd('ausearch -m AVC -ts recent')
-            status, dmesg = self.run_cmd('dmesg')
+            status, ausearch = self.run_admin('ausearch -m AVC -ts recent')
+            status, dmesg = self.run_admin('dmesg')
             records = '%s\n%s' % (ausearch, dmesg)
             if re.search(r'avc:\s+denied', records) and 'shadow' in records:
                 self.logger.info('AVC record found in the audit log:\n%s'
-- 
2.43.0

