Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A055C55175
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:45 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4478.1785497619511077378
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=JB5jZtxe;
 spf=pass (domain: konsulko.com, ip: 209.85.222.171, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9309d4ea213so72317685a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497618; x=1786102418; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mYQ+LCU/AI4fn4mhzupE4TuX37s4rVGqztj986e5fTY=;
        b=JB5jZtxel6ZsMmEUqj32XdMYDNjqD7SRIFwTG5YjVHlqPZsBSBv8tsM91FG5wawddI
         C/UssHbcuXLFX1sb4q6bJF0LI9gwyGNeCI4FSvCNKUFmeAUwHTVxbGzPSqI0gWAXIq4S
         nycS3odN7fLhagleY/WbLpfO9ZTqx3boVezH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497618; x=1786102418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mYQ+LCU/AI4fn4mhzupE4TuX37s4rVGqztj986e5fTY=;
        b=M9cl94ZpCyIvBtRj+v7F04F54dJW7pzrBgiPnTotea0TIIh7Mmff3X7KsK/BoyL9MO
         nwCmy2jMcqkyi7P7cl8VI+X3e6EjEcvd7IBq+N87Mje/WsCODll9QRGevVxMh7hzQcuC
         yf4CeRW0RgRXlGqcjwX8J+cF6a6ND+0z+u9VG3NxMyS7sfUv2JfR/YvCBdXAQeJqkhYg
         OvbbSL8HWUyGSNT9TjqHIPOw7saZrtazeCQRneV4xvQ3FZoQx9fNSUV06RRcAuGgS51B
         d4eIJRWgLsZoz0zXaoDHQdJpI/hVjhAvvpas2SAfaf3QJ+5OAcDl4sfe75E5cZUNJ53u
         W3cQ==
X-Gm-Message-State: AOJu0YzkB5KksiAqFsi9Sl+JPOfjNNA0mRkKlSFEj3Mnjyslfm36Rpe7
	ObyuOqbBzVNz/YwvuQxmobAofEwmjC+O6e1juwhgIn0HlFKkIh46B35vam0c26jq9arOnqzUTuo
	qqA/d
X-Gm-Gg: AR+sD12YlmT6lxrafWantwNbo9ejbBbLyDb/YCiOGfesaU/WjfqcJfQQOmJrM2IkW/8
	73w0hIr2NqEtqSNt5mOzihShoh5CRVf7MUJgbDnncoZLLc9GmifrUGl4mvkDiWSbWNvA3h6UsMK
	Ah+uxA/NrCyv6q8Ywr6jAJmUYAIBT6CO3atM6EijXZjAuWPL9DGdCkmn7+X1CS4rJV0556FaZo6
	rBlb3tN6rMCGZ0Ut+PFzq4teZuL2cirMejOtISp0fhU8YY44Cmb0Ig7J1vm9479f8Sx2Zhtv1bG
	ih+qdXWJ5f2/X2empx8SAQpak3NEObJswhHEN9ZCsCaDXXHRl0P3DppZT37OVw41YdwCdrNcoiJ
	4rVE47ve8h11nzqYeDfLl5hEzMyybW+OjecY6wlgzQTyKHlPsFnCcxV6xB6BcnoSmzvcuoEpgf2
	sPOJfAWhPi7S8jFD0fgSVwC5sg250iNUuZWvAo1JQWSbToaLBZu1apefHZmddGNeLw21KgH5LpB
	qTZ56wza/XbHo+K93vcCzmwgBSpFHe9uRGTm+pXyRJIGOOCfivt3bv8zEwylDO+vvsZRh5KGmlw
	duv4ZrLCmWZQe/pJ1pXpSIdG2oI=
X-Received: by 2002:a05:620a:a181:10b0:92e:9d63:a6f6 with SMTP id af79cd13be357-934965a8575mr179881585a.17.1785497618334;
        Fri, 31 Jul 2026 04:33:38 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.37
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:37 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 26/35] cargo_common.bbclass: add subdir argument to git dependency to let cargo find crate
Date: Fri, 31 Jul 2026 07:32:56 -0400
Message-ID: <7a7dc78d2a9e44ad487246222cd19eaffe42c237.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4602

From: George Refseth <george.refseth@remarkable.no>

When git referenced crate dependency dependens on (root) workspace virtual
manifest, when patching path the path to the folder containing the crate
within the referenced repo need to be added to the patching process.
A subdir argument is added to address this need.

Example usage when repo contains an api crate defining the api for org/repo:
SRC_URI:append = "git://git@github.com/<org>/<repo>.git;name=api;destsuffix=repo-api;subdir=crates/api;type=git-dependency"

Cc: Erik Wierich <erik@riscstar.com>
Signed-off-by: George Refseth <george.refseth@remarkable.no>
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit e955099a2eeff111709de180b127db866b217600)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo_common.bbclass | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/classes-recipe/cargo_common.bbclass b/classes-recipe/cargo_common.bbclass
index db050ca..34fd1e7 100644
--- a/classes-recipe/cargo_common.bbclass
+++ b/classes-recipe/cargo_common.bbclass
@@ -154,6 +154,9 @@ python cargo_common_do_patch_paths() {
                     repo = '%s://%s@%s%s' % (ud.proto, ud.user, ud.host, ud.path)
                 else:
                     repo = '%s://%s%s' % (ud.proto, ud.host, ud.path)
+                subdir = ud.parm.get('subdir')
+                if subdir is not None:
+                    destsuffix = os.path.join(destsuffix, subdir)
                 path = '%s = { path = "%s" }' % (name, os.path.join(workdir, destsuffix))
                 patches.setdefault(repo, []).append(path)
 
-- 
2.55.0


