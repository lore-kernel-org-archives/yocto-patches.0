Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB189F46134
	for <webhook@archiver.kernel.org>; Mon, 23 Mar 2026 14:49:06 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19385.1774277345764106187
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Mar 2026 07:49:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=c1AjNP5x;
 spf=pass (domain: gmail.com, ip: 209.85.167.179, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-46703fb602fso982072b6e.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Mar 2026 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774277345; x=1774882145; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7r0MmBnbp43zztf5AVh0t9evk0N7c2IHk7g3e7qOko=;
        b=c1AjNP5xmFXN/ddwI05f+jWYX/5rI3bw6JYHAKUjwcmPYwLhbY4W46gwYC5bDQZ6VF
         ezvU09syUVv5WGpsKpmJr+ab6duuiJzn1riyS5iZNERKaVK47YTK8Ne+7xBcUV1qa/Y2
         KHMzGql4k0W1rPr5W26vblqE3tHrOGCYGO9tICms2vXxEi/UxIqtrJ+aO1I2ny679mY7
         6wJcTDXdBWhU58mrhr7Xr/s87ul/5WvDY/9tMuLSO0iyuMkWE/h48t48lbmxGXcR/MBc
         VU1unA6S9L1zsMTeHiJcgl8GdMM6wzQLlONfTfbPhUoB/8x8zBbLfYuyzxih8MjehcB9
         /ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774277345; x=1774882145;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7r0MmBnbp43zztf5AVh0t9evk0N7c2IHk7g3e7qOko=;
        b=mi6FHN8qQaxVH2Iiu67ERXlLI+VuW1Zf0CLCDZPCpbYeM+5YJ++W6bVj67neszrmXb
         OloaxhqnbTRXlMEyNXceSP0JY/c+xNXemeFLV9+h6r0B1veb7ilRNRZzpJ6EHDIgjvJ7
         h1PlZ0i4AWMCnNg64G2HznHDbWoXCAwFmKpAgDwPp788JgXorKY1NlDQWbQ3etBsfeMl
         NJ7SOvAXEMXjuIWCz3Ta/jYY0BkCyjO4j2u7d41Z99aTJOa5GyS7kLoxHgqfivHH/wV0
         bSQjuWtKDUZ2skTNlkj3mmzsDXE8t4tGmrUauRiAZgQzfuRIvOWrdlfXXivDJX1etd8Y
         NJuw==
X-Forwarded-Encrypted: i=1; AJvYcCV9OB+ZvIX8QJUHH/Z/XNwbByPF3iQWuuTVbEoNkyrP7ny9yzhsM07BpcmNKkvTVYqrtAqzs0a1kXx12TJk@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwrWvC5yxbah/1rEFCnN2bO4x7QUSlHMA3z+LFSGtZqJgqPbx18
	Rls4r8XBZZ/PlWxinb3TTECtxjL3rWFxp+eP38cS2Aj7NXjsc2bB+1uB
X-Gm-Gg: ATEYQzyWCWaO1AnVw6k96hcG+fncgXVTxtWowCGYy3+l9D3/QAB/NckqjHvNWcXFS8i
	60s3RRw/sZJ7o1TJsHrYpVZRAeAiP8Sm43q33ysXI1UTou8iqByyWZ8GOW9WTW3LAE0MbPqmcQb
	1seFtRh5fjbIIO7t6jEj+sgSfwXTrKpi1DozoVNurzGzlMcqFzf8aCbXY/G1Dq/jTIOHsBZv5Dj
	Keu20WbDzdnEcnmMmCPKPfAi7GY4BUv1/0btORZ2OSzqKKhKWlszXrkj2S+X9TwTLlLq5npZte/
	MuxiMAuL77tQ79nspR0wCsVBzkYJ63fHdTlG98WZA37/YnQ5yqKgy+AnnqClNaXC6XzgTz3AjtH
	OyvQmKxEgRtRg8raWRWz13vQOu2aD+kCVM35HAVL99KXvaS0PtUMxc9vY0iieFOLSendpQbn4YA
	YPa8+zLdwifUJJ83cJ+vxYKwNhAM/9/k6BwPmWzPiHdFMJxFCghkFGbwH6QLe8eng/oM6Jh52ao
	dKj
X-Received: by 2002:a05:6808:5243:b0:467:f567:d609 with SMTP id 5614622812f47-467f567ee57mr6136395b6e.34.1774277344800;
        Mon, 23 Mar 2026 07:49:04 -0700 (PDT)
Received: from [172.26.252.3] (97-118-253-141.hlrn.qwest.net. [97.118.253.141])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7f45ce7sm6989499b6e.17.2026.03.23.07.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 07:49:04 -0700 (PDT)
Message-ID: <1f404d2a-dfb4-4d42-936c-0877fdd58ee1@gmail.com>
Date: Mon, 23 Mar 2026 08:49:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][whinlatter][PATCH] refpolicy: locallogin - allow
 local_login_t lastlog_t create,delete
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 23 Mar 2026 14:49:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3533

Signed-off-by: Clayton Casciato <majortomtosourecontrol@gmail.com>
---
 ...ystem-locallogin-allow-local_login_t.patch | 149 ++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |   1 +
 2 files changed, 150 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0061-policy-modules-system-locallogin-allow-local_login_t.patch

diff --git a/recipes-security/refpolicy/refpolicy/0061-policy-modules-system-locallogin-allow-local_login_t.patch b/recipes-security/refpolicy/refpolicy/0061-policy-modules-system-locallogin-allow-local_login_t.patch
new file mode 100644
index 0000000..d5a63bb
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0061-policy-modules-system-locallogin-allow-local_login_t.patch
@@ -0,0 +1,149 @@
+From 9cee0ec6ec9bb0af826f0f2af88e36159429e1e7 Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Thu, 15 Jan 2026 16:27:43 -0700
+Subject: [PATCH] locallogin: allow local_login_t lastlog_t create,delete
+
+Note that the { read } AVC denial was not addressed.
+
+It is currently unknown what specifically triggers this and Fedora
+policy does not appear to allow this.
+
+--
+
+Fedora:
+
+https://github.com/fedora-selinux/selinux-policy/commit/fe29879463b7176dab24c0a9210131fa6e7cd130
+"Allow systemd (PID 1) create lastlog entries"
+
+--
+
+pam_lastlog2(login:session): Cannot open database
+(/var/lib/lastlog/lastlog2.db): unable to open database file
+
+PROCTITLE proctitle=2F62696E2F6C6F67696E002D70002D2D00726F6F74
+
+AVC avc:  denied  { getattr } for  pid=244 comm="login"
+path="/var/lib/lastlog" dev="vda" ino=32776
+scontext=system_u:system_r:local_login_t:s0
+tcontext=system_u:object_r:lastlog_t:s0 tclass=dir permissive=1
+
+SYSCALL arch=c00000b7 syscall=79 success=yes exit=0 a0=ffffffffffffff9c
+a1=55557ab4db98 a2=7ffff6dd39c0 a3=100 items=0 ppid=1 pid=244
+auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0
+tty=ttyAMA0 ses=4294967295 comm="login" exe="/usr/bin/login.shadow"
+subj=system_u:system_r:local_login_t:s0 key=(null)
+
+--
+
+PROCTITLE proctitle=2F62696E2F6C6F67696E002D70002D2D00726F6F74
+
+AVC avc:  denied  { search } for  pid=244 comm="login" name="lastlog"
+dev="vda" ino=32776 scontext=system_u:system_r:local_login_t:s0
+tcontext=system_u:object_r:lastlog_t:s0 tclass=dir permissive=1
+
+SYSCALL arch=c00000b7 syscall=79 success=no exit=-2 a0=ffffffffffffff9c
+a1=55557ab4db98 a2=7ffff6dd39c0 a3=100 items=0 ppid=1 pid=244
+auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0
+tty=ttyAMA0 ses=4294967295 comm="login" exe="/usr/bin/login.shadow"
+subj=system_u:system_r:local_login_t:s0 key=(null)
+
+--
+
+PROCTITLE proctitle=2F62696E2F6C6F67696E002D70002D2D00726F6F74
+
+AVC avc:  denied  { write } for  pid=244 comm="login" name="lastlog"
+dev="vda" ino=32776 scontext=system_u:system_r:local_login_t:s0
+tcontext=system_u:object_r:lastlog_t:s0 tclass=dir permissive=1
+
+AVC avc:  denied  { add_name } for  pid=244 comm="login"
+name="lastlog2.db" scontext=system_u:system_r:local_login_t:s0
+tcontext=system_u:object_r:lastlog_t:s0 tclass=dir permissive=1
+
+AVC avc:  denied  { create } for  pid=244 comm="login"
+name="lastlog2.db" scontext=system_u:system_r:local_login_t:s0
+tcontext=system_u:object_r:lastlog_t:s0 tclass=file permissive=1
+
+SYSCALL arch=c00000b7 syscall=56 success=yes exit=4 a0=ffffffffffffff9c
+a1=55557ab4e2b4 a2=88042 a3=1a4 items=4 ppid=1 pid=244 auid=4294967295
+uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=ttyAMA0
+ses=4294967295 comm="login" exe="/usr/bin/login.shadow"
+subj=system_u:system_r:local_login_t:s0 key=(null)
+
+CWD cwd="/"
+
+PATH item=0 name=(null) inode=32776 dev=fe:00 mode=040755 ouid=0 ogid=0
+rdev=00:00 obj=system_u:object_r:lastlog_t:s0 nametype=PARENT cap_fp=0
+cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
+
+PATH item=1 name=(null) nametype=CREATE cap_fp=0 cap_fi=0 cap_fe=0
+cap_fver=0 cap_frootid=0
+
+PATH item=2 name=(null) inode=32776 dev=fe:00 mode=040755 ouid=0 ogid=0
+rdev=00:00 obj=system_u:object_r:lastlog_t:s0 nametype=PARENT cap_fp=0
+cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
+
+PATH item=3 name=(null) inode=32867 dev=fe:00 mode=0100644 ouid=0 ogid=0
+rdev=00:00 obj=system_u:object_r:lastlog_t:s0 nametype=CREATE cap_fp=0
+cap_fi=0 cap_fe=0 cap_fver=0 cap_frootid=0
+
+--
+
+PROCTITLE proctitle=2F62696E2F6C6F67696E002D70002D2D00726F6F74
+
+AVC avc:  denied  { read } for  pid=244 comm="login" name="lastlog"
+dev="vda" ino=32776 scontext=system_u:system_r:local_login_t:s0
+tcontext=system_u:object_r:lastlog_t:s0 tclass=dir permissive=1
+
+AVC avc:  denied  { open } for  pid=244 comm="login"
+path="/var/lib/lastlog" dev="vda" ino=32776
+scontext=system_u:system_r:local_login_t:s0
+tcontext=system_u:object_r:lastlog_t:s0 tclass=dir permissive=1
+
+SYSCALL arch=c00000b7 syscall=56 success=yes exit=6 a0=ffffffffffffff9c
+a1=7ffff6dd5740 a2=80000 a3=0 items=0 ppid=1 pid=244 auid=4294967295
+uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=ttyAMA0
+ses=4294967295 comm="login" exe="/usr/bin/login.shadow"
+subj=system_u:system_r:local_login_t:s0 key=(null)
+
+--
+
+PROCTITLE proctitle=2F62696E2F6C6F67696E002D70002D2D00726F6F74
+
+AVC avc:  denied  { remove_name } for  pid=244 comm="login"
+name="lastlog2.db-journal" dev="vda" ino=32868
+scontext=system_u:system_r:local_login_t:s0
+tcontext=system_u:object_r:lastlog_t:s0 tclass=dir permissive=1
+
+AVC avc:  denied  { unlink } for  pid=244 comm="login"
+name="lastlog2.db-journal" dev="vda" ino=32868
+scontext=system_u:system_r:local_login_t:s0
+tcontext=system_u:object_r:lastlog_t:s0 tclass=file permissive=1
+
+SYSCALL arch=c00000b7 syscall=35 success=yes exit=0 a0=ffffffffffffff9c
+a1=55557ab4e2d2 a2=0 a3=7fff4a1abb68 items=0 ppid=1 pid=244
+auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0
+tty=ttyAMA0 ses=4294967295 comm="login" exe="/usr/bin/login.shadow"
+subj=system_u:system_r:local_login_t:s0 key=(null)
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/93a6a53391f13d13a1d7e84872ccc227b5c550ec]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/system/locallogin.te | 2 ++
+ 1 file changed, 2 insertions(+)
+
+diff --git a/policy/modules/system/locallogin.te b/policy/modules/system/locallogin.te
+index 75ee52efd..5840ad5a9 100644
+--- a/policy/modules/system/locallogin.te
++++ b/policy/modules/system/locallogin.te
+@@ -122,6 +122,8 @@ term_relabel_all_ttys(local_login_t)
+ term_setattr_all_ttys(local_login_t)
+ term_setattr_unallocated_ttys(local_login_t)
+ 
++auth_create_lastlog(local_login_t)
++auth_delete_lastlog(local_login_t)
+ auth_rw_login_records(local_login_t)
+ auth_rw_faillog(local_login_t)
+ auth_manage_pam_runtime_dirs(local_login_t)
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index b69cc31..3af37c5 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -76,6 +76,7 @@ SRC_URI += " \
         file://0058-policy-modules-system-logging-allow-miscfiles_read_g.patch \
         file://0059-policy-modules-system-authlogin-label-var_lib_lastlo.patch \
         file://0060-policy-modules-system-authlogin-add-auth_create_last.patch \
+        file://0061-policy-modules-system-locallogin-allow-local_login_t.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"

