Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59C7CA5FF0
	for <webhook@archiver.kernel.org>; Mon,  5 Oct 2026 08:12:02 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15203.1791187919017018859
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 Oct 2026 01:11:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=pKmOcWDQ;
 spf=pass (domain: gmail.com, ip: 74.125.225.141, mailfrom: frezidok1@gmail.com)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a022e9cbebso12115065e9.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 Oct 2026 01:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791187917; x=1791792717; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T2ylcl4Nj0yxyBQ/UbzFKLee8wz7tB8+lbc/C47vT1M=;
        b=pKmOcWDQZe1WBC4qpZLPLPG7dXbxnw7tq6N5Oya158lf7tigcPYJXr9GXD4ywFtqpo
         WtAMiTheJcAOfvYPdk62zZWFUu01/0kWrmSepxWr5ffdqdkzmrn1vpB31QhyghqimuSZ
         kNMMfxf7HG/nSwmoM8Fyxyw0mn2uocVZ5Zq7e0CGpmTxdYk3dROh93gBOnrY2NOZeLsI
         jAQblbjbOew4nyN0z2t7tvbyWbpWWEZdd3wWLwszVa7ZipbcBWG3xs7fm2MXTxw4nkTv
         3JF4Z4kMCyHV5XCmnNgn0QVuXu/kfoagCI55waD43k3fTd0rTNB0ow0DBMOZZ83d9vBR
         cxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791187917; x=1791792717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T2ylcl4Nj0yxyBQ/UbzFKLee8wz7tB8+lbc/C47vT1M=;
        b=YfTECp73mqFr40elhhJBnFaMdLOaVL0gmeVRX9I7NzGZyUQ5P2/BlMY/6B/pUixrZk
         EizaKYrzQNRzMPf/rCnlvgif977bT602i0q62IKTLVkvnEfZCYSwWT4XoL85tfcQErID
         swyG5oiHiwgWMl+6ZzjVkI8Y6cLpEtVjz9i+xoxV/+qaSRyLyBF8dI+jTHLLJd2qA7bt
         XA6ECHdjdKJn9K4uHOWQCS8u8e4ypDBT6Y5MurdYudXnnun+UVmvVDHQk6ESfknZGvVw
         sFCli0SOZdX4MgUL9BakngwEgBliDX8PDrD8L2cCid3oJTziOuHGFNInLmf4YuDDqcEz
         FlCg==
X-Gm-Message-State: AFuF++lEZquAssV+n1k6rWN7DfHoxCSvnCIKhomqGQvBv0lQmDIBXP5h
	7PW4GCxA/KYj2vFC4jX/5tL37FnOPdmIh8LNbptS2q+6TJb22kb1xk7Q/LJq1zCU
X-Gm-Gg: AYBFou0mBFzYGF/4IIh4QguecMumKixkALC32PcPO2FYctq3Lv5nkbOA7Uo4Zuybn1e
	tImxWIr1xyiPVskrodIqvcf6NDFPM9/zz4KWIQC/q0K0HT8avKCeyMlTWwz0NCTptmNoM64enYu
	ACQ/ziwXeQwQZrdzOPt5MT/TxtHKMCNapEh+22Yl9mCFzj3gXn40d6vrkLgWP9+IefOm3TcBgbT
	c6wRpGNO9t+WKHA1F/NnwYUQ5f5tjnomi24ye74R8bNxdeoc0qvgXZPB+ULbtHYGnJ8/VoKkN4Q
	Gn14le4FwsoBQ7NlNtzfOBzVP9m0JtsoImvLXQFRIx+7Fy9bbbZz72Fij8N5CFtlE+M19RDd0qB
	T62mFEGt52lL5PaeyySYc0h0fSACkYDIQDiahGuErt5GImrHd8JBauJJ/tXIwZRQx+r/tTWfQni
	CZraKhY9ofOVYQNMcJIOYrSNAVFRAYyIyYlzZy3CAbD6E4Qf+nmjOF5h35khOQiiTuEG9i58e6m
	+ZEDBDEgGA6uxizU7fiLVkm082X
X-Received: by 2002:a05:600c:1d05:b0:49c:c0d4:53d9 with SMTP id 5b1f17b1804b1-4a16c4772c5mr81244565e9.14.1791187917102;
        Mon, 05 Oct 2026 01:11:57 -0700 (PDT)
Received: from ubuntu1.. (ppp91-79-47-228.pppoe.mtu-net.ru. [91.79.47.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280d1e38sm268675535e9.13.2026.10.05.01.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 01:11:56 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH v4 0/6] Add open_tree() wrapper
Date: Mon,  5 Oct 2026 11:11:21 +0300
Message-ID: <20261005081127.107126-1-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 Oct 2026 08:12:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4983

From: Dmitry Sakhonchik <frezidok1@gmail.com>

v2:
- Handle relative paths correctly in the open_tree wrapper
- Add fallback to SYS_open_tree when libc function is absent
- Add tests coverage with relative paths (dirfd != AT_FDCWD)
- Add support and tests for syscall(SYS_open_tree, ...)

v3:
- Add open_tree_attr wrapper
- Add open_tree_attr syscall test

v4:
- Account for review

Dmitry Sakhonchik (6):
  ports/linux/guts: Add open_tree wrapper
  test: Add open_tree test
  ports/linux/pseudo_wrappers.c: Add syscall support for open_tree()
    wrapper
  test: Add open_tree syscall test
  test: Add open_tree_attr syscall test
  ports/linux/guts: Add open_tree_attr wrapper

 ports/linux/guts/open_tree.c        |  59 ++++++++++
 ports/linux/guts/open_tree_attr.c   |  57 ++++++++++
 ports/linux/portdefs.h              |  24 ++++
 ports/linux/pseudo_wrappers.c       |  30 +++++
 ports/linux/wrapfuncs.in            |   2 +
 pseudo_wrappers.c                   |   1 +
 test/test-open_tree-syscall.c       | 154 +++++++++++++++++++++++++
 test/test-open_tree-syscall.sh      |   9 ++
 test/test-open_tree.c               | 141 +++++++++++++++++++++++
 test/test-open_tree.sh              |   9 ++
 test/test-open_tree_attr-syscall.c  | 167 ++++++++++++++++++++++++++++
 test/test-open_tree_attr-syscall.sh |   9 ++
 12 files changed, 662 insertions(+)
 create mode 100644 ports/linux/guts/open_tree.c
 create mode 100644 ports/linux/guts/open_tree_attr.c
 create mode 100644 test/test-open_tree-syscall.c
 create mode 100755 test/test-open_tree-syscall.sh
 create mode 100644 test/test-open_tree.c
 create mode 100755 test/test-open_tree.sh
 create mode 100644 test/test-open_tree_attr-syscall.c
 create mode 100755 test/test-open_tree_attr-syscall.sh


