Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CDFCD37AF
	for <webhook@archiver.kernel.org>; Sun, 10 May 2026 00:47:41 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22356.1778374053294611309
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 09 May 2026 17:47:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=XWWfiwuA;
 spf=pass (domain: gmail.com, ip: 209.85.216.46, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3660daea6a5so1590542a91.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 09 May 2026 17:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778374051; x=1778978851; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OlDScb9F8nFAbC6DFC0VEwl/qfbCVhiqUFTueUzwV0=;
        b=XWWfiwuAQRvdMAtuvhSg7pjyFNvmEbjOwFvosJWd+JNS2aMsDMYGtf0lDaFgyCaxxI
         WAIMiAlo7522vkEIeFD18y34x6rcNG8uVeEmEEJEf2Pr8Ztyq6D5gP0Ej3gh79zZpD7Q
         7WCB3oP6dop58trZ7lfFQDGyIuSwmCG840QZnti77Ox3bMolopPLUk2Onwb5M30pzF1j
         JmB1M8L8qvHLDP/tT4PNVOCAnZ2LxOggMhm+D7LjF1ignPEwqh93RO8wAQW1ZLECqIOv
         CS16c+xuhDAG8viEj827Z8zJhnrQRDdaGfqSV9E8o+iI7BNz8DOnlVF2eHrKpNshjloU
         d6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778374051; x=1778978851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8OlDScb9F8nFAbC6DFC0VEwl/qfbCVhiqUFTueUzwV0=;
        b=r6FzJm9NI6i3bqHBbctXkg1X/ZwpACd5h1xlbXWeitwx4/DWc8fqaN5htmqdUUCZAM
         +vsJnKG114mtiuq5LPRecu6Vd8u211iTCFjeROG9Jk3/nQ++phctxqvEs/D/ijhgzJkH
         pqHbdw5PZYwPZasFAagXhv09USmmZqFkSAf49KE9H7M1ABh1r23cjbt4rBlwqioyxyKI
         MA8M0XAxKI1Ruk0+MUzpE3X8IjwDhS0aCLWLH+WA5rhOir3F4v2ziS3PdZQ9nxHnP+3+
         zgqAPjLCGXcUGi2DmzeDye8kuTWeXGn364sUjadfdghx0Mo7k21Mym7E/JRrpv3Anyno
         omBQ==
X-Gm-Message-State: AOJu0Yz/ptuqmbcQ1MUkCkPq4/VsbNFPpxm6y+xZf1UTRr+owTZ+l9YQ
	As2yIGnm9+WNoIP4S1uOh79Y4E1gQL6v6Z3+1RsxXwCQU6G8UOaLFRWDIvmuP165
X-Gm-Gg: Acq92OGIWPb+Wn84XJPGvyKdeZlVLi2DmYUw7i8oPiTxGHI3oc+WPXR4RsFD5cBO2C6
	pZUNdMinTUI2T5XQyNAyooCKUGeerkOGqi1qOOKvHdQmG1SfzUViXU3oCwIKX7unV2bZd5wc0ue
	8YEOPGrpeZoT03x0nqD+wXlqHIR7AKugIs/4SK86uS/mbM6VrpgsengVSid5AusJ5Q8nro9xJog
	83xIn55AmfJVZtJgNs9ee9eB6/scJCQmg/8KzB3lNb1h9E+fLB6fvdou7BcYKr4lHB6h0Jq8y5K
	wEx2Gt6XS7HRf64gIHPkKNz354jNLIAqF8MX2aE2I9rho1Bzl0LhvbMnBsjri4U+9jPsLUluu9E
	HMQPYU0EsUJZ8abKW+VMFax30LNZBIssZydHJ/6TjnrecUzhL7XK3ogv7Th0cAFg1L9YbMSlF6n
	gmu06nE2L19NUzkjBqVLBfVY0Buo9TQVTX9MscrzLSfgVX0IXek64c9qNiVz4SrR+krzEOFnhtj
	N5bhH3HtDyihiTrz9l9WMd5otq5WRAItg==
X-Received: by 2002:a17:90a:d003:b0:366:173c:9a94 with SMTP id 98e67ed59e1d1-366173c9ea1mr12599455a91.14.1778374051409;
        Sat, 09 May 2026 17:47:31 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d627bc2bsm3178257a91.7.2026.05.09.17.47.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 09 May 2026 17:47:30 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 3/5] layerindex/views.py: fix DuplicatesView timeout
Date: Sat,  9 May 2026 17:47:01 -0700
Message-ID: <20260510004706.81282-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510004706.81282-1-tim.orling@konsulko.com>
References: <20260510004706.81282-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 10 May 2026 00:47:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3960

Two performance problems caused the duplicates page to take over 115
seconds to respond at production data volumes, eventually causing clients
to disconnect (SIGPIPE / broken pipe):

1. Python list comprehension IN clause: each get_recipes/get_classes/
   get_incfiles method evaluated its 'dupes' queryset in Python with a
   list comprehension to build a filter:

     filter(pn__in=[item['pn'] for item in dupes])

   This loaded all matching values into memory and emitted a potentially
   huge SQL IN (...) literal. Replace with a Django ORM subquery by
   passing the queryset directly:

     filter(pn__in=dupes)   # dupes is a .values('pn') queryset

   Django translates this into a SQL subquery (WHERE pn IN (SELECT pn
   FROM ... GROUP BY pn HAVING COUNT(...) > 1)), which the database can
   optimise without a round-trip through Python.

2. N+1 queries: the template renders recipe.layerbranch.layer.name,
   class.layerbranch.layer.name and incfile.layerbranch.layer.name for
   every row. Without select_related these trigger one extra query per
   row. Add select_related('layerbranch__layer') to each queryset so the
   JOIN is done once up front.

[YOCTO #16175]

AI-Generated: Claude Cowork Sonnet 4.6
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/views.py | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/layerindex/views.py b/layerindex/views.py
index 23bafd0..742e5d5 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -656,24 +656,30 @@ class DuplicatesView(TemplateView):
         init_qs = Recipe.objects.filter(layerbranch__branch__name=self.kwargs['branch'])
         if layer_ids:
             init_qs = init_qs.filter(layerbranch__layer__in=layer_ids)
-        dupes = init_qs.values('pn').annotate(Count('layerbranch', distinct=True)).filter(layerbranch__count__gt=1)
-        qs = init_qs.all().filter(pn__in=[item['pn'] for item in dupes]).order_by('pn', 'layerbranch__layer', '-pv')
+        # Use a subquery instead of a Python list comprehension so that Django
+        # emits a single SQL subquery rather than loading all duplicate pn values
+        # into memory and building a potentially huge IN (...) clause.
+        # See: https://bugzilla.yoctoproject.org/show_bug.cgi?id=16175
+        dupes = init_qs.values('pn').annotate(Count('layerbranch', distinct=True)).filter(layerbranch__count__gt=1).values('pn')
+        qs = init_qs.filter(pn__in=dupes).select_related('layerbranch__layer').order_by('pn', 'layerbranch__layer', '-pv')
         return recipes_preferred_count(qs)
 
     def get_classes(self, layer_ids):
         init_qs = BBClass.objects.filter(layerbranch__branch__name=self.kwargs['branch'])
         if layer_ids:
             init_qs = init_qs.filter(layerbranch__layer__in=layer_ids)
-        dupes = init_qs.values('name').annotate(Count('layerbranch', distinct=True)).filter(layerbranch__count__gt=1)
-        qs = init_qs.all().filter(name__in=[item['name'] for item in dupes]).order_by('name', 'layerbranch__layer')
+        # Use a subquery instead of a Python list comprehension (see bug #16175)
+        dupes = init_qs.values('name').annotate(Count('layerbranch', distinct=True)).filter(layerbranch__count__gt=1).values('name')
+        qs = init_qs.filter(name__in=dupes).select_related('layerbranch__layer').order_by('name', 'layerbranch__layer')
         return qs
 
     def get_incfiles(self, layer_ids):
         init_qs = IncFile.objects.filter(layerbranch__branch__name=self.kwargs['branch'])
         if layer_ids:
             init_qs = init_qs.filter(layerbranch__layer__in=layer_ids)
-        dupes = init_qs.values('path').annotate(Count('layerbranch', distinct=True)).filter(layerbranch__count__gt=1)
-        qs = init_qs.all().filter(path__in=[item['path'] for item in dupes]).order_by('path', 'layerbranch__layer')
+        # Use a subquery instead of a Python list comprehension (see bug #16175)
+        dupes = init_qs.values('path').annotate(Count('layerbranch', distinct=True)).filter(layerbranch__count__gt=1).values('path')
+        qs = init_qs.filter(path__in=dupes).select_related('layerbranch__layer').order_by('path', 'layerbranch__layer')
         return qs
 
     def get_context_data(self, **kwargs):
-- 
2.54.0


