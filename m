Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5508CD0BB56
	for <webhook@archiver.kernel.org>; Fri, 25 Oct 2024 08:22:46 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.7373.1729844564452081295
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Oct 2024 01:22:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZQ1CBM6c;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4314e64eba4so1686845e9.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 01:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729844562; x=1730449362; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XyxEs7V5bG9os5xdU/ZIyIcMnlc/YQHYIZVwzsnPee4=;
        b=ZQ1CBM6cYwl3cX7Rc8nlPBZ9md/0pRUYYrwb4gXs6S84T5q7cFDxHdmCQkvDmD+wzB
         5lWn+UJHO5WO1tOfOnwg04eyEs1mP/BMQbFhFPqV1za3XAqfICc1wTs1iZwwvF0qNk0T
         lzU/QFZdVrWDrjf7yPyJyPUFpp0auqQq0kEJqKHDkfVijBr07DMYUiySTCEezlfRvbWi
         5XVTBhazdB88FHiuFJH3NbCJ9LEVWN+d1tAJPYgcZ5vSZp3/Sdy9oR3uhXxtFquOrtJf
         IKZ2gLmArtC3RLgcLRnCFEuUVhIEKPLvlfF00VBp7f2u8duSeXs0Gen43eM6JysbfWg1
         2UQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729844562; x=1730449362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyxEs7V5bG9os5xdU/ZIyIcMnlc/YQHYIZVwzsnPee4=;
        b=jR0U+Wy/FKWeSFIl96u6+2rbZC0SFOwodZADpMw0yTb5+MGmJrOOU60BTXRNbGwayW
         iWIimFVoAoyvco8GADrv4TclwcZ9SpyO/thKS+Foo185+MYgijizSPJIAPDSITuVlNHf
         uk8kdzg/F7Vun6iqbXfxummjWnKswOnLwu98PqyaRpwAaeQLNSXM/fNyB1UfQ0SdYJTY
         CN+aMdBPcabB6erHson/sVIfIBj0PAecIU6tZb6ETyJkVfUyRzI3VqBO/6pcQxKBiuyI
         5DgRr2F56Kqmv5YeM94amxHemQ600dBj3Zp33e6z772UMGKwiBPEgQLhYkWYJjyubW8B
         SMDw==
X-Gm-Message-State: AOJu0YytEZ3YBB6DD1D6urf1jxX2skF/Xq1MFzvrVxA9BZQKYZDtZH0t
	2BO/YpsCuPCsKWichI5v13qF+q2fp//z7nH9LVduQtogmwQGBsEe9f0siEm7
X-Google-Smtp-Source: AGHT+IEhLrcD3LJjwudeP3Jz0qH9oWmlRCowXIZVdxAxeAfxzSC7sGLxxBLbMTS3yoTlrx8ew0Dntw==
X-Received: by 2002:a5d:47c2:0:b0:374:cc10:bb42 with SMTP id ffacd0b85a97d-37efcef323fmr2900598f8f.2.1729844562292;
        Fri, 25 Oct 2024 01:22:42 -0700 (PDT)
Received: from archlinux.. ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70bc1sm907904f8f.70.2024.10.25.01.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:22:41 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [meta-security][PATCH 00/10] sssd: fix python3 support
Date: Fri, 25 Oct 2024 10:22:29 +0200
Message-ID: <20241025082239.3468351-1-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 08:22:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/748

Dear Maintainers,

This patch series brings several fixes to enable the support for python3
to the recipe sssd.

I have tested the build on the branch master with following change to
enable python3:

	PACKAGECONFIG:append:pn-sssd = " python3"

The command below runs successfully since then.

	$ bitbake sssd

The patch series creates the new target package sssd-python; tell me if
is not misnamed (thinking about python-sssd?) or if the python script
and its modules should be part of the target package sssd instead.

Important: I am no expert in python packaging at all, so I have probably
made not-the-right choices in the first commit! Sorry...

Note: This patch serie follows up the one for the kirkstone branch[1].

[1]: https://patchwork.yoctoproject.org/project/yocto/cover/20240626133913.790145-1-gael.portay@rtone.fr/

Changes since kirkstone:
 - add missing python3-core and python3-logging run-time dependency to
   package
 - set python3dir= to install the sss_analyze python3 files to the
   correct directory /usr/lib/python3.12/site-packages/

Kind Regards,
Gaël PORTAY (10):
  sssd: add whitespace after ?= operator
  sssd: fix missing python3-core run-time dependency
  sssd: fix missing python3-logging run-time dependency
  sssd: fix installation sss_analyze python3 files
  sssd: fix ac_cv_prog_HAVE_PYTHON3 value
  sssd: fix missing python3.X-config script
  sssd: fix issue if build machine is Debian
  sssd: fix missing python3-setuptools-native dependency
  sssd: fix shipping python script and modules
  sssd: fix path to python3 interpreter

 .../recipes-security/sssd/sssd_2.9.2.bb       | 33 +++++++++++++------
 1 file changed, 23 insertions(+), 10 deletions(-)

-- 
2.47.0


