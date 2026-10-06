Return-Path: <rsangam@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2E4CA5FFC
	for <webhook@archiver.kernel.org>; Tue,  6 Oct 2026 10:41:25 +0000 (UTC)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42489.1791283281317530682
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 06 Oct 2026 03:41:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=Iyaz0hqL;
 spf=pass (domain: mvista.com, ip: 74.125.82.52, mailfrom: rsangam@mvista.com)
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1419d3416ceso4462225c88.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 06 Oct 2026 03:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1791283281; x=1791888081; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tUO6KjN80WHixZy0vIxY2OYUuknXvSrui1Ybg3joCxw=;
        b=Iyaz0hqLZZEWJHJSsY+9YBqHAHka6eay18tBUIXbp7Cw4Zosf/afJoJ5ejg3vu0ljA
         FoPN6xfPPh8Yxqs9ezoLmjDVZdZiyynvYUnrz5Rnbh0u8rxshG4DsLtgkRq9GCqID97L
         sKDvC1dbyKsK+ym0ZVVLQn/2UN83CEc/e5qFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791283281; x=1791888081;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tUO6KjN80WHixZy0vIxY2OYUuknXvSrui1Ybg3joCxw=;
        b=0cheCkQhn0/lpeG9povGoVQgO7eHjLm+BOx+kBJvC/R6TWSx63TU8TBWKX9y20SpZd
         rHXc5umc4WMNLgAPde8PcpIU+fDd3PQSQ4rBfBZsp7/2WiQWsOKybs1xe1CQLAEpE+fQ
         qp7MBpTVqo8EugrksJSQSP1hR01P/ngjIDLVIeXBFx7CZvP150YS6MLswY1BIKvrKIca
         iD6IO+d2hibt7qVPCt5hfH+a8ZT+5R4uw7X8E+y6lJZK6c8ssX374dFe/Vx31Zdcydjy
         StQgqdZkyLStHpPpPQnshqVmp9A9iTGXsBQv58g12+PMEAh4a04+xXjryps4W3O/+YdI
         rPUQ==
X-Gm-Message-State: AFq9FYIDQXYC1dba5nfLaSu/yeZGXI+L6Mvndiw+TuIMggKO79rnkL22
	o8krDfuHJKXMsAJ+lo59iLBq93FKM4w0Ca1JLgQd92KyZcrWeGB03aHwNcKyNoWW6LuV79fmJ5D
	cYAsABzk=
X-Gm-Gg: AYBFou1XXh9YGVECEPUNMjtrX8CjEGAZdYCGgt0WJ0vN5TZqVQ6vTPdkn89C4mpf6V/
	2fjN0Ut2WiJm6hDlCjS8f3PiWlBrGoJjEAkFj2aecCKvcwaI+sm6FsJVgY/mt+Jacnt4NeQGBUt
	46XpPx762SDN00qEbj+3K8jG/O5lsBD5kMhrWqwp906gGXh6/rihe5L+MnE8RrVtuBn1j8pq8G/
	L82OGH1smYMUowjL1Vx86TseL+kw9shc8nECsQPF/0PnUEaBNcrWoosojW0knOhs97S8Agw/7+7
	GVEQtVIykSqHnzQ8kkPOvuvPH+a3u1XGfV9PctFTbZv6ESb3xF8fWCMqd+bBSoJNit74+32sDRY
	K6zc0DgvLfe8sIwsCYgRfm2N+IrcdStTGeJMCnPssofPeLwzIoJoqwNF1xxVbdXBGtYigQeCnlR
	lON0hiFJAIReSAFsN/jRLDWvPvAjH6sfOJ8NlVAW/MsDFn7FTSYc4pwZ/YNxpKl5LtnZ/SBLXJI
	bDpIAQ=
X-Received: by 2002:a05:701b:2506:b0:14d:ef19:246f with SMTP id a92af1059eb24-151c425f5e8mr14978520c88.45.1791283280419;
        Tue, 06 Oct 2026 03:41:20 -0700 (PDT)
Received: from MVIN00040.mvista.com ([49.207.216.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-15d819cb585sm6112186c88.5.2026.10.06.03.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:41:19 -0700 (PDT)
From: Rohini Sangam <rsangam@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Rohini Sangam <rsangam@mvista.com>
Subject: [meta-security][scarthgap][PATCH] sssd: Security fix for CVE-2026-68743
Date: Tue,  6 Oct 2026 16:11:07 +0530
Message-Id: <20261006104107.59881-1-rsangam@mvista.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 06 Oct 2026 10:41:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4992

Pick patch from [1] also mentioned at Debian tracker in [2]

[1] https://github.com/SSSD/sssd/commit/bef9d12617f22335e65447609a2724a68c1bf68a
[2] https://security-tracker.debian.org/tracker/CVE-2026-68743

Signed-off-by: Rohini Sangam <rsangam@mvista.com>
---
 .../sssd/files/CVE-2026-68743.patch           | 43 +++++++++++++++++++
 .../recipes-security/sssd/sssd_2.9.7.bb       |  1 +
 2 files changed, 44 insertions(+)
 create mode 100644 dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2026-68743.patch

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2026-68743.patch b/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2026-68743.patch
new file mode 100644
index 0000000..f5b8345
--- /dev/null
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2026-68743.patch
@@ -0,0 +1,43 @@
+From bef9d12617f22335e65447609a2724a68c1bf68a Mon Sep 17 00:00:00 2001
+From: Alexey Tikhonov <atikhono@redhat.com>
+Date: Tue, 4 Aug 2026 20:51:07 +0200
+Subject: [PATCH] pam: validate auth_token_length in extract_authtok_v1()
+MIME-Version: 1.0
+Content-Type: text/plain; charset=UTF-8
+Content-Transfer-Encoding: 8bit
+
+The check mimics one existing in `extract_authtok_v2()`
+
+:fixes: CVE-2026-68743
+
+Assisted-By: Claude Code (Opus 4.6)
+Reviewed-by: Pavel Březina <pbrezina@redhat.com>
+Reviewed-by: Sumit Bose <sbose@redhat.com>
+
+CVE: CVE-2026-68743
+Upstream-Status: Backport [https://github.com/SSSD/sssd/commit/bef9d12617f22335e65447609a2724a68c1bf68a]
+
+Signed-off-by: Rohini Sangam <rsangam@mvista.com>
+---
+ src/responder/pam/pamsrv_cmd.c | 5 +++++
+ 1 file changed, 5 insertions(+)
+
+diff --git a/src/responder/pam/pamsrv_cmd.c b/src/responder/pam/pamsrv_cmd.c
+index d4cb421..a6145d1 100644
+--- a/src/responder/pam/pamsrv_cmd.c
++++ b/src/responder/pam/pamsrv_cmd.c
+@@ -419,6 +419,11 @@ static int extract_authtok_v1(struct sss_auth_token *tok,
+ 
+     SAFEALIGN_COPY_UINT32_CHECK(&auth_token_type, &body[*c], blen, c);
+     SAFEALIGN_COPY_UINT32_CHECK(&auth_token_length, &body[*c], blen, c);
++
++    if (*c + auth_token_length > blen || SIZE_T_OVERFLOW(*c, auth_token_length)) {
++        return EINVAL;
++    }
++
+     auth_token_data = body+(*c);
+ 
+     switch (auth_token_type) {
+-- 
+2.44.4
+
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.7.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.7.bb
index f92fe65..52dce32 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.7.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.7.bb
@@ -26,6 +26,7 @@ SRC_URI = "https://github.com/SSSD/sssd/releases/download/${PV}/${BP}.tar.gz \
            file://musl_fixup.patch \
            file://0001-sssctl-add-error-analyzer.patch \
            file://CVE-2025-11561.patch \
+           file://CVE-2026-68743.patch \
            "
 SRC_URI[sha256sum] = "6b5284a4d72b67c0897699794360d79e0f67461957e20273c2649f025e76c248"
 
-- 
2.34.1


