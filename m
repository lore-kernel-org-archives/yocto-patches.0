Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DACCCF2CF
	for <webhook@archiver.kernel.org>; Sat, 17 Oct 2026 18:32:23 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1910.1792261941656018489
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 11:32:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=nlRdNoPb;
 spf=pass (domain: gmail.com, ip: 209.85.214.170, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e987a2ba0cso6479935ad.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 11:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792261941; x=1792866741; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QjqVYTUg92u2IknRonGOpz64X7fGf60dBkg7kSJs/8Y=;
        b=nlRdNoPbR8Ciel+CCBEupSbgCPXc8KtrxTTwDhFvLNZnDpRCOwCeW8iS+y1wcauYz5
         RwfunsbA7hoMxU59aJ9JNvjTPzMbvlws33JLmkGZBKscAH2f/oaL5lrzL5HjthH+7KJx
         rknXz2AkY4XvkhKZKfJY1OZ3b1mvwVgFx/XOaB5rgcOMZtm0GfP/6Kmcp9h5laS2R9NQ
         2j0fnln8XgjndpvNShPNanA5eLgUvMVGKT0aPTfqq4MnjKuRiCO4X2t38LznYEGfwB5h
         4tyevfDshyXAj8rvFC/wgMoGQC+LRUSd32LLyKmiyy+XlIM0pzyWh4BMFU9MDNTJ69/J
         zSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792261941; x=1792866741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QjqVYTUg92u2IknRonGOpz64X7fGf60dBkg7kSJs/8Y=;
        b=cAcNyKVoktoCKSomAyEFPq7ayzWcmDx+M9sC+eqaK0DG/l9ed7Grx/6YjbytDrwTU1
         oodORE4ONjoFNQz5yzilgGRTE7wFkqcfR7HFJSc+wwIVJjQAeRc20F3u6O6xr/5lbShh
         J6PyUPETX5FVb9O0jn9XNg5+9hbGmgk1txe+/HPJ4vCfStvh+cEdqExKJSQruvLVkXIV
         PNbInIk5r+2YqNuNZn6OTwR5zcz0Xl8yBA/z7k8FZvPpCIyn783XZy4oB2kEDQFK7dsg
         Fh3wTZS2QHGlelntGYe50wjIY3wlB7Hbqz5QYRJQ8wlQ1BOta1TqkgzZr8dDyP2VIunN
         SbYQ==
X-Gm-Message-State: AFq9FYJbUsAwyCQ4+qupDCb8ILGjTlZzk9JO4fNcDr78Dc97k2+Lowu9
	0a0q4X777Ee3sOnYUhyttiYYRnUNzPCw96LM63SQ/AX0j9M2I5TlOnyLNqb4VA==
X-Gm-Gg: AYBFou1hPxqiVf55s7uzecHdxs569RpJwVaOMcjEA3LcV+QtY0d3QgQiImx4f3TliuF
	6VfgqRkNNcAUs/y+E3td1sjaarpLHPEouTpDxNLrQJvyJhpz9w8Jjs3Nja7JtaCAgQxFWvoIA8m
	1kor9ilNK3GRvBGsWhRS7Idbpq+ZBA8SikRVaq2tIyvVG7aSYc47EraPqmNEM+Ei4C6aOZqGd66
	h2+eLL3ojSUIXpwyPqGlgO8ZBX5FSNYN78Y9X8Ku0u3ltjO6P5vdM8Qv1TcX5395ylWWAj2NObV
	wKKNXP5fcmAglAqQzIaet21MwhQd3RBGfuDJWbCHWnqT08b9lYFGACRYHiD//ZvHTcjsmCNteTC
	EU4W1UzPS3V6rl9Uo/hDsdi5GhDMutym6eX4cYgUzm4nkgZ7CKL4snfaXo0Ni1nVr3Ru/0v0DNf
	b/j4os3rQ50HebeIisvRAamqUhtyrMH0ytfp1ocSjRQ/irx4HfGmaatQhTS1Pt6p3wv8fuk6+XA
	FB9XzHKDajpd2p6+cXaxfosJ0lrV38=
X-Received: by 2002:a17:90b:4a4d:b0:3ac:97bc:4c98 with SMTP id 98e67ed59e1d1-3acef648c40mr2902274a91.64.1792261940958;
        Sat, 17 Oct 2026 11:32:20 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ace34c8d9asm5634097a91.5.2026.10.17.11.32.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 11:32:19 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 3/3] layerindex/bulkchange.py: fix syntax error in LayerItem import
Date: Sat, 17 Oct 2026 11:32:09 -0700
Message-ID: <20261017183209.90930-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017183209.90930-1-tim.orling@konsulko.com>
References: <20261017183209.90930-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:32:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5042

Commit c913725 ("update.py: Allow bitbake to live in a subdirectory of
a repository") wrote "import layerindex.models import LayerItem", which
is a SyntaxError, so bulkchange.py has failed to run since then. It is
run by the bulk change patch download in views.py, so that download
has been broken.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/bulkchange.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/layerindex/bulkchange.py b/layerindex/bulkchange.py
index d2ac1f4..aefce38 100644
--- a/layerindex/bulkchange.py
+++ b/layerindex/bulkchange.py
@@ -101,7 +101,7 @@ def main():
     branch = utils.get_branch('master')
     fetchdir = settings.LAYER_FETCH_DIR
 
-    import layerindex.models import LayerItem
+    from layerindex.models import LayerItem
     bitbakeitem = LayerItem()
     bitbakeitem.vcs_url = settings.BITBAKE_REPO_URL
     bitbakepath = os.path.join(fetchdir, bitbakeitem.get_fetch_dir())
-- 
2.56.0


