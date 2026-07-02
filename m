Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACF4C43458
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 04:45:39 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.62842.1782967531539198071
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 21:45:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=C/bvIrjS;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490d6730461so1267455e9.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 21:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782967530; x=1783572330; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7RCB0RaeiIaMQsNBPMWuXcjazpQOA/bSD90iodxInMQ=;
        b=C/bvIrjSxjRcTkX3F1QB37AQqfIAJTZ8Bfds+l0y+kkmAuZyF4K0V3SHCK93bZeYeG
         8PS7yQWcH0rn0awxLj644LS0I9YTlYH7ITph/tEaTMTX3O2UVGsnryeESqGDYowNCe8d
         89kUQHWp6+hvOU30dWbmVJdDNOqHinoiJ76hwFOoGszu2b1dRfvzpZp9SokR8oQWzzEQ
         RPzAfimv6NBiO85fO9tWubOOyC0orDcpCBAAX8AwDt54r+P9nmmyoEOyRC5lZQY8DBRK
         OFcPGMpEVA7KENuM2E73Oa5iLF4Tb971TJl906kfBsqQLgtexZKQKdhuDfvzCYq7Utdw
         jc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782967530; x=1783572330;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7RCB0RaeiIaMQsNBPMWuXcjazpQOA/bSD90iodxInMQ=;
        b=FiQFPlScjbogW6UTbARjZusBJRYIfYuNPqCi78FlVBhHGvoAIhjrBbt5IKnSlWpMlN
         hTrY4QXkG5NBLzNSS9NKSUW0FAjH6ItGEOV4H0tgBOgKToi1FIW4gkILcK/A0mVhO6xj
         3BPM4kQCb1kpukQU+8cS93YQjd7hiXPBkuPjmBdFM9fexjBCdk/6mvHJPKNMnAwbQISN
         OsCJTLl73Z+6ua9Rk1RayzGBzG0riwHmV5hAGjbKy+16wYQAlunhe4mn6Pa8dwjwqEK3
         xI5tpkDrqVQRS1zDxe4j1p099cJOdJi5+lGbNg1gahDjwdw2mS+tzy5ZbJTS+Xjf1INm
         RR6g==
X-Gm-Message-State: AOJu0Yygue0E+RC+SI69Awt6RqS42Z8Of6/llpJBRLSoGJglrtEBh4jM
	Kvf+f3bmQ1B5mmwTt5sRo75r3xA+PIUmgL5WUBxN8mnguYy8f0S9WZ7lKsCHFg6s
X-Gm-Gg: AfdE7cl/fdDogydDwRuA0wHIdMAKkKmoqiaGHqevyUYv2LACgH3Vz9+Ok2NjsZ7ZtIm
	J/rf2hfQFJCoyubr70HS2UM5V5Fe6Mb2AUWNR/Djt+adHqUE9L2gAFUtlpAgtXtTV2ZZSPeCYzj
	9TTDJxG2NmpvGHw1lu05qpdKlBvP8ULGtLnrI4AtanMZ0LYeh7gd/QvMp0uvZcz+LdFl/DnALmY
	gUnlWv0LsnhUV4brde5FI/mWGYOq+tvJZrrPGK+kpoP6cd3+wxyRg/wKV1aBgDI33iE93WrQShe
	itlCAhcpI6IjcP5uW/RxsJQ3slw+XzpMB+lMZPWext3g/Uc5cm3hF/xCpc2R+O2s+k1dSZHPJs6
	Kim/rIh6SeWE5MoViQ0JZ1MNdvHTFpgfpg0DRSzLBFZ3UIptoovs36Tz+rSG2qWW5x3bxKRr+uC
	Ivuf4tTxxzSTc7HPhJrZdUy+vw/oI59Jq4fm8exAco8ZhkGMqruNcqNj4bHw==
X-Received: by 2002:a05:600c:6792:b0:492:506a:f48c with SMTP id 5b1f17b1804b1-493c2b95d79mr33042095e9.4.1782967529661;
        Wed, 01 Jul 2026 21:45:29 -0700 (PDT)
Received: from chipmunk-161.. ([2a01:e0a:ce:f2f0:8a40:d7a5:890a:fa7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bbcfsm15405275e9.6.2026.07.01.21.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 21:45:29 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [PATCH 0/6] wic/help: Refresh wic create help and usage strings
Date: Thu,  2 Jul 2026 06:44:18 +0200
Message-ID: <20260702044425.846351-1-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Jul 2026 04:45:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4353

Hello maintainers,

That patch series refreshes a bit the help and usage strings for wic
create.

The first patch removes the removed option --infile, while the following
two patches list the missing options --no-fstab-update and --workdir as
compared to `wic create` output:

	usage: wic create [-h] [-o OUTDIR] [-w WORKDIR] [-e IMAGE_NAME]
	                  [-r ROOTFS_DIR] [-b BOOTIMG_DIR]
	                  [-k KERNEL_DIR] [-n NATIVE_SYSROOT] [-s] [-f]
	                  [-c {gzip,bzip2,xz}] [-m] [--no-fstab-update]
	                  [-v VARS_DIR] [-D] [-i IMAGER]
	                  [--extra-space EXTRA_SPACE]
	                  [--sector-size SECTOR_SIZE]
	                  wks_file
	wic create: error: the following arguments are required: wks_file

The fourth patch fixes inconsistent output between options by replacing
the character `|' to `,'.

The fifth patch updates the output of command `wic create` that is
hardcoded in the overview help string.

And the last patch outputs option capitalized values that are missing
for options requiring a value; also, it ensure the lines are wrapped to
80-characters.

Regards,
Gaël PORTAY (6):
  wic/help: Drop removed --infile option from help string
  wic/help: List missing option --no-fstab-update to usage string
  wic/help: List missing option --workdir usage string
  wic/help: Use comma to list short and long options
  wic/help: Refresh output of create command in overview help string
  wic/help: Add missing option values and rewrap lines

 src/wic/help.py | 52 +++++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

-- 
2.43.0


