Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48FEC4452B
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 16:46:17 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27599.1784652371943316465
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Jul 2026 09:46:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=J0Pyk8mk;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-256628-20260721164609ac8615d1f6000207fa-91nwbb@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260721164609ac8615d1f6000207fa
        for <yocto-patches@lists.yoctoproject.org>;
        Tue, 21 Jul 2026 18:46:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=PU/4MfjqHhzHx/+o3WOlsiaIn11urVBR+uPCnHk7KOM=;
 b=J0Pyk8mk2E3Er6uBjk2/mft69skoux6ajoxXs6ZUYReMVDdM7/3YsmiVx6IXktspgbXGbV
 CgDKw9Z8DgfLPtDpqEvB/FS2HfJLzfa6rBignR46+4TBkJowDdEjzayNatPhSLl77al7GNLt
 1XuLXA2D5DMK2mEEhYgrQEKbpzVn/i3aCMXUs0Ia1TNU5bJeP32YJr8ScS9bNpGm4x7iHAS0
 tSm2n1Ef+iWIjfv1zB5g8B8qaRe3fA6RTWaM6D9sQXZJrZgC2dNvB1pHVKDp1dGDu2DBE077
 fwcXsr+LkMxK8tXm6p3GNxzsdI2TcBCCjy8C1SarakKswv4158aEHp/w==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [meta-security][PATCH 2/2] tpm2-tss: set status for CVE-2024-29040
Date: Tue, 21 Jul 2026 18:45:36 +0200
Message-ID: <20260721164536.39190-2-peter.marko@siemens.com>
In-Reply-To: <20260721164536.39190-1-peter.marko@siemens.com>
References: <20260721164536.39190-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Jul 2026 16:46:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4527

From: Peter Marko <peter.marko@siemens.com>

CVE-2024-29040 is per Debian report [2] fixed in 4.1.0.

[1] https://security-tracker.debian.org/tracker/CVE-2024-29040

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
index 67a51e4..69c9d63 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
@@ -93,3 +93,5 @@ FILES:${PN} = "\
     ${sysconfdir}/sysusers.d"
 
 BBCLASSEXTEND = "native nativesdk"
+
+CVE_STATUS[CVE-2024-29040] = "fixed-version: Fixed since version 4.1.0"

