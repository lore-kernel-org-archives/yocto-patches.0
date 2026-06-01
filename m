Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D42FCD6E55
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 23:18:49 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12720.1780355923133472940
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jun 2026 16:18:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ndSPBWc7;
 spf=pass (domain: konsulko.com, ip: 209.85.214.175, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf36a6905cso18203025ad.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 16:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780355922; x=1780960722; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZaYgB5sxJQCR6N/shrfavaj7wwDBCDDp0HvhRjyLdw=;
        b=ndSPBWc7R8aTo5Z7kwIhlvXERSdOX9PwDucw/mCHtWVz0M9JezEwdu4lXXHuFSR53s
         BxUCvPHvt0zKiVc10mGgM1I3pDhMbjOAeLfb7tObYYWigRrQFEYofsxC8kGeBRN52N5X
         YvoEzBXUgnd6oSUTxOGVcWn759yeSJPhJZ1dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780355922; x=1780960722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oZaYgB5sxJQCR6N/shrfavaj7wwDBCDDp0HvhRjyLdw=;
        b=kTuZ0nloSpmYUIZiTC07yREu7MdoIKs1lyir8KSROMQuT16hE8nAXD2kwDBJCJQTqF
         gJg34acaDiftVN0AHj4Oj7n8QPFwKnDkI1PHl2nilPgCk9EfWW2/YtKaKn0GnH3iNFjn
         VICXGlTGTLy+bgfLPscKJZdS3dH56aDNz9aea43vRYMCzPzwH4Crj6mlcDM93b4+0rud
         JdaiMgmSvsEA2B4/H2bAItIBp0Vai51U+qkcuy0mtSr4UiNDHRWb/kHLDndpUQ6uS7Pd
         KoW/+BJWbQvqmdBp29oiWXQfbvq310Ltl+vdUYSM5j2o+Dd/cNRQ23wXwrSUAW64Ruy1
         IgZA==
X-Gm-Message-State: AOJu0YyvgtWj5ziVsq7B5pGg/dV3+imPBBSaQWSapZ98ctGqBej8iNDQ
	IpnYpBkyOKHxhvDE7eBOo/Ah10jgj6U1QF/MjobxVqmO1CZopeCVCNxDRUQiyMjtVcPagIBhMnM
	Ebm9V
X-Gm-Gg: Acq92OFo5T+oE9irtSPIhEzDNBx+R9VsH0m5yHxVlhSzZq4xABPeV1vERksnu4JEfLZ
	TY2rytsY5ENbm1Hc1fz48nlCfm5pSz92BhnlAfXru2T17RW+V+tJoxJFY8H+XdDCON9cG4v2xhH
	PBLKXlGb+AonU9zFthr+x0GXy1B0gIt6pcGR9QfG7CC1igyelu4glTwI7YYLLL8batSeXVgMngd
	gOncm0pWL1517LXSt8AK8ZbQUmchS9hnt8lyfXx0B71h5WiQEJ3D+QG//YwW6X1w7a0fCwUDcAM
	1gK7u6RSpmvXFVXd5S2lwC61159l0wrndDVzpQOH8p4bZ5stajQCGJ62t1KxeBUpnzxjM9RM+Mr
	Qm54QEGHUxWRMq7qXoan63PHoGDbhZrHGrwUz2DFFbI7oVewtR5GuB0QbkXL5SNs9D/i5B0ljmQ
	hw+FjskUyOmfeYDeHuFo7HzhI4xsK6mO18rsRXx5d9oTmgTQYftnqNsrI/vMIyBSEtUcUagtG6L
	Z4AyU94p3Hw
X-Received: by 2002:a17:902:c949:b0:2be:1c3c:72bb with SMTP id d9443c01a7336-2bf36860a25mr157784465ad.33.1780355922442;
        Mon, 01 Jun 2026 16:18:42 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a00a53sm145613935ad.27.2026.06.01.16.18.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:18:42 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v2 09/10] scripts/run-config: push_containers workaround
Date: Mon,  1 Jun 2026 16:18:08 -0700
Message-ID: <242884114dd9bbeeac8bfca7dee5df4e19454f0f.1780354513.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780354513.git.tim.orling@konsulko.com>
References: <cover.1780354513.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 23:18:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4106

From: Tim Orling <tim.orling@konsulko.com>

Workaround for:
Error: reading blob sha256:<hash>: file integrity checksum failed for "<file>"

The first time the blob (e.g. bin/bash.bash) is copied, it succeeds. All subsequent
tries fail. Might possibly be an issue with sstate or a recent change to vcontainer-common
to allow for multiarch containers.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 scripts/run-config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/run-config b/scripts/run-config
index 0fe0385..03d921d 100755
--- a/scripts/run-config
+++ b/scripts/run-config
@@ -381,6 +381,8 @@ def handle_stepnum(stepnum):
                     # password from stdin (see login case in vcontainer-common.sh).
                     "trap '%s-$(arch) memres stop 2>/dev/null || true' EXIT" % runtime,
                     "%s-$(arch) --config %s memres restart </dev/null" % (runtime, auth_config),
+                    # workaround for 'Error: reading blob sha256:<hash>: file integrity checksum failed for "<file>"'
+		    "%s-$(arch) image rm --all 2>/dev/null" % (runtime),
                 ]
                 tag_cmds = utils.getconfiglist("CONTAINER_TAG_CMDS", ourconfig, args.target, stepnum)
                 version_recipe = utils.getconfigvar("CONTAINER_VERSION_RECIPE", ourconfig, args.target, stepnum)
-- 
2.43.0


