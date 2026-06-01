Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE6DCD6E55
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 23:18:29 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12710.1780355906572078617
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jun 2026 16:18:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=fXaBVEBf;
 spf=pass (domain: konsulko.com, ip: 209.85.214.171, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf114b0cf9so25473295ad.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 16:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780355906; x=1780960706; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nh4bcp7Dv4HSkseIi709lWKX5+tSq1zA9PLL4tWYeAM=;
        b=fXaBVEBfmatW+1f61rjD3Abm8H+kQcje3V8BnOCj2PRN0Qhaq0IoqowndbMENhkv8M
         gknSp/fbljTORZeymkotHd2xrogaF2veVM3kGxW7QesgwdIcduGQqYCJStJ6TjyCS5s4
         0N8EAZZ6YlqypbH41Q/XgPwfAXBOX0TeK67ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780355906; x=1780960706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nh4bcp7Dv4HSkseIi709lWKX5+tSq1zA9PLL4tWYeAM=;
        b=XrFN/PaltrHXQAdvtD/TuS6RmDn6OI5yMt4zF62WBe0tnDyDO2SRsSsSiWrhh8eCFt
         BCK5weC4Za8HWQACe2S2f/k+KBgoe1HmveZseTyQ8AjsksuwgDdqa5KKu3xCXaKIv2Hq
         UEK6KpZT6PQro2e3gHVo8ZK7dM/HCdsVpmiNlPPUMpj+hjHIm/2hMN6/4cxCnlxktLEF
         clSr7ec0SrzXkeIop9GZOFwLrFxCm1AWc1sNGYhO9J/QTxQlDzJ3vQUIO1IgQuShDRRH
         69ZXlIDpGBRsoaTEE0/OUnnutbRJ8wOZZYjMNm/Lu2WZb/uW0Qmt4rO92WyTp3N74FGm
         5bkA==
X-Gm-Message-State: AOJu0YxcwvkKjC6dbZNw9HtTRLchVSjC3dWcCVs+wV+ppF2hkNY5X0gC
	XgbPT/SIGD843sUYGTCGsSmR5cGGt5aeJBUwZ9EIXTKFtx5qOs1H1IkYLpiUMXnxWk6ginUTG61
	obF1t
X-Gm-Gg: Acq92OHB/22xTRCV9tGFw+hGssRI6DS741JiyoGX/YJSsqTn1I47VF8hX1MKuvjO6lV
	4OudAo9OO/xPm/39F7O3yxNS/tHrFMyVoknm9+UTZxLzPVpM8W49VW1pn+77t1Pdz3ZLMRhnHmL
	ZZ5ldoIWY+D3YdBY9jIOlh4kotDU0gaUEmCNb4EEK8/9f7KivEQi18GmB6Clkxn55dy/YGhO7ed
	R9yCpksGNKX2MLQUv9qL8sFpCkmZxBx9UuMcfT42fF0TxAshWSoIvWBBzd0WSbcRfU/+xy8fdWg
	7A5syDiJ/c526sdwgM10jM03XX9QnbSY2BqTFE7/9/J1F9sZgnW3qxGRWxAC91Fy398haTFWd1R
	YarYAoQVo1Jz2k9K7mrVJDPkrWL8OB1cf8EpwpeoehOFW/H9Gz0bpcHRWmlnWQYeKoOl3AiVyXw
	hax+XdTCbs0LdUJzQY6PCQ3a3ZxamV2hSnEyOqRgJNKuzmtBHLTIZtLz6bqRq5EY1ZR2NBxhkXq
	KKqmlBM2bR4
X-Received: by 2002:a17:903:3884:b0:2bf:33a9:bf4a with SMTP id d9443c01a7336-2bf368a3d92mr159245785ad.38.1780355905965;
        Mon, 01 Jun 2026 16:18:25 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c0ce622c26sm68104205ad.67.2026.06.01.16.18.25
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:18:25 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v2 02/10] scripts/utils: warn and force re-download for HTTPS sources without SHA256
Date: Mon,  1 Jun 2026 16:18:01 -0700
Message-ID: <abc1ae081ae8d20fdd70192f81e93a9fbd745b15.1780354513.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780354513.git.tim.orling@konsulko.com>
References: <cover.1780354513.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 23:18:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4099

From: Tim Orling <tim.orling@konsulko.com>

Without a SHA256 checksum there is no way to verify that a cached HTTPS
download is still current. Rather than silently reusing a potentially
stale copy, delete the cached file and force a re-download each run,
and emit a clear WARNING telling the operator how to avoid the overhead
(by appending ;sha256=<hash> to the URL in their config).

AI-Generated: Claude Cowork Sonnet 4.6
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 scripts/utils.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/utils.py b/scripts/utils.py
index 87acad6..ea905d9 100644
--- a/scripts/utils.py
+++ b/scripts/utils.py
@@ -505,6 +505,14 @@ def setup_tools_tarball(ourconfig, btdir, bttarball, name="buildtools"):
                         # that a freshly-published tarball is always picked up.
                         if os.path.getmtime(bttarball) > os.path.getmtime(btdlpath):
                             os.unlink(btdlpath)
+                    elif not bttarball.startswith("/") and os.path.exists(btdlpath):
+                        # HTTPS/FTP source with no SHA256: there is no way to
+                        # verify the cached copy is current, so force a
+                        # re-download every run.  Add a sha256=<hash> suffix to
+                        # the URL in your config to avoid this.
+                        print("WARNING: no SHA256 provided for %s source %s; "
+                              "forcing re-download to avoid using a stale cached copy"
+                              % (name, bttarball))
                         os.unlink(btdlpath)
                     if not os.path.exists(btdlpath):
                         if bttarball.startswith("/"):
-- 
2.43.0


