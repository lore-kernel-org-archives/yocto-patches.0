Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2562.1794371289079468271
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:28:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4S8mE2429215
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:28:08 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 0/2] RFC: Fix/Add a fast path (async) IPC for ops
Date: Tue, 10 Nov 2026 22:28:05 -0600
Message-Id: <1794371287-31540-1-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:28:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5296
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

In the distant past a 'FASTOP' was implemented, but never actually worked
properly.

It was observed that a true fast op could be implemented using an async
calling mechanism, however this is implemented differently from the original
work.  The new work splits IPC channel into two parts.  Then the async calls
are handled as they can be, or forced before the next sync call.  This
ensures that all database operations are kept in sync.

Note, this work is on a separate branch as it needs a lot more review
before I would feel safe integrating it.  It's also not required to fix
any bugs, but simply should help with performance.

See the async-ipc branch of pseudo repository.

Mark Hatle (2):
  Send client requests over one shared datagram socket
  Replace FASTOP with requests that don't wait for a reply

 README.security                |   4 +-
 doc/overview                   |   6 +-
 doc/program_flow               |  11 ++
 doc/pseudo_ipc                 |  73 ++++++++++++--
 enums/msg_type.in              |   2 +-
 enums/op.in                    |  50 +++++-----
 ports/common/guts/_Exit.c      |  16 +++
 ports/common/guts/_exit.c      |  16 +++
 ports/common/guts/execv.c      |   4 +
 ports/common/guts/execve.c     |   4 +
 ports/common/guts/execveat.c   |   4 +
 ports/common/guts/execvp.c     |   4 +
 ports/common/guts/execvpe.c    |   4 +
 ports/common/guts/fexecve.c    |   4 +
 ports/common/pseudo_wrappers.c |  34 +++++++
 ports/common/wrapfuncs.in      |   2 +
 pseudo.1                       |  23 ++++-
 pseudo.c                       |   2 +-
 pseudo.h                       |   1 +
 pseudo_client.c                | 222 +++++++++++++++++++++++++++++++----------
 pseudo_client.h                |   2 +
 pseudo_ipc.c                   |  42 ++++++++
 pseudo_ipc.h                   |   8 ++
 pseudo_server.c                | 186 +++++++++++++++++++++++++++++-----
 pseudo_util.c                  |   1 +
 pseudo_wrappers.c              |  43 ++++++++
 test/test-async-abort.c        |  44 ++++++++
 test/test-async-abort.sh       |  40 ++++++++
 test/test-async-order.c        | 188 ++++++++++++++++++++++++++++++++++
 test/test-async-order.sh       |  23 +++++
 30 files changed, 946 insertions(+), 117 deletions(-)
 create mode 100644 ports/common/guts/_Exit.c
 create mode 100644 ports/common/guts/_exit.c
 create mode 100644 test/test-async-abort.c
 create mode 100755 test/test-async-abort.sh
 create mode 100644 test/test-async-order.c
 create mode 100755 test/test-async-order.sh

-- 
1.8.3.1

