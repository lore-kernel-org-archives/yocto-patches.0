Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20383.1794797800727885700
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Nov 2026 18:56:41 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wBXXKRpcPpqZ9QAAA--.983S3;
	Mon, 16 Nov 2026 10:54:33 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowABn+WnccPpqPNA3AA--.14039S6;
	Mon, 16 Nov 2026 10:56:37 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [PATCH 4/6] oeqa: decide the SELinux cases on the domain, not the policy name
Date: Mon, 16 Nov 2026 10:56:18 +0800
Message-ID: <20261116025620.2558594-5-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116025620.2558594-1-chenqi_hycx@cetc.com.cn>
References: <20261116025620.2558594-1-chenqi_hycx@cetc.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowABn+WnccPpqPNA3AA--.14039S6
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYNCmr5tRgQJwAAsK
X-CM-DELIVERINFO: =?B?iEfg5ac9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoONahKFcN3sR551ZGDSnKFd+z9ZEHcoFr0Ks4/O1So4K7w6xTdwCCCiTY/98Br6F5tuGL
	UsKlFSDEFfYYBh1W0Xh5aRBlGnxz2xTFyYapbkYPjiCkXy4MjAfzC1aLS5q5iw==
X-Coremail-Antispam: 1Uk129KBj9fXoWfAFWfZF4fCw48JryUXFW8GrX_yoW5CF13Zo
	Z3Gw40v3W8tr1fCr1DKan8GrZ5Xa45Zr1fArn8XrWrta9FqryUKayUJwnxAay3A3WIqwnI
	q3Z3Xr4xXFs3trn3l-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn5kqx4xG64xvF2IEw4CE5I8CrVC2j2Wlc2xSY4AK67AK6r4UYxn0WfAS
	r-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI
	8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJ
	M28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2I
	x0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xv
	wVC2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwAKzVCY07xG64k0F24lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxU7UUUUUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 02:56:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5401
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

The denial and module cases skipped on refpolicy-targeted because they decided
from the policy name that administrators are unconfined there, and assumed an
ssh login as root is confined elsewhere.  The installed policy decides, not its
name: an ssh login as root is staff_t on refpolicy-standard, -mcs and -mls, and
unconfined_t on -targeted and -minimum.

Decide on the domain read from /proc/self/attr/current.  Skip the shadow case on
unconfined_t alone: sysadm_t and secadm_t may only getattr and relabel shadow_t,
so they are denied the read just as staff_t is, and only unconfined_t is allowed
it.

Where the session has no confined domain, log in as a test account mapped to
user_u so that pam_selinux puts it in user_t; su cannot stand in for that, as
pam_selinux is not in its PAM stack.

The denial is provoked by reading a world-readable file whose label the policy
withholds.  /etc/shadow does not work for that: it is 0400, so a confined
non-root session is stopped by the file mode and no AVC record is written, and
refpolicy dontaudits staff_t reading shadow_t.  The cases verify the mode, the
label and the denial instead of assuming them.

Verified on qemux86-64 and qemuarm64 with refpolicy-targeted (14 passed, 1
skipped) and refpolicy-mcs (15 passed), checking the installed refpolicy
package in the image manifest each time.

Assisted-by: Codewhale:deepseek-v4-flash
Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 lib/oeqa/runtime/cases/selinux.py | 543 ++++++++++++++++++++++++------
 1 file changed, 431 insertions(+), 112 deletions(-)

diff --git a/lib/oeqa/runtime/cases/selinux.py b/lib/oeqa/runtime/cases/selinux.py
index af79b39..c238532 100644
--- a/lib/oeqa/runtime/cases/selinux.py
+++ b/lib/oeqa/runtime/cases/selinux.py
@@ -15,21 +15,50 @@
 # packagegroup-core-selinux (as core-image-selinux does) satisfies the package,
 # feature and kernel requirements of all of them.
 #
-# The cases that inspect or change system state need an administrative domain
-# (sysadm_t, unconfined_t, secadm_t).  With refpolicy-mcs an ssh login as root
-# lands in staff_t, which cannot read the policy store, the audit log or the
-# kernel ring buffer, so those cases run their commands through newrole:
+# Two domains matter here, and the cases pick whichever one lets them observe
+# what they assert:
 #
-#     newrole -r sysadm_r -t sysadm_t -- -c '<command>'
+#   administrative  Needed to inspect or change system state: the policy store,
+#                   the audit log, the kernel ring buffer, setenforce.  The
+#                   cases use the session's own domain when it is one, and
+#                   otherwise switch with newrole:
 #
-# The '--' arguments are the arguments of the login shell newrole execs, hence
-# the -c.  This needs a root account PAM can authenticate without a prompt,
-# i.e. IMAGE_FEATURES "empty-root-password"; without that the cases skip.
+#                       newrole -r sysadm_r -t sysadm_t -- -c '<command>'
 #
-# The denial, module and AVC cases additionally need a policy that confines
-# administrators (the mcs and mls variants).  The targeted and minimum variants
-# run admins as unconfined_t on purpose, so those cases skip there.
-
+#                   The '--' arguments are those of the login shell newrole
+#                   execs, hence the -c.  Switching needs a root account PAM can
+#                   authenticate without a prompt, i.e. IMAGE_FEATURES
+#                   "empty-root-password"; without that the cases skip.
+#
+#   confined        Needed to assert that an access is denied.  A domain only
+#                   counts as confined here if the policy also withholds the
+#                   administrative accesses above; the two are the same thing in
+#                   practice, since refpolicy grants both to the domains in
+#                   ADMIN_DOMAINS and neither to a restricted user domain.
+#
+# Which domain the ssh session lands in depends on the policy variant, not on
+# anything the session can choose:
+#
+#   refpolicy-targeted, -minimum   unconfined_t.  Their recipes make
+#                                  unconfined_u the default SELinux user and
+#                                  give administrators unconfined_t on purpose,
+#                                  "the same access as if SELinux was not
+#                                  enabled".
+#
+#   refpolicy-standard, -mcs, -mls staff_t.  root's SELinux user lists staff_r
+#                                  first and pam_selinux picks the first role,
+#                                  so the login is confined even though the user
+#                                  is uid 0.  newrole then reaches sysadm_t.
+#
+# The cases therefore never test for a policy name; they read the domain from
+# /proc/self/attr/current and decide from that.  A denial needs a confined
+# domain, so on the unconfined variants the cases fall back to logging in as a
+# test account mapped to the SELinux user user_u, which pam_selinux puts in
+# user_t - the restricted-user domain that the policy does confine.  Note that
+# su cannot be used for this: pam_selinux is not in its PAM stack, so it leaves
+# the caller's context alone and ssh is the only login here that relabels.
+
+import os.path
 import re
 import shlex
 import time
@@ -40,18 +69,42 @@ from oeqa.core.decorator.data import skipIfNotFeature
 from oeqa.runtime.decorator.package import OEHasPackage
 
 
-# Domains that may administer SELinux.  With refpolicy-mcs an ssh login as
-# root lands in staff_t, but newrole can assume sysadm_r from there, which is
-# how the cases below reach an administrative domain on a stock image.
+# Domains that may administer SELinux.  refpolicy grants these the policy
+# store, the audit log, the kernel ring buffer and setenforce, and it grants
+# nobody else; a session in one of them is also allowed everything the denial
+# cases try to observe, so it cannot serve as their confined side.
+#
+# Being an administrative domain does not mean being unconfined: staff_t is not
+# one of these, and sysadm_t and secadm_t are confined for most objects.  In
+# particular none of the three may read shadow_t.
 ADMIN_DOMAINS = ('sysadm_t', 'unconfined_t', 'secadm_t')
 
-# Policy variants in which refpolicy confines administrators.  The targeted and
-# minimum variants deliberately run administrators as unconfined_t, with the
-# same access as if SELinux were disabled (see refpolicy-targeted_git.bb), so
-# the checks below that rely on an access being denied only apply here.
-CONFINING_POLICIES = ('mcs', 'mls')
+# Domains the policy deliberately leaves unconfined, with the access the caller
+# would have with SELinux disabled.  refpolicy-targeted and -minimum make
+# unconfined_u the default SELinux user for that reason, so a denial cannot be
+# asserted against a session in this domain.
+UNCONFINED_DOMAINS = ('unconfined_t',)
 
-# Name of the policy module built by SELinuxModuleTest.
+# Files the denial cases read, most likely first.  Each has to be readable by
+# every user, so that a refusal cannot be the discretionary permissions, and
+# carry a label restricted users may not read.  /var/log/messages is 0644
+# var_log_t, and refpolicy allows no restricted user domain to read var_log_t.
+#
+# A dontaudited denial is no good here: /etc/shadow would be the obvious choice
+# for "root is denied this", but refpolicy has
+# 'dontaudit staff_t shadow_t:file { getattr ioctl lock open read }', so that
+# denial is deliberately kept out of the audit log and no AVC record can be
+# observed for it.
+PROBE_PATHS = ('/var/log/messages', '/var/log/syslog')
+
+# Account logged in as when the session itself is unconfined.  Its SELinux user
+# is a restricted one, so pam_selinux puts the session in user_t.
+CONFINED_USER = 'oeqa_selinux'
+CONFINED_SELINUX_USER = 'user_u'
+
+# Name of the policy module built by
+# SELinuxToolTest.test_semodule_load_remove.  checkmodule requires it to match
+# the basename of the file it compiles.
 TEST_MODULE_NAME = 'oeqa-local'
 
 # Directory on the target used for scratch files and for the output files of
@@ -62,19 +115,25 @@ TEST_MODULE_DIR = '/tmp/oeqa-selinux'
 # own arguments: 'newrole ... -- -c <command>', not 'newrole ... -- <command>'.
 NEWROLE = 'newrole -r sysadm_r -t sysadm_t -- -c '
 
-# Source of the test module.  It grants the administrative domain the access
-# refpolicy withholds by default, so loading and removing the module can be
-# observed with an existing file instead of needing a reboot or a relabel.
+# ssh options that keep a loopback login quiet and non-interactive.
+SSH_OPTIONS = ('-n -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null '
+               '-o LogLevel=ERROR')
+
+# Source of the test module.  It grants the confined domain one access the
+# policy withholds, so that loading and removing the module can be observed on
+# an existing file instead of needing a reboot or a relabel.  Both the domain
+# and the label are taken from the target, so the module follows a relabelled
+# image instead of hard-coding a type.
 TEST_MODULE_TE = """\
 module %(module)s 1.0;
 
 require {
     type %(domain)s;
-    type shadow_t;
+    type %(type)s;
     class file { getattr open read };
 }
 
-allow %(domain)s shadow_t:file { getattr open read };
+allow %(domain)s %(type)s:file { getattr open read };
 """
 
 
@@ -96,12 +155,26 @@ def parse_sestatus(output):
     return info
 
 
+def context_type(context):
+    """Return the type component of an SELinux context, or ''."""
+    # A login through pam_selinux may print warnings before the context it
+    # ends up in, so take the last line that looks like a context rather than
+    # the first one.
+    for line in reversed(context.replace('\x00', '').splitlines()):
+        parts = line.strip().split(':')
+        if len(parts) >= 3 and parts[2]:
+            return parts[2]
+    return ''
+
+
 class SELinuxTest(OERuntimeTestCase):
     """Helpers shared by the SELinux runtime cases."""
 
-    # Cached result of probing whether newrole reaches an admin domain; None
-    # until the first test asks.  Shared by all the cases.
+    # Cached results of the probes below; None until a test asks for them.
+    # Shared by all the cases, because each probe costs command round trips.
     _admin_domain = None
+    _confined_domain = None
+    _probe_path = None
 
     def run_cmd(self, command, timeout=None):
         status, output = self.target.run(command, timeout=timeout)
@@ -128,16 +201,27 @@ class SELinuxTest(OERuntimeTestCase):
 
     def selinux_domain(self):
         """Return the type component of the session's SELinux context."""
-        parts = self.process_context().split(':')
-        return parts[2] if len(parts) > 2 else ''
+        return context_type(self.process_context())
+
+    def is_admin_domain(self, domain):
+        """Return whether `domain' may administer SELinux."""
+        return domain in ADMIN_DOMAINS
+
+    def is_unconfined_domain(self, domain):
+        """Return whether the policy leaves `domain' unconfined on purpose."""
+        return domain in UNCONFINED_DOMAINS
+
+    #
+    # Running commands in an administrative domain.
+    #
 
     def require_admin(self):
         """
         Return the domain administrative commands run in, or skip.
 
         The session itself may already be administrative; if it is not, the
-        commands are run through newrole, which needs the root password to be
-        empty so that PAM can authenticate without a prompt.
+        commands run through newrole, which needs the root password to be empty
+        so that PAM can authenticate without a prompt.
         """
         domain = self.admin_domain()
         if not domain:
@@ -151,12 +235,8 @@ class SELinuxTest(OERuntimeTestCase):
         return domain
 
     def admin_domain(self):
-        """
-        Return the domain the administrative commands end up in, or ''.
-
-        Probed once per class, because the probe costs a command round trip.
-        """
-        if self.selinux_domain() in ADMIN_DOMAINS:
+        """Return the domain the administrative commands end up in, or ''."""
+        if self.is_admin_domain(self.selinux_domain()):
             return self.selinux_domain()
 
         cls = type(self)
@@ -164,9 +244,9 @@ class SELinuxTest(OERuntimeTestCase):
             status, output = self.run_admin('cat /proc/self/attr/current')
             domain = ''
             if status == 0:
-                parts = output.replace('\x00', '').strip().split(':')
-                if len(parts) > 2 and parts[2] in ADMIN_DOMAINS:
-                    domain = parts[2]
+                candidate = context_type(output)
+                if self.is_admin_domain(candidate):
+                    domain = candidate
             cls._admin_domain = domain
             self.logger.info('newrole gives domain %r' % domain)
         return cls._admin_domain
@@ -189,7 +269,7 @@ class SELinuxTest(OERuntimeTestCase):
 
     def run_admin(self, command, timeout=None):
         """Run `command' in an administrative domain, return (status, output)."""
-        if self.selinux_domain() in ADMIN_DOMAINS:
+        if self.is_admin_domain(self.selinux_domain()):
             return self.run_cmd(command, timeout)
 
         self.run_cmd(self._newrole(command), timeout)
@@ -213,42 +293,195 @@ class SELinuxTest(OERuntimeTestCase):
         return rc, body
 
     def run_admin_ok(self, command, timeout=None):
-        status, output = self.run_admin(command, timeout)
+        status, output = self.run_admin(command, timeout=timeout)
         self.assertEqual(status, 0,
                          "Command '%s' failed in the admin domain with status "
                          "%s:\n%s" % (command, status, output))
         return output
 
-    def require_confining_policy(self):
+    #
+    # Running commands in a confined domain.
+    #
+
+    def require_confined(self):
+        """Return a confined domain to assert a denial in, or skip."""
+        domain = self.confined_domain()
+        if not domain:
+            self.skipTest('This test needs a confined non-administrative '
+                          'SELinux domain, but the session runs as %r and no '
+                          'confined login could be set up'
+                          % (self.selinux_domain()
+                             or self.process_context()))
+        return domain
+
+    def confined_domain(self):
+        """Return the confined domain a denial can be asserted in, or ''."""
+        if self.selinux_domain() and not self.is_admin_domain(
+                self.selinux_domain()):
+            # The session is already a restricted user domain, which is what an
+            # ssh login as root gives on the confining policy variants.
+            return self.selinux_domain()
+
+        cls = type(self)
+        if cls._confined_domain is None:
+            cls._confined_domain = self.setup_confined_login()
+            self.logger.info('confined login gives domain %r'
+                             % cls._confined_domain)
+        return cls._confined_domain
+
+    def setup_confined_login(self):
         """
-        Skip unless the loaded policy confines administrative domains.
+        Log in as a confined user, return its domain or ''.
 
-        The refpolicy-targeted and -minimum variants explicitly give admins
-        unconfined_t, so on those images an access such as reading /etc/shadow
-        is deliberately allowed and cannot be tested for denial.
+        Used on the variants that run administrators as unconfined_t, where the
+        session has no confined domain to offer.  A login that goes through
+        pam_selinux is what relabels the session, and ssh is the only one of
+        those available on a minimal image, so the account is reached over
+        loopback ssh.
         """
-        info = self.sestatus()
-        policy = info.get('Loaded policy name')
-        if policy not in CONFINING_POLICIES:
-            self.skipTest('Test expects a confining policy (%s), but %r is '
-                          'loaded; targeted and minimum run administrators '
-                          'unconfined on purpose'
-                          % ('/'.join(CONFINING_POLICIES), policy))
+        if not self.admin_domain():
+            self.logger.info('no administrative domain, so a confined login '
+                             'cannot be set up')
+            return ''
+        if self.run_cmd('pidof sshd')[0] != 0:
+            self.logger.info('sshd is not running, so a confined login cannot '
+                             'be made')
+            return ''
 
-    def write_file(self, path, content):
-        self.run_ok('mkdir -p %s' % path.rsplit('/', 1)[0])
-        self.run_ok("cat > %s << 'OEQA_EOF'\n%sOEQA_EOF" % (path, content))
+        if self.run_cmd('id %s' % CONFINED_USER)[0] != 0:
+            status, output = self.run_cmd(
+                'adduser -D -s /bin/sh %s' % CONFINED_USER)
+            if status != 0:
+                self.logger.info('cannot create %s:\n%s'
+                                 % (CONFINED_USER, output))
+                return ''
+
+        # pam_selinux labels the session, but only for an account PAM
+        # authenticates without asking.  sshd then accepts the empty password
+        # because sshd_config sets PermitEmptyPasswords.
+        self.run_cmd('passwd -d %s' % CONFINED_USER)
+
+        if self.run_admin('semanage login -a -s %s %s'
+                          % (CONFINED_SELINUX_USER, CONFINED_USER))[0] != 0:
+            # -m updates the mapping a previous run left behind.
+            self.run_admin('semanage login -m -s %s %s'
+                           % (CONFINED_SELINUX_USER, CONFINED_USER))
+
+        status, output = self.run_cmd('%s -l %s 127.0.0.1 -- id -Z'
+                                      % (self.ssh(), CONFINED_USER))
+        if status != 0:
+            self.logger.info('cannot log in as %s:\n%s'
+                             % (CONFINED_USER, output))
+            return ''
+        domain = context_type(output)
+        if not domain or self.is_admin_domain(domain):
+            # Nothing was gained: the policy left this login unconfined too.
+            self.logger.info('%s logs in as %r, which is not confined'
+                             % (CONFINED_USER, domain or '?'))
+            return ''
+        return domain
 
-    def shadow_read_denied(self):
-        """Return True when reading /etc/shadow is blocked by SELinux."""
-        status, output = self.run_cmd('cat /etc/shadow')
-        return status != 0 and 'Permission denied' in output
+    def ssh(self):
+        """Return the ssh command line used for loopback logins."""
+        return 'ssh %s' % SSH_OPTIONS
+
+    def run_confined(self, command, timeout=None):
+        """Run `command' in the confined domain, return (status, output)."""
+        if self.confined_domain() == self.selinux_domain():
+            return self.run_cmd(command, timeout)
+        return self.run_cmd('%s -l %s 127.0.0.1 -- %s'
+                            % (self.ssh(), CONFINED_USER, shlex.quote(command)),
+                            timeout)
+
+    def probe_path(self):
+        """
+        Return a world-readable file the confined domain may not read, or ''.
+
+        Candidates are tried in turn and the first one that exists, is readable
+        by every user and whose label the policy withholds is used.  Anything
+        else would make a case assert a policy denial while what it is looking
+        at is a permission check that SELinux never sees.
+        """
+        cls = type(self)
+        if cls._probe_path is not None:
+            return cls._probe_path
+
+        cls._probe_path = ''
+        domain = self.confined_domain()
+        if not domain:
+            return ''
+
+        for path in PROBE_PATHS:
+            # The mode is a property of the file, so read it where the policy
+            # raises no obstacle; a confined domain may be denied even the
+            # stat, which would say nothing about the file's permissions.
+            status, output = self.run_admin('stat -c %%A %s' % path)
+            if status != 0:
+                continue
+            # '-rw-r--r--': index 7 is the read bit for everyone else.
+            mode = output.strip()
+            if len(mode) < 10 or mode[7] != 'r':
+                self.logger.info('%s is not world readable' % path)
+                continue
+            status, output = self.run_confined('cat %s' % path)
+            if status == 0:
+                self.logger.info('%r may read %s' % (domain, path))
+                continue
+            if 'Permission denied' not in output:
+                self.logger.info('%r cannot read %s for another reason: %s'
+                                 % (domain, path, output.strip()))
+                continue
+            self.logger.info('%r is denied reading %s' % (domain, path))
+            cls._probe_path = path
+            break
+        return cls._probe_path
+
+    def probe_label(self):
+        """Return the type of the probe file's label, or ''."""
+        status, output = self.run_admin('stat -c %%C %s' % self.probe_path())
+        return context_type(output) if status == 0 else ''
+
+    def probe_read(self):
+        """Read the probe file in the confined domain, return (status, output)."""
+        return self.run_confined('cat %s' % self.probe_path())
+
+    def require_probe_denial(self):
+        """
+        Return the confined domain and the probe file's label type, or skip.
+
+        Both are verified rather than assumed: the cases need the policy to
+        withhold the file, so that loading a module can be seen lifting that,
+        and the module needs the file's actual type.
+        """
+        domain = self.require_confined()
 
-    def require_shadow_denial(self):
-        """Skip unless reading /etc/shadow is blocked, as this test needs it."""
-        if not self.shadow_read_denied():
-            self.skipTest('Reading /etc/shadow is allowed, so this test has '
-                          'no denied access to work with')
+        path = self.probe_path()
+        if not path:
+            self.skipTest('None of %s is a world-readable file that the policy '
+                          'denies %r, so there is no denial to observe'
+                          % (', '.join(PROBE_PATHS), domain))
+
+        type_ = self.probe_label()
+        if not type_:
+            self.skipTest('Cannot read the SELinux label of %s' % path)
+
+        status, output = self.probe_read()
+        self.assertNotEqual(
+            status, 0,
+            'Reading %s as %s was allowed; the policy no longer denies it:\n%s'
+            % (path, domain, output))
+        self.assertIn('Permission denied', output,
+                      'Reading %s as %s failed for a reason other than an '
+                      'SELinux denial:\n%s' % (path, domain, output))
+        return domain, type_
+
+    #
+    # Miscellaneous helpers.
+    #
+
+    def write_file(self, path, content):
+        self.run_ok('mkdir -p %s' % os.path.dirname(path))
+        self.run_ok("cat > %s << 'OEQA_EOF'\n%sOEQA_EOF" % (path, content))
 
     def memtotal_mb(self):
         """Return the target's total RAM in MB, or None if it cannot tell."""
@@ -294,19 +527,47 @@ class SELinuxStatusTest(SELinuxTest):
 
 
 class SELinuxDenialTest(SELinuxTest):
-    """Access that the policy denies must be denied."""
+    """A confined root must be denied files that only the policy withholds."""
 
     @skipIfNotFeature('selinux', 'Test requires selinux in DISTRO_FEATURES')
     @OEHasPackage('policycoreutils-sestatus')
     @OETestDepends(['selinux.SELinuxStatusTest.test_kernel_enforcing'])
     def test_read_shadow_denied(self):
-        # /etc/shadow is readable by root alone, so a failure to read it cannot
-        # be a plain permission problem: it is the policy withholding
-        # shadow_t:file from the confined session domain.  staff_t is confined
-        # just as sysadm_t is, so this runs for either.
-        self.require_confining_policy()
-        context = self.process_context()
+        # /etc/shadow is 0400 and owned by root, so a session that is uid 0 and
+        # still cannot read it was not stopped by the discretionary
+        # permissions: it is the policy withholding shadow_t:file.  Both halves
+        # of that matter, and neither can be arranged on every variant:
+        #
+        #   - It has to be the session itself, because a confined login as a
+        #     non-root account would be refused by the file mode alone and the
+        #     test would then pass without SELinux having decided anything.
+        #   - The session has to be confined rather than unconfined, which an
+        #     ssh login as root is on refpolicy-standard, -mcs and -mls
+        #     (staff_t), but not on refpolicy-targeted and -minimum, where
+        #     administrators run as unconfined_t by design and reading the file
+        #     is allowed.  Note that being an administrative domain is not the
+        #     same test: staff_t is not one and is still confined, while
+        #     sysadm_t and secadm_t are ones and are denied shadow_t as well.
+        #
+        # So this case skips on the variants whose policy has no confined
+        # administrator.  The confidential data of a confined *user* is covered
+        # by test_avc_recorded, which does not need the session to be root.
+        domain = self.selinux_domain()
+        if not domain:
+            self.skipTest('Cannot determine the SELinux domain of the session')
+        if self.is_unconfined_domain(domain):
+            self.skipTest('The session runs as unconfined %r: this variant '
+                          'gives administrators the access they would have '
+                          'with SELinux disabled, so there is no denial to '
+                          'assert' % domain)
+
+        status, output = self.run_cmd('id -u')
+        self.assertEqual(output.strip(), '0',
+                         'The session is not root, so /etc/shadow is denied by '
+                         'its file mode rather than by the policy; the denial '
+                         'would prove nothing')
 
+        context = self.process_context()
         status, output = self.run_cmd('cat /etc/shadow')
         self.assertNotEqual(
             status, 0,
@@ -428,11 +689,14 @@ class SELinuxToolTest(SELinuxTest):
     @OEHasPackage('policycoreutils-semodule')
     @OEHasPackage('checkpolicy')
     @OEHasPackage('semodule-utils-semodule-package')
-    @OETestDepends(['selinux.SELinuxToolTest.test_matchpathcon'])
+    @OETestDepends(['selinux.SELinuxStatusTest.test_kernel_enforcing'])
     def test_semodule_load_remove(self):
-        self.require_confining_policy()
-        domain = self.require_admin()
-        self.require_shadow_denial()
+        # The module grants the confined domain a read the policy withholds, so
+        # both loading and removing it are observable without a reboot.  Which
+        # domain that is depends on the variant, but it only has to be a
+        # confined one, never the session's as such.
+        domain, type_ = self.require_probe_denial()
+        path = self.probe_path()
 
         # semodule re-expands the whole policy, which does not fit on a small
         # qemu guest: it gets OOM-killed rather than reporting an error.
@@ -451,33 +715,32 @@ class SELinuxToolTest(SELinuxTest):
         checkmodule = 'checkmodule -m %s-o %s %s' % ('-M ' if mls else '', mod, te)
 
         self.write_file(te, TEST_MODULE_TE % {'module': TEST_MODULE_NAME,
-                                              'domain': domain})
+                                              'domain': domain,
+                                              'type': type_})
         try:
             self.run_ok(checkmodule)
             self.run_ok('semodule_package -o %s -m %s' % (pp, mod))
 
-            self.run_admin_ok('semodule -i %s' % pp)
-            self.assertIn(TEST_MODULE_NAME, self.run_admin_ok('semodule -l'),
+            self.run_admin_ok('semodule -i %s' % pp, timeout=300)
+            self.assertIn(TEST_MODULE_NAME,
+                          self.run_admin_ok('semodule -l', timeout=120),
                           'Installed module is not listed by semodule -l')
 
-            # The new rule allows the domain to read /etc/shadow.
-            status, output = self.run_admin('cat /etc/shadow')
+            status, output = self.probe_read()
             self.assertEqual(status, 0,
-                             'Reading /etc/shadow is still denied after loading '
-                             '%s for %s:\n%s'
-                             % (TEST_MODULE_NAME, domain, output))
+                             'Reading %s is still denied after loading %s for '
+                             '%s:\n%s' % (path, TEST_MODULE_NAME, domain, output))
         finally:
-            self.run_admin('semodule -r %s' % TEST_MODULE_NAME)
+            self.run_admin('semodule -r %s' % TEST_MODULE_NAME, timeout=300)
 
-        output = self.run_admin_ok('semodule -l')
+        output = self.run_admin_ok('semodule -l', timeout=120)
         self.assertNotIn(TEST_MODULE_NAME, output,
                          'Removed module is still listed by semodule -l:\n%s'
                          % output)
-        status, output = self.run_admin('cat /etc/shadow')
+        status, output = self.probe_read()
         self.assertNotEqual(status, 0,
-                            'Reading /etc/shadow is still allowed after '
-                            'removing %s:\n%s'
-                            % (TEST_MODULE_NAME, output))
+                            'Reading %s is still allowed after removing %s:\n%s'
+                            % (path, TEST_MODULE_NAME, output))
 
 
 class SELinuxAuditTest(SELinuxTest):
@@ -530,30 +793,86 @@ class SELinuxAuditTest(SELinuxTest):
 
     @skipIfNotFeature('selinux', 'Test requires selinux in DISTRO_FEATURES')
     @OEHasPackage('auditd')
-    @OETestDepends(['selinux.SELinuxDenialTest.test_read_shadow_denied'])
+    @OETestDepends(['selinux.SELinuxAuditTest.test_auditctl_status'])
     def test_avc_recorded(self):
-        self.require_admin()
+        # The denial is provoked here rather than borrowed from another case,
+        # so that the record is written moments before it is looked for and
+        # comes from a confined domain on every variant that has one.
+        domain, _ = self.require_probe_denial()
+        path = self.probe_path()
 
-        # The denied read of /etc/shadow, asserted by the test this depends on,
-        # is the event whose record is looked for below.
+        source = self.avc_source()
+        before = self.avc_records(domain, source)
 
-        # AVC records reach the audit log when auditd is consuming them and
-        # the kernel ring buffer otherwise; accept either, but give auditd a
-        # moment to flush the record it just received.
-        deadline = time.time() + 15
+        status, output = self.probe_read()
+        self.assertNotEqual(status, 0,
+                            'Reading %s as %s was allowed, so no AVC record '
+                            'can be expected:\n%s' % (path, domain, output))
+
+        # Compare record sets rather than asking for records since a timestamp:
+        # the audit ids are unique, so the difference is exactly what this
+        # denial added, and a rolling '-ts recent' window cannot hide it.
+        record = ''
+        deadline = time.time() + 30
         while True:
-            status, ausearch = self.run_admin('ausearch -m AVC -ts recent')
-            status, dmesg = self.run_admin('dmesg')
-            records = '%s\n%s' % (ausearch, dmesg)
-            if re.search(r'avc:\s+denied', records) and 'shadow' in records:
-                self.logger.info('AVC record found in the audit log:\n%s'
-                                 % ausearch.strip())
-                return
+            # Give auditd a moment to flush the record before looking.
+            time.sleep(2)
+            fresh = self.avc_records(domain, source) - before
+            if fresh:
+                record = '\n'.join(sorted(fresh))
+                self.logger.info('AVC record found in the %s:\n%s'
+                                 % (source, record))
+                break
             if time.time() >= deadline:
                 break
-            time.sleep(3)
 
-        self.fail('No AVC record for the denied read of /etc/shadow was found '
-                  'in the audit log or the kernel ring buffer.\n'
-                  'ausearch:\n%s\ndmesg (tail):\n%s'
-                  % (ausearch, '\n'.join(dmesg.splitlines()[-20:])))
+        self.assertTrue(
+            record,
+            'No AVC record for the denied read of %s as %s appeared in the '
+            '%s after 30s.\nRecords for the domain already present:\n%s'
+            % (path, domain, source,
+               '\n'.join(sorted(self.avc_records(domain, source))[-10:])))
+
+    def avc_source(self):
+        """Return where the kernel's audit records can be read from."""
+        # Ask in the admin domain: a confined session is not allowed to see
+        # whether auditd runs, and mistaking that for 'auditd is absent' sends
+        # the search to the ring buffer, which holds no record while auditd is
+        # consuming them.
+        if self.run_admin('pidof auditd')[0] == 0:
+            return 'audit log'
+        return 'kernel ring buffer'
+
+    def audit_log(self):
+        """Return the file auditd writes to, as configured."""
+        # auditd.conf is only readable in an administrative domain.
+        output = self.run_admin_ok(
+            "sed -n 's/^[[:space:]]*log_file[[:space:]]*=[[:space:]]*//p' "
+            '/etc/audit/auditd.conf')
+        return output.strip() or '/var/log/audit/audit.log'
+
+    def avc_records(self, domain, source):
+        """Return the audit records the kernel wrote for `domain' as a set."""
+        # Narrow the selection on the target, since the audit log holds
+        # thousands of records; repeat the filter in Python so that the match
+        # does not depend on how grep splits the fields.
+        marker = ':%s:' % domain
+        basename = os.path.basename(self.probe_path())
+        if source == 'audit log':
+            # Name the log file: ausearch reads its input from stdin when stdin
+            # is /dev/null, which is what an ssh command gets, and then reports
+            # "no matches" while the log holds the records.
+            command = ('ausearch -if %s -m AVC 2>/dev/null | grep "avc:" '
+                       '| grep -F %s | grep -F %s || true'
+                       % (shlex.quote(self.audit_log()),
+                          shlex.quote(marker), shlex.quote(basename)))
+        else:
+            command = ('dmesg 2>/dev/null | grep "avc:" | grep -F %s '
+                       '| grep -F %s || true'
+                       % (shlex.quote(marker), shlex.quote(basename)))
+        status, output = self.run_admin(command)
+
+        # Match the source context and the file, so that a record left by an
+        # earlier run or written for another process cannot satisfy the check.
+        return {line for line in output.splitlines()
+                if 'avc:' in line and marker in line and basename in line}
-- 
2.43.0

