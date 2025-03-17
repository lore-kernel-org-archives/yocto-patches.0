Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6B8C28B30
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 11:34:49 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.50160.1742211288212349813
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 17 Mar 2025 04:34:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hgpPmaxs;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: skandigraun@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39104c1cbbdso2421156f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 17 Mar 2025 04:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742211286; x=1742816086; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LHHxblRmCBGy1jwfdA+iLQTf1WoVLxeCW11JDFVnC/s=;
        b=hgpPmaxstwxk2PEGEJOxftwQTjSFysZe+h8mVyjW3Y9biAfkzpagQwXYXbvZ/ABjEb
         WArrY2IDCriHgZ+JVJmbsIf3e8pZwnaWX2s7W3pc18ZKxIa3CnL5kHZMiwDNYJpKA1bR
         uGQbVr+lZNqOFfGCVxsJqCGvwdExC1Te9AD7VcN1yO/8/GSKJvSf7o00HHnBSh7g672O
         ptTPWL3J35wK/6afgjPtaSxvFA3RvWnGsXkoxvKcQ0/1PFKgLk34AHjHh72uw8Hz1X5u
         sCmBGqXapro5S4ziRVHBuBXObV0kixSoU6DMUrj3xMmEdjGnMTktpqaAm1AzaA+YsIkq
         TJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742211286; x=1742816086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHHxblRmCBGy1jwfdA+iLQTf1WoVLxeCW11JDFVnC/s=;
        b=uli5yBQBfg3HA7tRFZuNraPgFQ/jhSmeg0kdJ9TtAS/wDez1Pa1vmlZ86ZDbBKxDAh
         8EZkhS71PDPcNAt1KXlsyEOtJThnsiMgcl0D6RPVi6gAQ5JXLcYfQnF9qK9D6QkOshxH
         Ija7ttESb3Rr2OL4tAC7geAd4GEJtYT6WgOixNdXXWLuZjgTrqIzZ1vHL3kaOqcN6Uz0
         YxGHxZNVsDzWCD8fRZ1ApIFA4Em25C+U1/cfRwu5do3/gQMk5Z8PslDUrGnRDybL0R+L
         A44D0JgMJhY8Kfv7ado9XdBJPj3DaFuxDIIz1yU6BZ6P33hZlRy2GankyhGSl1r5crG9
         MZ+Q==
X-Gm-Message-State: AOJu0YzgKk8OC4R35DoogbtAZkNveJnO5u6uvKsW3sfGc7bNMD64leDO
	JGwJdOzXgr3eXa9TnPo+gm/RqUFvqgk5s8WtqRxzDWpb0BxpBFhAsgGk5w==
X-Gm-Gg: ASbGncsv05tb6lvL/lDG5KQg0UZvgepeYeZ+C7SROsmH3J0Xg/FG6r/a9fNB2XNh/vT
	X5kbEYj79LqAWSARfdDSxYNBocOMpDZp/13hozdW5AlyYpQzJljcCzM+ZhglxVMMD0V1eSvoCDi
	gXdjDd+C139fWuO+UqbY1OvevyV+sO+KHL/NitagU9xunhzsUE2UBkUqP9XUsNj+DTg/PzycpTa
	QneutmkL8yuAt9OvvLaij0nr7VuopantsyU3ZrpWKAjKMIwXa2F6/kVCN7auJT5N21hMHdeLdbJ
	N4g2Gj/EAy+OtGOjPaWRbvTKN3QNT/+9D6BL9zWbzsDe79U26mdplRqSRk1S
X-Google-Smtp-Source: AGHT+IHTqtnCnnKppTfq5VtTZzazT2dYNpvcI1/6yRnIaQRK4Y8zyExy37uQ/eWPBPVb3NWSXjx5oQ==
X-Received: by 2002:a05:6000:1a87:b0:390:e1c5:fe2 with SMTP id ffacd0b85a97d-3971ee4489bmr14766020f8f.38.1742211286362;
        Mon, 17 Mar 2025 04:34:46 -0700 (PDT)
Received: from localhost.localdomain ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d25593a94sm38656755e9.3.2025.03.17.04.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 04:34:45 -0700 (PDT)
From: Gyorgy Sarvari <skandigraun@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Lander Van Loock <landervanloock@gmail.com>
Subject: [pseudo][PATCH 0/1] pseudo: add nftw wrapper
Date: Mon, 17 Mar 2025 12:34:44 +0100
Message-ID: <20250317113445.3855518-1-skandigraun@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 17 Mar 2025 11:34:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1207

This is an (attempt at the) implementation of the nftw[1] call in pseudo.

The main motivation is a change in btrfs-tools[2], in which
they have changed from walking the filetree and calling stat
on each entries separately to using the nftw call. As a result,
btrfs filesystem generation currently happens with incorrect
ownership details, as the nftw calls go around pseudo.

See also the relevant report[3] on the Yocto mailing list.

The idea is also described in the commit message, though the actual,
non-generated code is also only just a few lines, under 20 I think:
with a custom wrapper capture the nftw call, and switch the callback
to our own callback. When our own callback is called, fix the received
stat struct, and call the original callback, this time with the correct
stat struct.

Big thanks to Lander Van Loock, who not only reported the
original issue, but also helped testing and reviewing the change beside
fixing some issues in prior iterations of the code.

Please let me know what you think.

[1]: https://linux.die.net/man/3/nftw
[2]: https://github.com/kdave/btrfs-progs/commit/c6464d3f99ed1dabceff1168eabb207492c37624
[3]: https://lists.yoctoproject.org/g/yocto/message/64889


Gyorgy Sarvari (1):
  nftw: add wrapper

 ports/unix/guts/nftw.c            |  16 ----
 ports/unix/nftw/guts/nftw.c       |  22 +++++
 ports/unix/nftw/pseudo_wrappers.c | 122 +++++++++++++++++++++++++
 ports/unix/nftw/wrapfuncs.in      |   1 +
 ports/unix/subports               |   2 +
 ports/unix/wrapfuncs.in           |   1 -
 test/test-nftw.c                  | 144 ++++++++++++++++++++++++++++++
 test/test-nftw.sh                 |  42 +++++++++
 8 files changed, 333 insertions(+), 17 deletions(-)
 delete mode 100644 ports/unix/guts/nftw.c
 create mode 100644 ports/unix/nftw/guts/nftw.c
 create mode 100644 ports/unix/nftw/pseudo_wrappers.c
 create mode 100644 ports/unix/nftw/wrapfuncs.in
 create mode 100644 test/test-nftw.c
 create mode 100755 test/test-nftw.sh


Cc: Lander Van Loock <landervanloock@gmail.com>

