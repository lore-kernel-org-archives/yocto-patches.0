Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C460AC43458
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 20:52:51 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.957.1783630367701658742
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Jul 2026 13:52:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=MrWGAUGe;
 spf=pass (domain: gmail.com, ip: 209.85.222.180, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e533aacf2so11063185a.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jul 2026 13:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783630366; x=1784235166; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yav5KicuPccoti0w8SDQdAF5YeD5u7fAYl+xoxmtsfU=;
        b=MrWGAUGeYY2IRWFf0CmjPydpfaJtCsxjC5sc+aQCzkJpvolYkuMYY6JVtVOFH0pARw
         zJTe1IH6v59KRZp/u/0yW2Ryxi7VH4YIW4yO9qAL7S6ag7tXDW+eUJgx7wDNKl45f0Ge
         4A0sZn34I4+336vn6/cCARANRddgnRqkOPvQ/RiHaTz4qbjTM+PC8xSrK+ay8+jFSEPM
         RJgAxIReu0ZqBmOFdseDxH1svRbWVM7hj0h3qF72Ofdkc8wV4ZFkjUrrd12s3VBNC7Rs
         K2TmAuVrxQrtihGfs6/TK6DQhPN6xb1xd04MOGNMFyCidI9/IWHkCBG5IPR9eChk2LQC
         t4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630366; x=1784235166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yav5KicuPccoti0w8SDQdAF5YeD5u7fAYl+xoxmtsfU=;
        b=rvPsZxiwjrRtu7iwllmLR30n2jBS+7ZMqsoiLKezi+q5BW3TxU5CXP7Dv7CiUdMtX6
         jNd/6d3rxUvTllmfI4wDDeHcJo9MdlZldMTybtKwvxBlEc32Rjrx7lpVmuAY4TQRHSso
         QFnabRIEJhY0vOL2u/qGpTrH7DOOebMzL0KrBCzzu5UwgXlRT6Tm5aZ0qtve1kDA/3rV
         s5KTfsQ0v+tMWHDtJsYeOXUgWBYlAoxZVJIbysS1wJI9YfYpXEo5B4s0QU+KqR8297pD
         HmGn7I17pBrTaFrB6pZIjYdr2/GF99PG+uq/huNAvjme4qn+7FwabP4Ekpq9i1ECXzZx
         yW6Q==
X-Gm-Message-State: AOJu0Yy4Y/FhCcLeeqjpLNr8sR/lEnKtS228tGgiBK9ULI9hPD/w6XQ2
	WgUHnjbU0ttHoQ6YEJE/n9gyfwHBzjp04yWeV2+HmXQVo2NE3rm/rR3uJJYobw==
X-Gm-Gg: AfdE7cmIQlX5ClTApB8iR9+9sUXTVJE27/QiH05IIdxmuVq11shk96LZYZ9SuoPfq8/
	6U25Qx/Ejl4hgLtzSvnEcRqClUKexYORmDV6bKjh25TaU4VC806upnGAofvtqNnWC2ozeKpOTU9
	0z/AEzBvCL4a8HQgUGs1rJhAMu49O+U8+CIlfWFKLulZWzY9xd8YIy+Y4R3Tk/2H5weRXuvfE/R
	XHbFVkiMvHFhw1VZRn+yxp6fROerFE4aCFBEENB1Zc7EK+RtXXP4uWu4xiQCWK1gd0g++kUXLM5
	ZucA5ROGpZoXeuxrzEDCX2pjH5HCm/GCMPkuZNwkpa3n5ORCiOJs8nwH+6HU2NThbxuATZcC3gm
	I5dIs0I922eENqQwuPrUmFnNfXJuXzc6V7g6CSmj8BfdxYK88aAOrT3KD8axFV02hui9gNmef2p
	MQNCBwcPedxA/OUn2Xv4qPti//QHe3EV6vJsnAGC0w4zEfOKvbpVbNZFI=
X-Received: by 2002:a05:620a:400b:b0:92b:67e6:8ace with SMTP id af79cd13be357-92ecf8d4120mr947757585a.72.1783630366442;
        Thu, 09 Jul 2026 13:52:46 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d37540sm32893085a.38.2026.07.09.13.52.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:52:45 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH 1/4] oe/path: fix bare `false` NameError in __realpath's isdir guard
Date: Thu,  9 Jul 2026 16:52:24 -0400
Message-ID: <20260709205227.3470712-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260709205227.3470712-1-twoerner@gmail.com>
References: <20260709205227.3470712-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jul 2026 20:52:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4460

__realpath() finishes by deciding whether the resolved path is a
directory, tolerating any error from the stat:

    try:
        is_dir = os.path.isdir(file)
    except:
        is_dir = false

but `false` is not a Python name -- the intended value is the builtin
False. os.path.isdir() swallows almost everything and simply returns
False for a path it cannot stat, so the except branch is rarely taken;
that is why the typo has stayed hidden. But when isdir() does raise --
for instance an OSError deep in os.stat() on a broken mount -- the
handler that was meant to absorb the error instead raises
NameError: name 'false' is not defined, masking the original failure
with a misleading one.

Use the builtin False so the fallback behaves as intended: a path that
cannot be stat'd is simply reported as not-a-directory.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 src/wic/oe/path.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wic/oe/path.py b/src/wic/oe/path.py
index 3e95ea0ec923..862edc532ade 100644
--- a/src/wic/oe/path.py
+++ b/src/wic/oe/path.py
@@ -233,7 +233,7 @@ def __realpath(file, root, loop_cnt, assume_dir):
     try:
         is_dir = os.path.isdir(file)
     except:
-        is_dir = false
+        is_dir = False
 
     return (file, is_dir)
 
-- 
2.50.0.173.g8b6f19ccfc3a


