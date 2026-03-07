Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E27FC9EEB
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 10:34:35 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6899.1772879669401618538
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Mar 2026 02:34:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=cv+Pbw7p;
 spf=pass (domain: konsulko.com, ip: 209.85.219.45, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89a07f66f4eso68528326d6.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 02:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1772879668; x=1773484468; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ayJ9iOeOyCAj4SkxEiS0xj3w3GVfUBTEjDiEEB7ytqQ=;
        b=cv+Pbw7p5XkLremK/Nt9jPVQp7DYzchwAK8MXBf2vZEDG94j48s2UkAc7ZHlXKnvGy
         BonEOi5IbZHnOP5wODzglyWyvTtgfNnKLrQ5JOZGnJlEqfeNRRfouOn+GyaOJJDk0riU
         cK7klPoOxbrgPwnvGg3Ff8j+NBTNmx1mLTAn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772879668; x=1773484468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayJ9iOeOyCAj4SkxEiS0xj3w3GVfUBTEjDiEEB7ytqQ=;
        b=GIZld2c4u92/fQT9m+nwmbqjhvVH3aDrAi6HfkJWf66rQjy8lUH9zr+7XG7cVuH7xM
         2lEJdFuXiUmJBDUqejuyLyVvnsnFtYfbD86pWPMa6pCv9akI1apjwQ1Qw3y+HIEiaUxf
         MJXEpsm5ZeYUt4crcxgCMjOb8vuXe0Tlg9Ihc0UpmoPXEGyXSKY+OJYAbduJEGdZ9V7T
         854NMHkNWJmR5OjpppzeYKNcDqxG/lfnnRiYc/Hvxrnlsenayzl5zpW8vapB52UcVV1a
         Sq7HKe5wVlJEO/iHAQcaJCt/YbKF5Vcepj8JneDZNp11F1DaOPUx0MbA/SAaRsELUiqm
         KSEA==
X-Gm-Message-State: AOJu0YyELgMQMzNRO23G6SNo/RV/AlWBby6kZcgmpK5l9fZ4mOnMmPb8
	XFLdUryHAwxpaf+S/xjVqP3jSD98bqMrCWvfRnVc9eYdRnGDmmM4O+RKVE9tFtTW97WDY8A1GAm
	9jzYLkM8=
X-Gm-Gg: ATEYQzwC2AThgaev05zf6Fp/yiTBV6aAky1EWq2Z8Dama+AFwmcrQB/gBhD5RL1q4X1
	GMyPJ8W56IYmD7AjAkZS6VQEaSxcOgmQvJAwBqL89jEmeNHL/NQCUvKUswBTkmQwGINCA2TpyEp
	gWf2BPeE53NXQRbW1qnoDJ+AkJ5zOXL81u+bDTPjY1QfYuP8zljasPtappzGHMv0Vjchy3J+LyC
	SczRGMDtjkOGAcrTniIU16G07fyEGW7afvIZyHYNUEPn5sJeuN6CTFO6G2wrhieDGjSXXKX7QGe
	3oNJCVP8ppI1N09xxoJjGbwVZ5ZpJkS13vjR2izj7bbzDjjcg+Ym58ULBo9qm62EMtkAkEzErKW
	wknRIVrRfb9ETiXwMGnunwM5f3/aDc04qX+KxWz3s5TuGd8doU7eOFQG5+WurLfDEIaSBfyysnR
	RTFnMsiy6GsqDW9TcSGnaGcGdzfaxGNW/2m3+XFb2oDuGLWUPCOCEmqV8ffYRNF5ZuSYEzMlbp5
	DLINi9Sox9VJNfT+7Z+9wh1sX4u1uWWhxXRmu3XZzXvodXubZFM0lYI5cKFeFlr
X-Received: by 2002:a05:6214:cc7:b0:899:fd8c:55d2 with SMTP id 6a1803df08f44-89a30a5600fmr73388646d6.15.1772879668127;
        Sat, 07 Mar 2026 02:34:28 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316d8936sm35653216d6.28.2026.03.07.02.34.27
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:34:27 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 0/2] Assorted updates 03/07
Date: Sat,  7 Mar 2026 05:34:22 -0500
Message-ID: <cover.1772879512.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 10:34:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3373

This patch series rolls up the contributed patches from the past couple
weeks, plus a nikto fix from myself.  These changes are queued on the
scarthgap-next branch if you would like to check them out to test
yourself.  I intend to merge these to scarthgap branch at end of day
Monday (Eastern Time, March 9) unless there are objections.

Scott


Changes:

Hitendra Prajapati (1):
  suricata: update to 7.0.13

Scott Murray (1):
  nikto: fix branch

 .../recipes-security/nikto/nikto_2.1.6.bb     |    2 +-
 recipes-ids/suricata/suricata-crates.inc      | 1437 +++++++++--------
 ...{suricata_7.0.12.bb => suricata_7.0.13.bb} |    2 +-
 3 files changed, 735 insertions(+), 706 deletions(-)
 rename recipes-ids/suricata/{suricata_7.0.12.bb => suricata_7.0.13.bb} (98%)

-- 
2.51.0


