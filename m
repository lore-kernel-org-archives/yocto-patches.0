Return-Path: <ppjadhav456@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B094C83F09
	for <webhook@archiver.kernel.org>; Wed,  9 Jul 2025 14:38:45 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.17418.1752071921232359993
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Jul 2025 07:38:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NCO8kr7D;
 spf=pass (domain: gmail.com, ip: 209.85.210.175, mailfrom: ppjadhav456@gmail.com)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-747c2cc3419so4636051b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 09 Jul 2025 07:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752071920; x=1752676720; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWuok0Du2O4JfFrZjSTLW/tWFLkfXmcIfpG05GPOBaM=;
        b=NCO8kr7DYue4UjgV8qtIIbE+Nx1572YMwbJkDGioDZSGsk5ihsJuLjUFLHaAMf/Egb
         H2VkPyVgZ6NIdUK7gv7RmOUaTCPFg4sHpoUDLUuOeawDCiYQ781EL9StUNsRfq9eWg/w
         dwv646CFVZrWc2EjyDb9hZsBeJDPJ6R1NEJGbRp6yHnIrYqMvXP8V/OSi9iZ54MyQJHd
         8ryQ7bc0NLeX+JhUWJKl+2oJ7p9zsQI7HLBXFOE+qVS16ALFjM67ZnNP5N8N2CK914+B
         adNOa6uwbJDAmgmQayUFmo9R6hiTqi0oYyMyPqopANz1VzksxVQFa91G5U9i+PnDN5Ao
         JTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071920; x=1752676720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWuok0Du2O4JfFrZjSTLW/tWFLkfXmcIfpG05GPOBaM=;
        b=pwQnbBXt3jMQBos9cJCoQvUX5PrcvLa7M81SjNyuJrAP4umM/IGf8o3MPp3XIo5YBe
         pXZfhh4+lrNtLug4FQh0c0VJ7BraJdjlCCpgakq1Sqv972vu9yRfoXM9dN0EOYsXKyeY
         tYgM/DAzIsDIwkQUEp5gzmCfSuWSGyzOUMguuFOxfmqtf+uFnKBPXAxKDgJlijmEDYfp
         5oEgVxLWqQa5XYtrEkIKFobouY0/HXeQGGRp6XOpWhPSCpiiJ2sS01Vmd23cOjk+QWad
         KXgmis5CMRi2jnwv7sO1ak+hvTkXC+8D/ug56MxXSmICZoA1KOwz0czjf1K3VRpji5yD
         /CRw==
X-Gm-Message-State: AOJu0YxIbFFrWz6OSkP9SxeeAz+WHzuAMx3JDbd0z4SSyeDxDTaPweGU
	v8wPb01KnsOJltjEOaeXdsv5wLNAKyuuIOFcu6Jgb0WXlbsi830g064kMfKcJA==
X-Gm-Gg: ASbGnctL3he4ZPCYbWozSpQ10uhbM0cdv8gQyXUSqgMs+hfgbBL5NK3JLsNV6+ermZF
	cBNuSIRktw8oZuQ5QS7hk9nkOwH1njvejrCiQa1Bhfx/MWff/cmSADuPcucXoqO+tXxuEHEwhUY
	LNWFzR48G9lQgvJVmpDDZTU2x0si6qeS+mzHG2DxVxTLCA9gG50+R17+1U6gYb8svqDHWo8SBt5
	2rR8bbKOTggsPsKuEt9+KxsYT9tPelnFooEdM2Gem+rKbJIfrMcjwct6YzLktfIPiLGzY3dYEGf
	Q9FV5W0EDO857+TsE06XMJ2epCCij2KTF+kDVGTmIxa/mGOvErGg+tA510aaSLmYRqr+rxwWiA=
	=
X-Google-Smtp-Source: AGHT+IGSrY9Rj/n2Z6C3P/yeqRWEvqv1Jn1KYxJPTVGz/DoTqh1RgBkIxF7c2QRqo2pU4J9RLvk5DA==
X-Received: by 2002:a05:6a00:3a05:b0:748:33f3:8da3 with SMTP id d2e1a72fcca58-74ea66e7574mr4291376b3a.19.1752071920357;
        Wed, 09 Jul 2025 07:38:40 -0700 (PDT)
Received: from L-15936L.kpit.com ([43.231.237.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a1ca0sm15341199b3a.138.2025.07.09.07.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:38:40 -0700 (PDT)
From: Poonam Jadhav <ppjadhav456@gmail.com>
X-Google-Original-From: Poonam Jadhav <poonam.jadhav@kpit.com>
To: yocto-patches@lists.yoctoproject.org,
	ppjadhav456@gmail.com
Subject: [meta-selinux][master][PATCH 2/2] libselinux-python: Add native support
Date: Wed,  9 Jul 2025 20:08:29 +0530
Message-Id: <20250709143829.308552-2-poonam.jadhav@kpit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709143829.308552-1-poonam.jadhav@kpit.com>
References: <20250709143829.308552-1-poonam.jadhav@kpit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 09 Jul 2025 14:38:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1795

Add native support for libselinux-python
to fix build error for setools-native

ERROR: Nothing RPROVIDES 'libselinux-python-native'
(but virtual:native: meta-selinux/recipes-security/setools/setools_4.5.1.bb
RDEPENDS on or otherwise requires it)

Signed-off-by: Poonam Jadhav <poonam.jadhav@kpit.com>
---
 recipes-security/selinux/libselinux-python_3.8.1.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-security/selinux/libselinux-python_3.8.1.bb b/recipes-security/selinux/libselinux-python_3.8.1.bb
index dd0ccd2..582edf6 100644
--- a/recipes-security/selinux/libselinux-python_3.8.1.bb
+++ b/recipes-security/selinux/libselinux-python_3.8.1.bb
@@ -55,3 +55,5 @@ do_install() {
     sed -i -e 's,${WORKDIR},,g' \
         ${D}${PYTHON_SITEPACKAGES_DIR}/selinux-${PV}.dist-info/direct_url.json
 }
+
+BBCLASSEXTEND += "native"
-- 
2.34.1


