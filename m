Return-Path: <t.f.g.geelen@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DF9C2A069
	for <webhook@archiver.kernel.org>; Sun,  4 Jan 2026 00:49:59 +0000 (UTC)
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35356.1767487791233776260
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 03 Jan 2026 16:49:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VR4flsrv;
 spf=pass (domain: gmail.com, ip: 209.85.208.68, mailfrom: t.f.g.geelen@gmail.com)
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-64b8b5410a1so14938068a12.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 03 Jan 2026 16:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767487789; x=1768092589; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YT3KgcxVaF3S/TYKvh/FNOpxKwjgJCjCGsLD/CR9s0=;
        b=VR4flsrv76SZESX0nAW2h/kiFZEuR1zl9NEIAJI/nzx5tNvTQLbeacXcidavGhc6dE
         i9ENWgCx8ORtb/Pc0o4ge2m+tu6zqHUTCPkY/Yzgyhcbg33oJbmBk8WYmqvTPqkK5NS8
         pfmnPgcmL4yq7m6ZDS8OjfO3LZ9Exbvz1wcGEXYt4P0UZzOBm3vztxLhBYRNdb5q+tkB
         Ccm7//4DkvRDqNJzNwfYfoHd8AaECOI9od35wIGaa0iqrA1s72n7+HqGdxLUcU0eiTa1
         b/5rzR0iw6LCWJqBaNjhOCybYYRmbSSuGfs/Kvh6dDLV6fp20SvoCDoBZGav23pP1ZF+
         qrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767487789; x=1768092589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6YT3KgcxVaF3S/TYKvh/FNOpxKwjgJCjCGsLD/CR9s0=;
        b=pogmmthH/l1Mbo17AeadWsqp6Zp8KfulhWubXyq80yqDUsWChG3s/Sh6D/BQ0BlKcV
         925IAWpfTjSndmoWMf4Xp5KAmdIypPibV7dkHzi9aL9Rp3z6eR298KiyfxBJlljxK/O9
         JSp0cj+2ae8xKoEonzeGe3pL2OFVpF9lFYYlXuULZRX1oVrfUmq35pBZxAw/nygnksGa
         U08W9F/Uicj+w8KXJmeHDbbQq+IpO8v5I2HK/dNZNr1kNDuB9a0Su/hXgHq+pZANca7j
         4werTQ4puZMVq0TG/oTfaNWtAbxUm4GPHg7fd8fXiFBJmg+978p/gh6LWkTDTwUHJFfn
         poyw==
X-Gm-Message-State: AOJu0Yx/bcYcqHPdqdJImMI1+HkSnd3v4/bJ5dgX21KVzRnJR+NPbdx1
	sJ3gbdzwcAC+GgOyP5N4gMasrXAD2lDXAPHYxztkpEDxcKHonU8iR3R7yj9MJoiicLw=
X-Gm-Gg: AY/fxX5YRQJU3INJVJmtrGRWTnerzcQRjXuhE2nJ/E67nAudnQ7W3AHxeHmCKP6IBK/
	hJYhO3UMYTd1egVb0/EwkEbVDEgXe8IJTJ20dddQCR6Fgk0klHnMEm4i2vxfgclixT3os1PCVGJ
	AjQ4kvWVc+ldMj9MwdbCwsL4UT1VUDmel3x/C4IkP3i05eh9e52ifyBEn+OlUtZNfyoYRdGrpfy
	/dpAlwZgUHOm4l5t4Gh8s7heLLITGJhyhVTiIaIpM1RBkfdkg++0ir948VBjYlrN5+a3gqdJznA
	5a5iBjZM0/IKZTpNuHLpLdS6qLFmw373cw4whM6W0u8APBu/EwaDthVJV2Sqfys7yw9lFoxKYD0
	0NYdVi71p3ApcT3PypNRp9CzaUzgQK+BahLKwAV6EjTRiShh7LS5t/bOewQL/BLoGkMzXdBpNdZ
	qh5VHpOH/8ti/063w/HOobIk2+BAZF99XUZH6uZamWIBqYOw54q5ve5xJFjKLE/Bd9
X-Google-Smtp-Source: AGHT+IEEGF6Z/xq9GA4nVxn9/SB68FlyLnKuuEKi8kTq1p4Y+273236STcxbKvHva0hFq8KdSNle2w==
X-Received: by 2002:a17:907:2d0e:b0:b76:bcf5:a38a with SMTP id a640c23a62f3a-b8036a924ffmr5076794166b.0.1767487789175;
        Sat, 03 Jan 2026 16:49:49 -0800 (PST)
Received: from control-center.fritz.box (150-12-20-31.ftth.glasoperator.nl. [31.20.12.150])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a5bdfesm5104839066b.10.2026.01.03.16.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 16:49:48 -0800 (PST)
From: Tom Geelen <t.f.g.geelen@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alex Kanavin <alex.kanavin@gmail.com>,
	Tom Geelen <t.f.g.geelen@gmail.com>
Subject: [auh][PATCH 5/5] Record commit failures as group errors in Updater class so that commit errors are not treated as SUCCESS but as a FAILURE
Date: Sun,  4 Jan 2026 01:47:04 +0100
Message-ID: <20260104004708.2494403-9-t.f.g.geelen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260104004708.2494403-2-t.f.g.geelen@gmail.com>
References: <20260104004708.2494403-2-t.f.g.geelen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 04 Jan 2026 00:49:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2893

What is happening before: commit_changes() throws, run() catches it and removes the group from succeeded_pkggroups_ctx, but it never sets g['error']. The Statistics.update() logic classifies groups purely by g['error'] is None → “Succeeded”. So you end up with “Succeeded: 1” even though commit failed.

Signed-off-by: Tom Geelen <t.f.g.geelen@gmail.com>
---
 upgrade-helper.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 165fd42..8457c7b 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -528,6 +528,8 @@ class Updater(object):
             except Exception as e:
                 import traceback
                 E(" Couldn't commit changes to %s:\n%s" % (pkggroup_name, traceback.format_exc()))
+                # Ensure commit failures are recorded as group errors
+                g['error'] = e
                 if g in succeeded_pkggroups_ctx:
                     succeeded_pkggroups_ctx.remove(g)
                     failed_pkggroups_ctx.append(g)
-- 
2.43.0


