Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBBDCAC58C
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 18:50:30 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.web10.3381.1757443827267286990
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 11:50:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=l+QB5TFn;
 spf=pass (domain: konsulko.com, ip: 209.85.160.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b5ed9d7e96so42222821cf.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 11:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757443826; x=1758048626; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1A6ut0VPBnubGlj24KHLyVFjfdg/icQs+OS42PS10UU=;
        b=l+QB5TFnJRfgLxO/BukS+pLO9/uZL22BnNOHh2CfAhBWcHY9tMlXQNBk1poNX/jK87
         afoBSis0eJzocAejXVp7BYTrbRJjSz3GJlLrYOaVwbvuFoiFpVTyYQ0mc/CSTG5qKKKW
         n1sIQE13rDF3XiQj1BmeDgBS9ZqcD68wbHAoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443826; x=1758048626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1A6ut0VPBnubGlj24KHLyVFjfdg/icQs+OS42PS10UU=;
        b=C3CKCoZJvUw3tghoi0gv8r6ucu/Y8Yjy0KalBywLe4YKMoSzpPJ+phn1N1gv6XFeJL
         aDVFbBkx2jRl/LeoOSFwP/j5SkfCyZG8KoDIQ6kCkUQHXY56u/rM2fn9TzZ9wDo+BIXM
         H9MYmmqxodgVPDDXZbcNtTL8XVvOK5GXCx5AInywpKbHMNWSyS2DN+yDzfWfQjrQYpmJ
         SRmuA1hwItluUhCNIvEx8VNwfLp7nNYKMWhVbem3Lmr24n+CI66TtxpiKAXVHUGXB6C6
         nc3CADTNy0Zs8IrhXjqa3Z07ILlM1rm/nh8ANRgmbLDNSu/wUuSi4x8bLx5DceU+OMcl
         L1Fg==
X-Gm-Message-State: AOJu0YzJSuxrE+OBPPEiGLSLjb9U/9FDz01pe+ikXnCJMui2UxWYag+v
	mWWrcqP+8dbsOY3pZaJ36SvdQyzQdXEdl/zSlHAV/dS4a60wTjwhwmrW7a2FE+dAcXPmcZOUpn3
	m9BDk
X-Gm-Gg: ASbGncuqrwl+xQMcXt/QJ8pObb/3rgdcbygxnJO3o1iz/yLTNoWSjYAXExq3XxiUUen
	jChgcu8GtJNZEFDOMjgf8Uak0oyghNpS5k8GL6lzVEhIlGckOlmw8ljKKVzp/qxn9bpACv4szyC
	sU6vLn5ZdS9shp60hU+qPgMPCq39iEpIwkZ3It5ihQZven6FDajYL9lF6numC8Bo1APHuuNhtzm
	swtBGbK5lur6AXv2iwlSW2rmIf8sYOJko2h6q2qOX732CUIN+DaZjtgTULN+xzlJuwqRzrrsi16
	Ln0kw0j4cxxJD9Xn1G1q/Z+GVmywiZQklTNuRuoO6mBl3KXqugCQTp3OnCpHLc0HHkXc7EAjHR/
	eSRsFObZwdtevh/PxAMrmU8E4lKWrpXVGpc2Dk8lp//P3KRXvJCFT+vPeQ9zHZ+sko5/5mPZYop
	y7bOwGND6pj4KY+6nmuFI=
X-Google-Smtp-Source: AGHT+IGJR74/3s0xtNFUGHt3KJ2Pz/to6GGnTMlMuAG547gPlWTKBMgYWL4oHA4ZlDUhceH75NMzFQ==
X-Received: by 2002:a05:622a:154:b0:4b5:d78b:fa24 with SMTP id d75a77b69052e-4b5e7e06a17mr204987911cf.28.1757443825766;
        Tue, 09 Sep 2025 11:50:25 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5ec7d3c8sm161168685a.46.2025.09.09.11.50.24
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:50:25 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 7/9] rust-target-config: fix nativesdk-libstd-rs build with baremetal
Date: Tue,  9 Sep 2025 14:49:55 -0400
Message-ID: <d26ac3a6100821c859839a864217f058e1687c3b.1757443674.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757443674.git.scott.murray@konsulko.com>
References: <cover.1757443674.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 18:50:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2174

From: Ovidiu Panait <ovidiu.panait@windriver.com>

If TCLIBC='baremetal' is set in local.conf, nativesdk-libstd-rs build fails
with:

| error[E0412]: cannot find type `c_char` in the crate root
|   --> /usr/src/debug/libstd-rs/1.75.0/rustc-1.75.0-src/vendor/libc/src/unix/mod.rs:56:29
|    |
| 6  | pub type c_schar = i8;
|    | ---------------------- similarly named type alias `c_schar` defined here
| ...
| 56 |         pub gr_name: *mut ::c_char,
|    |                             ^^^^^^

This happens because rust_gen_target() sets os="none" when TCLIBC is
'baremetal' - even for nativesdk targets. However, nativesdk packages are
built against glibc, so the correct 'os' value should be "linux".

Fix this by setting the os field based on {TARGET,HOST,BUILD}_OS variables,
as it is already done in rust_base_triple(), instead of relying on TCLIBC.

Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 3eaf2cd5647585a1e6df03fc20e2753da27bb692)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-target-config.bbclass | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
index 76dbf47..bbadd6c 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
@@ -332,6 +332,7 @@ def rust_gen_target(d, thing, wd, arch):
     sys = d.getVar('{}_SYS'.format(thing))
     prefix = d.getVar('{}_PREFIX'.format(thing))
     rustsys = d.getVar('RUST_{}_SYS'.format(thing))
+    os = d.getVar('{}_OS'.format(thing))
 
     abi = None
     cpu = "generic"
@@ -371,7 +372,7 @@ def rust_gen_target(d, thing, wd, arch):
     tspec['target-c-int-width'] = d.getVarFlag('TARGET_C_INT_WIDTH', arch_abi)
     tspec['target-endian'] = d.getVarFlag('TARGET_ENDIAN', arch_abi)
     tspec['arch'] = arch_to_rust_target_arch(rust_arch)
-    if "baremetal" in d.getVar('TCLIBC'):
+    if "elf" in os:
         tspec['os'] = "none"
     else:
         tspec['os'] = "linux"
-- 
2.50.1


