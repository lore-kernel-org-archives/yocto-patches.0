Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC21D47CB8
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 10:01:05 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2744.1768557657242540745
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 16 Jan 2026 02:00:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IM+5eEdc;
 spf=pass (domain: gmail.com, ip: 209.85.218.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b86f69bbe60so271456266b.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 16 Jan 2026 02:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768557655; x=1769162455; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2zhR9xS4sT4/2pnKslUZmt2NJG9g6Wa9P8F5RkZ8NqM=;
        b=IM+5eEdcRTHtg8GyFKIzbZGI8FtJ91MW7I12nrRJfdrXm/1qLyjoEt9MyVnOvYpKA5
         GWlwjzDhkp4M4+kxWkDRm7+4cRydxAXZjiCwUEypcEiDvpYhXAaF/5DEqf6AW9ercH17
         JGrKuIWUOmW4XswIBzdqDBnZolzcz4+w3rPxYaORV+gqpd8upq3jAvIxSKidk789lbg5
         0GrItDcQawPb+pMzD/1sqk0phrYr0Lg+lOIHZABHoxqKZX6IS/8LmjxQboy/+Dzu/6se
         VYo+7Rpp1ZSNW567p3nmaCXnzlXNRi/rqUW8vvNgwObrYz2JvL8znjvqT2+yxTKNjtWM
         zDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768557655; x=1769162455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zhR9xS4sT4/2pnKslUZmt2NJG9g6Wa9P8F5RkZ8NqM=;
        b=wjxwEp6ByTd+XO/dxaBI3/0eRXqEYsHmKNQopDS5rZcDgdIkjTjfnTgFNYu+z6Zrut
         AAiaCmipR0iHSbVkyOxq8XeDpRUwZu0i7ZizMn98hAnhQBFTPWlj71fqIWuYRaYLdK/G
         N3v/lCgCOl/xbYlv47T6U/RTYYPlGRrNkcYq1S7adZ67pTAtC08a65Ir1QfXGC44e3l8
         k2TH9lfKca3wg+6r5juTFlj1bGJr4KWkpmZCvjcLt0ugQClM65porZyabQzGgmd8Ob+z
         mFCgZSqgx3t6WcnXF99yCVYTbclkw1+AA2C3ctwmC0heFHlw25m8ponL3YTUDpiqDPCL
         AjQw==
X-Gm-Message-State: AOJu0Yx1T/+wAaTpxP8LIGtnL1Ius0Q9g0KQURT3OofkdJzk0X8i6H3V
	gbSD4i5KaEtckUrFQCVqgOvLKwOkJvLZXHS/vYuLzy7BPFh9hFtnncn0fvPVjq3f
X-Gm-Gg: AY/fxX6+o6XpLZefnIy5k5WiO849u8obNATZh/g1RPAOzWj1Wk6akrI/wI6WXD0Zy3x
	Ra5CnEmHgGj54dHN31Xh/GOkYsXLxbEXPljakP5htHu+h+oBkYMx66TLwW2BLGjpBy8cpa7g6gA
	qkonLI9hh22ujBpMetU3hvBdsmMsVQC8u7Ybns0UhlUs75qr5FLAbEgneOaUPKx6axnkJFU84bn
	7ibGlN3vqYmIGa/ptf3FnDhTMbyNLY+KxS28aui9nimVYIrc38E+aSz2BSg3c3xfj09Ll+p/Pir
	x5ENU1+UZAWGYIbO3mrtrvNCXlQaVP5Cagq4ivoHYvVr/BzIK5njwBrJ0S5bjZdl+x41eM+cPxW
	RkWtk8xo3oH+5q599IwD7b8SFK2UbDiMUUoe+NVzZV0OXu83CVFk5g207y3xWJ91XgQyhZOf0bi
	fgOy/Siz/rtaktFXAX5Xp34BmSrUMcWtfVlYZ1RejEsNs=
X-Received: by 2002:a17:906:9f91:b0:b86:f495:5e4c with SMTP id a640c23a62f3a-b8796b94836mr150106266b.55.1768557651039;
        Fri, 16 Jan 2026 02:00:51 -0800 (PST)
Received: from alex-lx-laptop.lab.linutronix.de ([2a02:3036:26b:2ae1:326c:bbe5:35b0:aead])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879d1a04e5sm115569466b.46.2026.01.16.02.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 02:00:50 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [yocto-autobuilder-helper][PATCH] scripts/shared-repo-unpack: disable the common-sstate feature of bitbake-setup
Date: Fri, 16 Jan 2026 11:00:38 +0100
Message-ID: <20260116100038.3644755-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 16 Jan 2026 10:01:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3000

From: Alexander Kanavin <alex@linutronix.de>

Autobuilder runs its own custom sstate setup with a dedicated hash equiv
server, and bitbake-setup should not be getting in the way of that.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 scripts/shared-repo-unpack | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/shared-repo-unpack b/scripts/shared-repo-unpack
index a12fcaa..797dec6 100755
--- a/scripts/shared-repo-unpack
+++ b/scripts/shared-repo-unpack
@@ -96,6 +96,7 @@ try:
            "--setting", "default", "top-dir-prefix",  os.path.dirname(os.path.dirname(args.abworkdir)),
            "--setting", "default", "top-dir-name", os.path.basename(os.path.dirname(args.abworkdir)),
            "--setting", "default", "dl-dir", bbs_dldir,
+           "--setting", "default", "common-sstate", "no",
            "--global-settings", args.abworkdir + "/settings.conf",
            "init",
            "--skip-selection", "machine",
-- 
2.47.2


