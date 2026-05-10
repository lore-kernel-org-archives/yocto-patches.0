Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2427CD3447
	for <webhook@archiver.kernel.org>; Sun, 10 May 2026 00:47:31 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22527.1778374042962490160
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 09 May 2026 17:47:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=n/sE4Uw/;
 spf=pass (domain: gmail.com, ip: 209.85.216.51, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-366330b6751so1869766a91.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 09 May 2026 17:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778374042; x=1778978842; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F+MbkurJq2hCgqsBefyNRhs8rLsr1eUv9isVsciz45Q=;
        b=n/sE4Uw/e6FwU4G4BdMvMK/qKZ1jydfavNARnESXHuFwqXzGBUDpCtCTIpnvtr79FZ
         Af84ZTOWJq05Gbb3GGRVbfDhcQKgY26vnIDPLX5D3U/dB/Gwr0aQT4TQE0aEqK4v8jV8
         Rp30ZYLKY80OyOFo8fMW5wOqQshAnM4Yrkk/MO8z5OfMhlEmuwosHnR0TG6W63n1Z8un
         UtQU4e8t3jNB7wenFog4q54swRDZnrdJHoNYwvgTdrLsSCOzw9G3C+twK9r7SpYEKVAI
         VYwMY9RiQMV/RD0ApzSiTlI2OF5lmQ0bu+OSYYnbxV26p9S35t4g8/xu3IR9w3F/Ijo9
         W0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778374042; x=1778978842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+MbkurJq2hCgqsBefyNRhs8rLsr1eUv9isVsciz45Q=;
        b=JiDra9zfCoVLn8T2vcxgfQUoHLl5OqQgvHeg3hlIQV+7xZz1ijdNBjDnGTc50Dia5y
         ipbU2tWGku53StkUG3LNKyhs5ClnremaZkf6NOL+B5UyRhjFIHMLEJzgOD7aE/Ym0Hz1
         724tLqIG4tZ6TCEZC1YPhvxJmht/kJu0R4lvHrRG8kqz33l10hc/wDD5GAzR4tD1pKB9
         raf6aquSJ2tMSdXuIDgIEbo1tUnIunkgmAi+6S7CEAV3v1bvbxHgcLAErFIcQmhWEOgg
         rWNcGKIB5TPl55ol777dycpMg2HtbGf/rZnVojuLBLeV1ZXAlWo47gdGDhFTfoOBjDU3
         zlMA==
X-Gm-Message-State: AOJu0YwTRcRs/BJVLebbtUpg/Y4m2XlknFqxzTkFIkWZcdWOnpDKDZR0
	YuDtSeL6pto9U9ihpXl8W0RMzk/fHLsmPz5n/yrfkV97dxW6bzQvQv//LF+9qkbJ
X-Gm-Gg: Acq92OEUU2ATqMChFkGUq0QgwtUoXkDjxE95GbEnoLZJfOmf3OdpaYj/62LKuqRn+ls
	oMoInyI4CBivS97u87rjtNSGzO+bNvx3Bchfa3d5uyVdZapPbnW7AMhjq/ejRRx9Rfg/Wr/OUZR
	Q6Du8yH8QCfVV01LDUJH1W1uHle26VWZ4ojy6SeUdq7uxU9oTo1GzfB1SMoabkkIWaUtgT4Xh3f
	e8SDH+NkzPLAZKf5Y15oNk9h1/PoRdIaZTaCESfFi61YNF8x3rO5WtwZBSprYUXnKpw3fmoc20T
	GEgn9LJnbxCzY2672DXpQ7qpUoxdMZmHRz5LSH1lDqlEx37IQQh4XmXvof9XIwL55QEruFQ+QQA
	dVAsIYYO2d+Un5ugOT8ZTzFQG0uLkWtg6sub81O4hMpXjV6kzEv43W/9lqIQhXjX6IPGV1CsO5v
	flNYiSNYLq8FV53gFg0mxzEVI5KusZfH9HgprzpmuTkxj/1AFxoaepPdEQRGBMVg7ly0zdPjDlz
	inpz8zNrOyHL18Zgc6tz2Q=
X-Received: by 2002:a17:90b:578d:b0:35f:b5df:450 with SMTP id 98e67ed59e1d1-365ac2807f0mr18645025a91.19.1778374041604;
        Sat, 09 May 2026 17:47:21 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d627bc2bsm3178257a91.7.2026.05.09.17.47.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 09 May 2026 17:47:20 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/5] layerindex/views.py: fix StatsView statistics page timeout
Date: Sat,  9 May 2026 17:46:59 -0700
Message-ID: <20260510004706.81282-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 10 May 2026 00:47:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3958

The per-branch statistics query used a single ORM queryset with five
Count(..., distinct=True) annotations spanning deep reverse FK chains
(layerbranch__recipe, layerbranch__bbclass, etc.).  Django translates
this into one SQL query with multiple LEFT OUTER JOINs across all those
tables simultaneously.  At production data volumes (~541 layers, ~25k
recipes) the resulting query exhausts gunicorn worker memory/time,
causing a 504 Gateway Time-out.

Fix by iterating over each visible branch individually and issuing simple
COUNT queries per table.  This replaces one huge cross-join with N×5
small indexed WHERE-clause queries that are far cheaper and independently
cacheable.

The template is unchanged; Django's template engine resolves dict keys
and object attributes identically with dot notation.

[YOCTO #15391]

AI-Generated: Claude Cowork Sonnet 4.6
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/views.py | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/layerindex/views.py b/layerindex/views.py
index 3cf91d2..23bafd0 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -1522,12 +1522,23 @@ class StatsView(TemplateView):
         context['class_count_distinct'] = BBClass.objects.values('name').distinct().count()
         context['machine_count_distinct'] = Machine.objects.values('name').distinct().count()
         context['distro_count_distinct'] = Distro.objects.values('name').distinct().count()
-        context['perbranch'] = Branch.objects.filter(hidden=False).order_by('sort_priority').annotate(
-                layer_count=Count('layerbranch', distinct=True),
-                recipe_count=Count('layerbranch__recipe', distinct=True),
-                class_count=Count('layerbranch__bbclass', distinct=True),
-                machine_count=Count('layerbranch__machine', distinct=True),
-                distro_count=Count('layerbranch__distro', distinct=True))
+        # Compute per-branch counts with individual queries rather than a single
+        # annotated queryset. The multi-Count(distinct=True) approach generates one
+        # large SQL query with many LEFT JOINs that causes a gunicorn worker timeout
+        # at production data volumes. Simple per-branch COUNT queries are far cheaper.
+        # See: https://bugzilla.yoctoproject.org/show_bug.cgi?id=15391
+        perbranch = []
+        for branch in Branch.objects.filter(hidden=False).order_by('sort_priority'):
+            perbranch.append({
+                'name': branch.name,
+                'updates_enabled': branch.updates_enabled,
+                'layer_count': LayerBranch.objects.filter(branch=branch).count(),
+                'recipe_count': Recipe.objects.filter(layerbranch__branch=branch).count(),
+                'class_count': BBClass.objects.filter(layerbranch__branch=branch).count(),
+                'machine_count': Machine.objects.filter(layerbranch__branch=branch).count(),
+                'distro_count': Distro.objects.filter(layerbranch__branch=branch).count(),
+            })
+        context['perbranch'] = perbranch
         return context
 
 
-- 
2.54.0


