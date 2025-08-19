Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D90FCA0EEB
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 14:30:04 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web11.16211.1755613795519628047
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 19 Aug 2025 07:29:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=BGMgu5hg;
 spf=pass (domain: konsulko.com, ip: 209.85.219.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70a9282141fso59149966d6.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 19 Aug 2025 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755613794; x=1756218594; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zL4CuYLRVDSMVry+rZOeNUlIU4EOeDcB1k00iR2eMDA=;
        b=BGMgu5hgjDNGkvit3DbsbofWZ4m7GHqudAsgCqMX3XTbEdCljP2O+WJ31r4divnmS+
         eFj6xUThUbOlYORQotzsfuRnoygwzKs/Qx11UghJoZHZMI7mhr62KkjH7t+36V7XHQ5B
         whNmyt0avzS+FvVtf5lKCKOPDanxIrlEVHWlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755613794; x=1756218594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zL4CuYLRVDSMVry+rZOeNUlIU4EOeDcB1k00iR2eMDA=;
        b=Zdv0S2vlirwunjHnKMBzYHQK6oLrMsiH6+8IoO0jEdrgrL3uMbEAKH5b/HgZPjb9Zb
         765iHrxpxbalIxj+dAWzp2vPqi3YHqDhakg1+6/BHIiR383d4ZYCI6iyoVL1POpYFcYf
         aUFa1KljpT7O76bqYD1LEu+yJw9W2mO92gXfDEysEUMdGezrSxMVtMQQycdpHRViLzWd
         TNzm9BePd1mbWCr/IUWgUrcAyPNXdWrY1heAN6FqjCKfKsjoqNxrVG0b4njwTx30i8qk
         K5AukgPFWhZim4XyMjvFBKTUNyALRoe5gsOfeGLQGjPCObDH0kI1loiDW/Bwbol6oQcQ
         yT+A==
X-Gm-Message-State: AOJu0YzhqJ9xnXS9ZVULdkTGB01Nl1x8uUkxIhEnWLPALBcxsoCKvuPx
	8Y1qxhZH3eXqyhS9+MGRZBv2g5AlKTG8fQp2E6hL9zwTDYdQIqOYAdMPGDEMlr3irqVxsl0YEoR
	Kzz++
X-Gm-Gg: ASbGncthbmjdwK6nePUcnISupTuH+/QwqC2L2NYEZ29NRHvAHCmA3TZpJQw/xd81PVy
	JI6RIMXq3iMafMwpjTmok1uv+wGjJp5nHg4Xvl93uLCzSUzc96oy5Qpwayekeo1g662Is7CfXGU
	ZfZIgo0zDKjj17Npf4s/n1IYL0MocstkMMod2ssFeju47AX9BCJfjTMM3A+ITvLLTV9iyelJq/o
	sATKR/6wzcVUiig9oqoN9q0ExFlQulNNc46hje4kYxoDRRw6bQRcrKO95tU2vMNuXWv+SO3xG31
	O96pZkB1pwTqNCVjhGHvSm6zx6/iHYoo+mV2yc9iEPrGOXPtRKu/yQgFGgX0QILurNacmNYfjGd
	386BxN2QkUlWYctNkbWNLuqu+H1MnUL8ZC+SkxM9ouHEsJPFLi//D0GIzqRbn/LDLYIBBg1J0WA
	==
X-Google-Smtp-Source: AGHT+IHgOvK/o89TRC2m4hz7So8tCGTBW3VM+ttIFfsKEUL3Wwl02dUZn7q5grTfu59G59oWmN9RKA==
X-Received: by 2002:a05:6214:234f:b0:6fa:ccb6:602a with SMTP id 6a1803df08f44-70c2b6325aemr31022836d6.20.1755613794193;
        Tue, 19 Aug 2025 07:29:54 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9032801sm70124996d6.16.2025.08.19.07.29.53
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 07:29:53 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH] selinux-python: add python3-pip-native dependency
Date: Tue, 19 Aug 2025 10:29:34 -0400
Message-ID: <20250819142934.97424-1-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 19 Aug 2025 14:30:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2055

Add python3-pip-native to DEPENDS in the selinux-python and
libselinux-python recipes.  The dependency now needs to be explicit
since pip has been removed as a dependency of python3-setuptools-scm
in oe-core in:

https://git.openembedded.org/openembedded-core/commit/?id=101f2f9f

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-security/selinux/libselinux-python_3.9.bb | 2 +-
 recipes-security/selinux/selinux-python_3.9.bb    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-security/selinux/libselinux-python_3.9.bb b/recipes-security/selinux/libselinux-python_3.9.bb
index 8431ca1..a4de036 100644
--- a/recipes-security/selinux/libselinux-python_3.9.bb
+++ b/recipes-security/selinux/libselinux-python_3.9.bb
@@ -19,7 +19,7 @@ SRC_URI += "\
 
 S = "${UNPACKDIR}/${BP}/libselinux"
 
-DEPENDS = "libsepol libpcre2 swig-native python3-setuptools-scm-native"
+DEPENDS = "libsepol libpcre2 swig-native python3-setuptools-scm-native python3-pip-native"
 DEPENDS:append:libc-musl = " fts"
 
 RDEPENDS:${PN} = "libselinux python3-core python3-shell"
diff --git a/recipes-security/selinux/selinux-python_3.9.bb b/recipes-security/selinux/selinux-python_3.9.bb
index b452887..029ac5e 100644
--- a/recipes-security/selinux/selinux-python_3.9.bb
+++ b/recipes-security/selinux/selinux-python_3.9.bb
@@ -16,7 +16,7 @@ SRC_URI += "file://0001-sepolicy-fix-install-path-for-new-pymodule-sepolicy.patc
 
 S = "${UNPACKDIR}/${BP}/python"
 
-DEPENDS = "libsepol libselinux gettext-native python3-setuptools-scm-native"
+DEPENDS = "libsepol libselinux gettext-native python3-setuptools-scm-native python3-pip-native"
 
 RDEPENDS:${PN} = "\
         python3-core \
-- 
2.50.1


