Return-Path: <gael.portay@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48831C3065C
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 13:40:01 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.27014.1719409189786062799
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Jun 2024 06:39:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JciB40cZ;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: gael.portay@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-424a3ccd0c0so14394635e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719409188; x=1720013988; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PyoKqElZ4573KnzV3BXyL4GrZTqLDttBaB/Yh93lRvs=;
        b=JciB40cZPfNjeIPabuLw0oDobOmGrJxSsQSixG0za6uynadMifhxwB9SQFyXoU3XfM
         LIGBmC0b1WjeyL548QCCspbRZk5jJ0wlxotJsG9GB2kI3t6rC7BbBR4bFcOkwazOj6JN
         E0g4apJkQarwuqb1QdJFi4dZmT487PH0ySPdRlXFUuL30an67Quy5uhVlzVQ7xk7pgIE
         bqSK9q3r2EPL1Dq89Eus+Pp/KPvEg5jeVU9cbyZ++Jr2rIekqbpX7QDyRxzjf2L1zSh1
         zRBeCy4ihQGIjo6X7BvPpr/qMAyMBeCpdLM28jfAyELSwnfrF/Ee7EBCpXC+poLouMCh
         8dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409188; x=1720013988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PyoKqElZ4573KnzV3BXyL4GrZTqLDttBaB/Yh93lRvs=;
        b=eDlELo1hgUnepR1o8ZrQzPOBMKc7rYHTCZVk4dk8e5Eo04gHPSxNLlbh4WLCXkZXa6
         F1YqZcFTRD4r16IpuYTIrZgYnwr+EWqnvk1Wa+xkhxai7kyMMimS+Hf02BwxaI0TrM9I
         1F2U8jOqJk5+0XBHd/+aQTBlcjg034kDU7F7MJqt+77kvgYOwWNBLq3BJCgplAkblVQm
         PO41JnHpKeibIoVBVpl5QVTgvyLW02vYT2yQiVRIXyiUTIU7sDc8fQcQiXV2DlM0ZoRr
         xPyKfAnzqSHwul7aIYpm1A3i1J6tC7WBik/pn61TJFyhcaTwYabyiUcUYLlIgVeYylOm
         7HEg==
X-Gm-Message-State: AOJu0YzeSToVDssnP0DKDfhlM9VtW79tmWZfaKoFR0seDOSL9cj7SatH
	53LhYSy4ipdRbyitM7cfw6+IlOwOmgv/ubSBAsgYRqviy6FkVyBpopNEb0Fm
X-Google-Smtp-Source: AGHT+IH4OIGD217ar5vXT0QksKnnJGH2Zv+EHrD9IfMQFAyHjI7u0M1KK5xAG1dfQH1P/Su8OGw5tw==
X-Received: by 2002:a5d:640e:0:b0:362:52d8:6788 with SMTP id ffacd0b85a97d-366e9465a16mr6761739f8f.2.1719409187626;
        Wed, 26 Jun 2024 06:39:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7befsm15802533f8f.95.2024.06.26.06.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:39:47 -0700 (PDT)
From: "=?UTF-8?q?Ga=C3=ABl=20PORTAY?=" <gael.portay@gmail.com>
X-Google-Original-From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@rtone.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: gael.portay+yocto@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@rtone.fr>
Subject: [meta-security,kirkstone][PATCH 0/5] sssd: fix python3 support
Date: Wed, 26 Jun 2024 15:39:08 +0200
Message-ID: <20240626133913.790145-1-gael.portay@rtone.fr>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 13:40:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/374

Dear Maintainers,

This patch series brings several fixes to enable the support for python3
to the recipe sssd.

I have tested the build on the branch kirkstone with following change to
enable python3:

	PACKAGECONFIG:append:pn-sssd = " python3"

The command below runs successfully since then, however, I have not
tested it on scarthgap (yet?).

	$ bitbake sssd

The patch series creates the new target package sssd-python; tell me if
is not misnamed (thinking about python-sssd?) or if the python script
and its modules should be part of the target package sssd instead.

Also, tell me if you want me to apply these changes on top of master.

Important: I am no expert in python packaging at all, so I have probably
made not-the-right choices in the first commit! Sorry...

Kind Regards,
Gaël PORTAY (5):
  sssd: fix missing python3.X-config script
  sssd: fix ac_cv_prog_HAVE_PYTHON3 value
  sssd: fix issue if build machine is Debian
  sssd: fix shipping python script and modules
  sssd: fix path to python3 interpreter

 recipes-security/sssd/sssd_2.5.2.bb | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.45.2


