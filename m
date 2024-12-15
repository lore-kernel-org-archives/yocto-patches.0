Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8DBE7716A
	for <webhook@archiver.kernel.org>; Sun, 15 Dec 2024 20:15:44 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
 by mx.groups.io with SMTP id smtpd.web10.42418.1734293736106492357
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Dec 2024 12:15:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=H5RObsNV;
 spf=pass (domain: gmail.com, ip: 209.85.128.181, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ef60e500d7so24077567b3.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 12:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734293735; x=1734898535; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M2V07RjEAnfGajzovv/jV/rZcaeNBojSx22NEDiDnhI=;
        b=H5RObsNVPZYsmbrk3ueeiUQNnBGVh/OLen7ADGBnFdUfmXl7MCW8rSOYkbIDKISeRh
         AtrtyTUd1WTR4e4Lxiy1JknwYeOd3aoJD44nsnOCAjk6lNDm7CC6BLh/aKSywheVUZ2I
         h3CH8kQzWy5kS0Hem7WdhNVBFHGCk9YFsEHg0GrnkqzUOFxfTVb0PbsUOWSaH7nF7nPa
         uX4QzrjjdaZ33lE0Tusvtk5ydzXoEE+wQf8vkcBJ+OSGQ/tRFF015ULIxGtqRHXzLk1v
         Uhrni3/MVMMWniukbGFBRoa6HbZGTv/HHnUcKwCTkmKAMrYyfIW2uhz2ZtuJ0zAkblz6
         SY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734293735; x=1734898535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2V07RjEAnfGajzovv/jV/rZcaeNBojSx22NEDiDnhI=;
        b=pZD3QsXaLMrhLa8CXi4ydFZhGZ77xBF2VR92BFpUqDOPkCQKH+uNJ53fYcLo9B1wEB
         ygE/fsiyI7Zin/QgbKN09fmbw/z1u3tMldbZ3nin2RN51cjcPKKGq6BWI4hGS8wMXmxt
         FYkbMDwe2RX/z/+2XgKHaMli+0JcA2ePUdXw6BCtGTZk1yvB1Gwf+fjUW5LSaAd85MaP
         DDcTN6vlRdu43MMbFBR4Zwd/9Go7oXV8LqM3YQp366uPObXg5i2H3ZMbAV492nOp1K25
         kN/zyTQra+s0j+u5S/hRYGuftTZ4FWYAzyylWmG4i09csusJ+pef4PoSvMl56Egm1i9C
         XxJw==
X-Gm-Message-State: AOJu0YxTLkVfr3sg09kYjDTcT0jTtJ8cucG0Fcda9uj8FiDxFfp6+wF8
	1wIdTA/IMebKmezqmE3Y4xYBIaT5V4T57Ron6ko/SCDeGbyh76/PA1f343QO
X-Gm-Gg: ASbGncsh4S6ODeHPk17htVvNcBqPyW9cltvSxMflJkIQ7H3YOyl0QVLIxrO2GUHFonO
	K8zJH5zRlawptuFRNwdTLfXgzWK6wkSYIcVxjyE2c6q0GKLoedcf6nMHAjtZ7k43RXSV54zZyBs
	eBk6f16cA38zoOhsEgyWoJ6J06yYYXaZTlv/QVENMdUl05XBdTN7JI0XZ0pN69Vyx0DiBik3jlf
	mfXtOqKfWa8l2/ir6TSgis/ZgDHlaq98Cih88aIVmyqJhcNZfibqdyZfOKf4Uv8LiHz/A==
X-Google-Smtp-Source: AGHT+IHb2XVziDlL5voC53SXT60Y3mRQEdQYxDNOaxx7LSBkIEtM90omGScqjRsrI5zp+2DZZ0j3Kg==
X-Received: by 2002:a05:690c:4512:b0:6ef:9dbe:9f82 with SMTP id 00721157ae682-6f279b7c5b6mr92418337b3.29.1734293735098;
        Sun, 15 Dec 2024 12:15:35 -0800 (PST)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:a906:ba5:bc1d:da36])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f2891ee3c8sm10319667b3.100.2024.12.15.12.15.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 12:15:34 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] chkroot: update to 0.58b
Date: Sun, 15 Dec 2024 15:15:34 -0500
Message-ID: <20241215201534.783807-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 20:15:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/917

LIC_FILES_CHKSUM changed due to yr update.

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 .../rootkits/{chkrootkit_0.57.bb => chkrootkit_0.58b.bb}     | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
 rename recipes-scanners/rootkits/{chkrootkit_0.57.bb => chkrootkit_0.58b.bb} (90%)

diff --git a/recipes-scanners/rootkits/chkrootkit_0.57.bb b/recipes-scanners/rootkits/chkrootkit_0.58b.bb
similarity index 90%
rename from recipes-scanners/rootkits/chkrootkit_0.57.bb
rename to recipes-scanners/rootkits/chkrootkit_0.58b.bb
index d35f5f6..a6c4090 100644
--- a/recipes-scanners/rootkits/chkrootkit_0.57.bb
+++ b/recipes-scanners/rootkits/chkrootkit_0.58b.bb
@@ -3,11 +3,12 @@ SUMMARY = "locally checks for signs of a rootkit"
 HOMEPAGE = "http://www.chkrootkit.org/"
 SECTION = "security"
 LICENSE = "BSD-2-Clause"
-LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=fdbe53788f7081c63387d8087273f5ff"
+LIC_FILES_CHKSUM = "file://COPYRIGHT;md5=6db4d77fb8f0cc84d175e7a1211e4c13"
 
 SRC_URI = "http://archive.ubuntu.com/ubuntu/pool/universe/c/${BPN}/${BPN}_${PV}.orig.tar.gz \
            file://musl_fix.patch"
-SRC_URI[sha256sum] = "06d1faee151aa3e3c0f91ac807ca92e60b75ed1c18268ccef2c45117156d253c"
+
+SRC_URI[sha256sum] = "75ed2ace81f0fa3e9c3fb64dab0e8857ed59247ea755f5898416feb2c66807b9"
 
 inherit autotools-brokensep
 
-- 
2.43.0


