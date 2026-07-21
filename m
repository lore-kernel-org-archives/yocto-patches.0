Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B122C4451C
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 16:46:57 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27652.1784652412893570431
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Jul 2026 09:46:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=Q6Cp/VpI;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-256628-2026072116465038e26f1f9b000207d5-xdti5w@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026072116465038e26f1f9b000207d5
        for <yocto-patches@lists.yoctoproject.org>;
        Tue, 21 Jul 2026 18:46:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=i6nnAJDIwWz98nDzQz7PIBH6H2E4vuY1D56Rgyzk6iU=;
 b=Q6Cp/VpIdsspVIJFRPuhQW0a7sxf73uZuW0GCu7Y2p1lf+eilXW1E50MRV7dRqlp6HXOGv
 Zl8S9G2OyA0j50xJZMeCpk1bnBasotjHVx9o9Pdgo7RkxwXnW8PZyts7Od8d9okOK7A9azhf
 8H/51hrDPEhkug0g9WGFpTmaIahVq5mDK3sL4HuZwuh5gk21l5TTKQ0/o10Y/aeQ1NybbBTE
 Qh00X3wD0IhIaqV1kb4/0ZmxmH4xiPzxFy4ZAlEhSlPtuhcVQIqL2O7xZNfM4/dC4DU3VVDD
 2CWf/iEzI0T08YT72AvAhSOLM/jkDjBKPFPKFz5TUpXNKxelgbH2G0Ng==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [meta-security][wrynose][PATCH 1/2] tpm2-tools: set status for CVE-2017-7524 and CVE-2024-29039
Date: Tue, 21 Jul 2026 18:46:42 +0200
Message-ID: <20260721164643.39248-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Jul 2026 16:46:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4528

From: Peter Marko <peter.marko@siemens.com>

CVE-2017-7524 is a historical CVE and new cve-check does not undestand
fixed version data. Debian report [1] shows fix commit which can be
linked to release information.

CVE-2024-29039 is per Debian report [2] fixed in 5.7.

[1] https://security-tracker.debian.org/tracker/CVE-2017-7524
[2] https://security-tracker.debian.org/tracker/CVE-2024-29039

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
index e1a0c5d..c06115b 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
@@ -18,3 +18,6 @@ PACKAGECONGIG ??= "efivar"
 PACKAGECONFIG[efivar] = "--with-efivar,--without-efivar,efivar"
 
 BBCLASSEXTEND = "native nativesdk"
+
+CVE_STATUS[CVE-2017-7524] = "fixed-version: Fixed since version 3.0.0"
+CVE_STATUS[CVE-2024-29039] = "fixed-version: Fixed since version 5.7"

