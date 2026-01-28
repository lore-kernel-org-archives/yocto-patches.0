Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AC1D46BE5
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 17:38:33 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.447.1769621905081269984
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Jan 2026 09:38:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fZGLzwDI;
 spf=pass (domain: gmail.com, ip: 209.85.167.174, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45c89d754dfso54457b6e.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 09:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769621904; x=1770226704; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0b8pk7tyyw/FAg/s8d4sX/zies1LDpYUViXMgaSGOc=;
        b=fZGLzwDISGaU6Kvtt1u0aqIniGlpuNL3TwPURN6NlxYn2ket/WHv1A3yJmGsuBBvH7
         jBC41CJYsYr5tweLm3GOAIHhIUIodgTYrvshSgCcBlTk48A/493DZxDqR63Yp4/SCd0+
         zebyMYD9s5Szf2x6pvhrTLfbZcoUInv3+n+qvIJZvwx/mu7DnrxUlJIF/B0o5F23dQAw
         mXNoJthQucnZVT9XEI8B+qXdEwgQ1nyFYFmf0S0qtzzrTZju4isuYMC2hqlLsX/+a9v5
         62X9+rSoK/wblQxTYtLtq8M4/Pt2IsirJ1UPCO3xWVZCMOOz7P/NF6XWcGVzyZfhA7ha
         Fv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769621904; x=1770226704;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A0b8pk7tyyw/FAg/s8d4sX/zies1LDpYUViXMgaSGOc=;
        b=BsL9x9lxwx4L+MMz4JGkJ8dfJbT+WE22A48FLnZ+VTVhQHBQkCr3QCX9NB2k5XrXX/
         hOvPUfo6MwUYxNQh7GFbVxak73JKX0d6HaXufrqDBZ35Ib54VGS1o8P0K9DzeVvkqIzB
         kxOvEAt6wa7VUqx8FD1jvaCDu+E5xeo3Pwdtwb5feWIl4DTRwwgIROqZaS/D2FIJSLv/
         xOOkVhUtg/XHtFngmef58qu1pa4wkfyu1ajEBvgp2/RuXZlZFKeJCaeV26cApsmD+CGr
         P2l3eAaOzVtevBOLNbsaouYEMk07cJRp/Ilt72lI6d9EuJGoQCU+RjAJyOq1VqNAG6je
         F+zg==
X-Gm-Message-State: AOJu0YxFexa6x2L+KqJUrUpxoqPh2LwLAZqVDZ1HfQwbdtgJwsx4X0hh
	lM9UrKahoKqTrb/F0AUAkZImnvYANNxUqXMqhyxfv1AgUcXL22v+qobISmYshQ==
X-Gm-Gg: AZuq6aK50R2PzyD3hR4NQXwitXgW/Mprf/6al7MxaGrsBqaybGdr7sVz9pNLiOYwSxa
	OF6KsYBw+uKUD6EsrQ2dnMAF3IKAFjKu9XOmEscqAFlU0G3sRcdHHiB5X3qMRvRcYUKe/FEhEA5
	GUjGgomCG0192tbL9eqjqXw2yKj2AQF7cn5e/gSGDZfRuk7ZLqTuQdRU2s0U6oANzXlTNRcSZU/
	ee+Lk5IdbmqjydxnGc6q5jjl9kELJmPA9Lu6jm9SlH4+QuyEqkn1bBKnLrmQj4TiPCUyS3kyjTG
	HGcwFt+q5g9NlqMs8nJlnkYTP4k6JWbHNJNc/grYZ8oaXUHUDQ+Z+C/hS/b8BiG6aYTVe5phyaC
	y9TvrDSaWiUpNEyB51mWacErZGII+A6TDbg/KA9nSuzT7EwK11gtKzRLnBgK6VTG/ke7522v7md
	LFCO9ZTkSoLQN5d7/yWue3Di0CmyNOYMsAN8oapBrwQAOQ4H/adkhiPQW/lqb0Rf9d
X-Received: by 2002:a05:6808:4f4b:b0:45a:156f:dbcd with SMTP id 5614622812f47-45efc7ab881mr3241618b6e.62.1769621904168;
        Wed, 28 Jan 2026 09:38:24 -0800 (PST)
Received: from [172.26.252.3] (97-118-253-141.hlrn.qwest.net. [97.118.253.141])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c4f08b7sm2223718a34.0.2026.01.28.09.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 09:38:23 -0800 (PST)
Message-ID: <fb045381-3f15-414d-a948-3f606057b085@gmail.com>
Date: Wed, 28 Jan 2026 10:38:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org, joe.macdonald@siemens.com,
 Yi Zhao <yi.zhao@windriver.com>
Cc: mingli.yu@windriver.com, mathieu.dubois-briand@bootlin.com,
 richard.purdie@linuxfoundation.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][PATCH 0/1] openssh: Add pam_env support
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 17:38:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3138

core-image-selinux testing with Whinlatter base and master meta-selinux

pam_env-related files exist by default:
```
root@qemuarm64:~# ls /etc/environment /etc/security/pam_env.conf
/etc/environment  /etc/security/pam_env.conf
```

pam_env.so already in use:
```
root@qemuarm64:/etc/pam.d# grep session login
# SELinux needs to be the first session rule. This ensures that any 
session [success=ok ignore=ignore module_unknown=ignore default=bad] pam_selinux.so close
session       required   pam_env.so readenv=1
session    required   pam_limits.so
#session    optional   pam_lastlog.so
session    optional   pam_motd.so
session    optional   pam_mail.so standard
# Standard Un*x account and session
session    include      common-session
# starts in the proper default security context. Only sessions which are
session [success=ok ignore=ignore module_unknown=ignore default=bad] pam_selinux.so open
```

TTY functionality testing:
```
root@qemuarm64:~# tail -n 1 /etc/security/pam_env.conf
TEST    DEFAULT=arst

root@qemuarm64:~# echo $TEST
arst

root@qemuarm64:~# tail -1 /etc/environment
BLAH=arst

root@qemuarm64:~# echo $BLAH
arst
```

Enable root SSH for testing:
```
root@qemuarm64:~# setsebool ssh_sysadm_login 1
```

SSH session test:
```
root@qemuarm64:~# echo $BLAH

root@qemuarm64:~# echo $TEST

```

Add pam_env.so session:
```
root@qemuarm64:~# sed -n -e 18,25p /etc/pam.d/sshd
session    required     pam_env.so

# SELinux needs to intervene at login time to ensure that the process
# starts in the proper default security context. Only sessions which are
# intended to run in the user's context should be run after this.
# When the module is present, "required" would be sufficient (When SELinux
# is disabled, this returns success.)
session [success=ok ignore=ignore module_unknown=ignore default=bad] pam_selinux.so open
```

On pam_env.so order difference from /etc/pam.d/login:
https://man7.org/linux/man-pages/man8/pam_env.8.html
"Since setting of PAM environment variables can have side effects to
other modules, this module should be the last one on the stack."

Post-change SSH session:
```
root@qemuarm64:~# echo $BLAH
arst
root@qemuarm64:~# echo $TEST
arst
```

No new AVC denials observed (ausearch, journalctl).

Change:

Clayton Casciato(1):
  openssh: Add pam_env support

 recipes-connectivity/openssh/files/sshd | 1 +
 1 file changed, 1 insertion(+)

