Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDB7D489BF
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 20:28:43 +0000 (UTC)
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44328.1768854520836941538
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 12:28:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=G8ZvzV2n;
 spf=pass (domain: konsulko.com, ip: 209.85.160.194, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-5029fb0b977so32365771cf.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 12:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768854520; x=1769459320; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VAjkpZxPBwtzpb23L/N+rX/Pb20/jri6H/82UGuq35A=;
        b=G8ZvzV2nCMtdRHnw/z+a76EkdwdjyoiUNdn4Fr8BGCyT5G6Dt9T3jJ6K0SRB6Wq2Ir
         A+zcXzqpCr6DoKTFIQgBTckhVju8u4h7zZ5yWfZYB2wH5sHsKjnCIcBEZ53A3l8/6GrI
         xYn7TM5gu/9500o7PoF/gmqx6FYhSuIqPIaX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854520; x=1769459320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAjkpZxPBwtzpb23L/N+rX/Pb20/jri6H/82UGuq35A=;
        b=uhnZKyre3XPnIdDFh/sqeyV5XCGeeRRthVtFQLU/sbVjyxXYmH3sOZwOgAe2+VTn6w
         mIhc5quK8iB8Pjk19A5ZFmWvg/hwqn02H5buX1wDWSgqAPc2St5i6p9mi2gZ2EFrJLfA
         Iuax1sTh+rlG8YVGZBXNRu0eYMEEW0JnaWZLV0qUifgSmxeUrMZVkeLccdgnmIb5VXzT
         7QLlP70uqSixBCtni0tldBGkJg+1tpozqmHrC9uR6dKx2zBLn9raip96XSiKi6Ef8w3J
         L05faXguIF31nkZdtQBtRVDUgECVQFrgzmrBiVbwBVWMJhgyCRPtrlD4ECK3SDOGq8tp
         LvGg==
X-Gm-Message-State: AOJu0YxDfhWGfb8uyZ88XjmJv33Qin2Yk6aVBePo/z/LevbWW/xHVlnF
	iAIDrVBv3JYqKxjwpRwKmIz/Ny4wENWkuCwCE/jUXIUJ/gaLs7tZ4uWDWng8T8Aia2BLVruQn56
	+yi1PkNw=
X-Gm-Gg: AY/fxX4DncGOyJnz28RhwMUR3m4IS7FKj1YumDFXTonQ9FQugNt41UAfNo7ohlYLU4K
	TOKbJ8FmSjOuOMf6ook6K6xGzdGShMPiS8VzjMov7PHX7DcM4hpPlHtxp9MKIGOin9Co9+vC6Mc
	ASMe6wujKR/S7thHnoo3h30d0Cu6JLeA/vsbJrGN/AcGSjQWwnCWwrrrJhHFzbaJLh3ynxG1S++
	rU/x6RMrBiiH0OXi4xY2F4flRFRybzpgg1Jd0xwIrkDyZP/zZbU9xOLtfh4bMjtWkr5UP+rypv6
	/P6pxj310/6NLvsyunpvxQW7dqbqZyUMGq09V/P9UJ4YF1WrejZiw/L9YhDzWZKDFxOGhYfAS8B
	IiaUMBVCllSV6t0NuiPO4gvDWPD7lq7f4Qeg/qsVOIyJvJgzIJaw1bPa21lDk09qqiNVz9r5NgL
	j2A2HGjr85cd7blC2x802NbwPiTChfmPtw189VWhDDug3AuhPK4PfDfZ16z9z4gxJiC81g0qPds
	y2EBSoy1x+t4Tc2clVJCJfAeRCMwIerJh3cU/Wlmdtmdo7/nu7p
X-Received: by 2002:ac8:5e49:0:b0:4ee:5fc:43d9 with SMTP id d75a77b69052e-502a1648cf2mr203743651cf.16.1768854519329;
        Mon, 19 Jan 2026 12:28:39 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1f21c9asm82661411cf.34.2026.01.19.12.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:28:38 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-lts-security][PATCH 0/3] Assorted updates 01/19
Date: Mon, 19 Jan 2026 15:28:20 -0500
Message-ID: <cover.1768854292.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 20:28:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3014

This patch series rolls up the contributed patches from the past couple
weeks, plus a lynis update from myself.  These changes are queued on the
master-next branch if you would like to check them out to test yourself.
I intend to merge these to master branch at end of day tomorrow (Eastern
Time, Jan. 20) unless there are objections.

Scott


Changes:

Clayton Casciato (1):
  suricata: add PACKAGECONFIG[seccomp] - MemoryDenyWriteExecute

Scott Murray (1):
  lynis: upgrade to 3.1.6

Stephan Wurm (1):
  dm-verity-img.bbclass: filter units from value part

 classes/dm-verity-img.bbclass                     |  4 ++--
 .../lynis/{lynis_3.1.5.bb => lynis_3.1.6.bb}      |  2 +-
 recipes-ids/suricata/files/suricata.service       |  1 +
 recipes-ids/suricata/suricata_7.0.13.bb           | 15 ++++++++++++++-
 4 files changed, 18 insertions(+), 4 deletions(-)
 rename recipes-compliance/lynis/{lynis_3.1.5.bb => lynis_3.1.6.bb} (96%)

-- 
2.51.0


