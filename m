Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.283.1794500400611300773
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Nov 2026 08:20:00 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6ACGJxKs2743931
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 10:19:59 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 0/6] Add landlock support, fix seccomp
Date: Thu, 12 Nov 2026 10:19:52 -0600
Message-Id: <1794500398-31706-1-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 16:20:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5326
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The first 3 changes add support for landlock.  This was recently
reported by Richard Tollerton that xz on arch linux was now using
landlock and breaking pseudo invocations.  The first patch is a
test case, second patch moves to using /proc instead of a chdir
(with fallback to prior behavior) and third patch intercepts the
syscall and avoids landlock.  This was implemented as a belt and
suspenders type approach, as there have been instances of similar
software in the past using non-standard ways to activate.

During review and testing, it was observed that the prctl/seccomp
implementation was incomplete.  Add tests, and then fix the
existing implementation.

Mark Hatle (6):
  test-landlock: Add a Landlock sandbox test
  pseudo_client: Connect to the server without changing directory
  ports/linux/pseudo_wrappers: Report Landlock as unsupported
  test-seccomp: Check that seccomp is never really enabled
  ports/linux/pseudo_wrappers: Fake seccomp filters set by prctl()
  ports/linux/pseudo_wrappers: Fake seccomp strict mode in syscall()

 README.security               |  14 ++++
 ports/linux/pseudo_wrappers.c |  29 +++++++--
 pseudo_client.c               |  77 +++++++++++++++-------
 test/test-landlock.c          | 146 ++++++++++++++++++++++++++++++++++++++++++
 test/test-landlock.sh         |  24 +++++++
 test/test-seccomp.c           | 121 ++++++++++++++++++++++++++++++++++
 test/test-seccomp.sh          |  12 ++++
 7 files changed, 395 insertions(+), 28 deletions(-)
 create mode 100644 test/test-landlock.c
 create mode 100755 test/test-landlock.sh
 create mode 100644 test/test-seccomp.c
 create mode 100755 test/test-seccomp.sh

-- 
1.8.3.1

