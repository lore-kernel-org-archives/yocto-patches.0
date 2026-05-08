Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD4BCD37AD
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 02:00:54 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4505.1778205651381398038
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 19:00:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=JSGOjal+;
 spf=pass (domain: konsulko.com, ip: 209.85.210.180, mailfrom: tim.orling@konsulko.com)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so1057621b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 19:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778205650; x=1778810450; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nh4bcp7Dv4HSkseIi709lWKX5+tSq1zA9PLL4tWYeAM=;
        b=JSGOjal+ho+TXTUJHddldQnl4xWWmmuZjh+1TPEdjaAAsos09XK2lDAfWmIsrHTT7O
         /2n97+7RX5sxeia5HI0vWqOqbxTd5bKQGQfE6RktHPYJzvj7gpHBltioI98ioXiTr+TK
         Xm0bCM+Xq2vQHpf2Ez+O5Ixx7CNkerPEaZLik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205650; x=1778810450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nh4bcp7Dv4HSkseIi709lWKX5+tSq1zA9PLL4tWYeAM=;
        b=ZoisIs2/omxIcwMATjl5jg//+L0DgR7Nqjl5nQ0sjW5cpLzxQj5FoMaBZQTFa4VSeJ
         6a8zuvvKzNMN5TmMtH4Yjjbn9akiheQLVbhI+rdyxiC8k9dIKiKeEnKtDtTi2WF0AN9g
         C8uGTRksv/SVEG53ntqZ1jXWc9T6oXJnzVXbwAFbOq0TkSkeltt7cYwdR0HaNZO1iNIU
         jMBD6AzNd6AUPphapj/c0ER8BUH8hS1mt7Nt2xA6XiMv8936vKzE+zpHiNqSbfWzQQN+
         RjPm87j8CnOH3cbHKCUg2m5SpdnDeIIKoy0yZ0jTSOzREyNz1NICdG2fkQFYUgeitBLR
         Yv5w==
X-Gm-Message-State: AOJu0YzMX5RYul5N67qSNseqQk4opbxrX+PHDAQDLCQSzWnUSrZAbtmQ
	PNm3AZschfQyPudZWgvc/4g+i1jd+k3yTx2n9BevI79JCHzX3DLUMMYHjv0rhD5WAVNqtvazMRs
	oijgF
X-Gm-Gg: AeBDieux+bHKgz6oYhT/2BH7RxZPMwOtB5ellxxqHysv5Y4UWfzGFhDeTTPPcs8LptB
	aeFxD17D3jh/RtAJ3itVjo7B2ROGNRzolOGkok52803efESZorpGwP+WXgOtdOjrMnbYdTJ/TqH
	uJbMu8rauCVSubwUydAD1M9yaIrSK1xt7nXMrbGEpN1n+2nZ/7o5onjIOCMnGn6eB/Dkv+YPfWe
	0lL9UFna+9ozzZNgztHKO3EnsWmvaOyqswErzC599/GBe1WjYItOHVKJKQS9N8i9yKoHqGIp1SX
	lB7GHMOwWmd8r627aIlk/YyY+cC4nnBZtsD5MiX1g7aZ7EvSN5JuaFgrNDTjJsFQiuh5zdgAWiM
	AG/sD7Dt+fyS1A19/qZnPYKivI3KLeFsOqz31OcVJVBZzGUhooFjWaKOFWBEotM0DdKuHsqrUUj
	giobXl/qpBR9KWI95fVVpWWekKdDrYGeWvJ5OtPLKVmozNeUAd5YIZaMr8Pb2jLAvewQ0A1L08T
	A==
X-Received: by 2002:a05:6a00:cc1:b0:82f:9e98:1356 with SMTP id d2e1a72fcca58-83a5c4bdb96mr10871278b3a.20.1778205650436;
        Thu, 07 May 2026 19:00:50 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d34872sm10352726b3a.22.2026.05.07.19.00.50
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:00:50 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH 02/11] scripts/utils: warn and force re-download for HTTPS sources without SHA256
Date: Thu,  7 May 2026 19:00:25 -0700
Message-ID: <cb29a66ef6906c4bf576afbaf6cc42b41815d535.1778202125.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778202125.git.tim.orling@konsulko.com>
References: <cover.1778202125.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 02:00:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3941

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


