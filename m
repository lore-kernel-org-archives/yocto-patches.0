Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BAEC982D0
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 21:59:01 +0000 (UTC)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26482.1789595938118982166
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 14:58:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=p/2U26FK;
 spf=pass (domain: konsulko.com, ip: 74.125.230.205, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cadea0so8443285a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 14:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789595937; x=1790200737; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HpEPj7e5vL+BpL10VabTpzriP73jtIOyfxmq8EoyxOY=;
        b=p/2U26FKlUthRNfwbgW06urKmQDzN6Bu7qWjjYPZ15xbHMR2lonVUor0xRxogytSk5
         BiGOiLtM/0W+wA9YinpLWtcPq6uzCHF7xKs9I2oMpV2sDhXW8gPJ5Gi7Qz0rH1W01szi
         1nyO0VhxzpNgLJ4ZPqyqPNCkzeB9NVBUxtecs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595937; x=1790200737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HpEPj7e5vL+BpL10VabTpzriP73jtIOyfxmq8EoyxOY=;
        b=YH3w5Ee9IIsQWoZ9iM9uJbsvs8X15OSh4Po+CrNKKds12hZ97kTPYiS1LZUYlpaoGO
         mfO75bYx6idCG0CjHV2hUi3r4S8iEYeJdIep8/7or9SsmyWiayuHjsu/ca2Lqie+5ax9
         S+43/5aR4EZlHfmsmYpctoJkFKoL0TZLbUduPJK8p1F2F0xFQu2LIqQ/OKrn7y5xez1+
         vAnEj3LbO/AlOikIxaM98DGFO/ETmpzTTG90XhAC8LZXNOUuwP/nfIz919Ch/FiRJ3f2
         E5SEVPXBHbRgtL2s2y/iYQM0R4KigmaeI5C7AAYid5tQu/Txi1gQa5EwiBwBgIwFkNaw
         I1xw==
X-Gm-Message-State: AFuF++nq09xSrQe8QGFNAx4XKRd4S+m+JMhYTOyqmSYaMdfeJ7+YmO3g
	9GCKMc5qjachIs6DO/d47xH3YGYtFZlm+oLyLuWPUEGlzokTv7Or6BfSGP99smg5PgCSafbXFep
	JcG6P
X-Gm-Gg: AYBFou0rfB1tynFc+sGlZj6/9gSM7Yawmg53hW0xSh5KR3r6D6XGgWlTCCzJK0KtCTF
	whVEQkD+LKgHL4xqfzj1VvWaLL/JjZ97zrHba1rTMei8V1ZXMJwCZVaKkAWBewk0teheqP8vr/D
	H/qgldrcO+Ifxe2Jn9b344rGoYlHOf08jfAN+8oqCZ9ZPjXChjmAogWzFTiZN+MR+4km6bGi5gU
	pWmIgOfY/R+/PZ37CxjZojuwOuQ4y3mmRA1xj5qGkJXoUVA3hmfNI5iylZ7s7bIQHf0KAJI88eF
	vtkHEuiGhDlfgE6cLdW4/fuX/gge7AgLYfncPCkz92eDIiBo+KFnbODc9Ww2cDDNg/MIqs8z8x4
	cnRzWs74n237+E+wNSS/I7oAgRd5UOvKf5/yM6vtdY/qqmsuDQDrBFsSclC6PsioPMt2scNkc6+
	Peytgcwd0V/G4T3lXoObTmGWXPvNFtti4xLoQadny5Hl2b8pl9U9HQS2O8LYoN0DoeUBw52V103
	t53eu2wRRVTn21voJvj5STwMLDi75U3I+wmz1Y7f5UgrWiI1kCfQAuhX50AYz6qbBKW4BV4d7ZF
	iD/zdCCI7ZJDqlcQbZ4LSInPU+RaMzmVTaLvqegLKWQliA==
X-Received: by 2002:a05:620a:2a05:b0:937:6900:a7ae with SMTP id af79cd13be357-93bb77ac6famr755205485a.15.1789595934356;
        Wed, 16 Sep 2026 14:58:54 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781def43sm323293085a.16.2026.09.16.14.58.53
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:58:53 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 18/19] suricata: upgrade 8.0.4 -> 8.0.6
Date: Wed, 16 Sep 2026 17:58:18 -0400
Message-ID: <4cc0aac960ad2872d55a84ac2ab7f60069a90bd3.1789595456.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789595456.git.scott.murray@konsulko.com>
References: <cover.1789595456.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 21:59:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4875

Release notes:
https://forum.suricata.io/t/suricata-8-0-5-and-7-0-16-released/6315
https://forum.suricata.io/t/suricata-8-0-6-and-7-0-17-released/6391

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/suricata/suricata-crates.inc      | 2995 +++++++++--------
 .../{suricata_8.0.4.bb => suricata_8.0.6.bb}  |    2 +-
 2 files changed, 1499 insertions(+), 1498 deletions(-)
 rename recipes-ids/suricata/{suricata_8.0.4.bb => suricata_8.0.6.bb} (98%)

diff --git a/recipes-ids/suricata/suricata-crates.inc b/recipes-ids/suricata/suricata-crates.inc
index 32da935..357747d 100644
--- a/recipes-ids/suricata/suricata-crates.inc
+++ b/recipes-ids/suricata/suricata-crates.inc
@@ -130,7 +130,7 @@ SRC_URI += " \
     crate://crates.io/ppv-lite86/0.2.21 \
     crate://crates.io/proc-macro-crate/1.1.0 \
     crate://crates.io/proc-macro2/1.0.95 \
-    crate://crates.io/psl/2.1.197 \
+    crate://crates.io/psl/2.1.215 \
     crate://crates.io/psl-types/2.0.11 \
     crate://crates.io/quote/1.0.40 \
     crate://crates.io/radix_trie/0.2.1 \
@@ -347,7 +347,7 @@ SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e
 SRC_URI[ppv-lite86-0.2.21.sha256sum] = "85eae3c4ed2f50dcfe72643da4befc30deadb458a9b590d720cde2f2b1e97da9"
 SRC_URI[proc-macro-crate-1.1.0.sha256sum] = "1ebace6889caf889b4d3f76becee12e90353f2b8c7d875534a71e5742f8f6f83"
 SRC_URI[proc-macro2-1.0.95.sha256sum] = "02b3e5e68a3a1a02aad3ec490a98007cbc13c37cbe84a3cd7b8e406d76e7f778"
-SRC_URI[psl-2.1.197.sha256sum] = "b15ca31b68a87f984f41949f5e4341502dcd2af119b3226ba7285b3fe3e77ea2"
+SRC_URI[psl-2.1.215.sha256sum] = "caff7403e06671f170c65dc7bf475ed31d6e108c7e0d2440fb4df8ba56cfded6"
 SRC_URI[psl-types-2.0.11.sha256sum] = "33cb294fe86a74cbcf50d4445b37da762029549ebeea341421c7c70370f86cac"
 SRC_URI[quote-1.0.40.sha256sum] = "1885c039570dc00dcb4ff087a89e185fd56bae234ddc7f056a945bf36467248d"
 SRC_URI[radix_trie-0.2.1.sha256sum] = "c069c179fcdc6a2fe24d8d18305cf085fdbd4f922c041943e203685d6a1c58fd"
@@ -434,152 +434,147 @@ SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661
 SRC_URI[x509-parser-0.16.0.sha256sum] = "fcbc162f30700d6f3f82a24bf7cc62ffe7caea42c0b2cba8bf7f3ae50cf51f69"
 SRC_URI[zerocopy-0.8.25.sha256sum] = "a1702d9583232ddb9174e01bb7c15a2ab8fb1bc6f227aa1233858c351a3ba0cb"
 SRC_URI[zerocopy-derive-0.8.25.sha256sum] = "28a6e20d751156648aa063f3800b706ee209a32c0b4d9f24be3d980b01be55ef"
-# from rust/vendor/valuable/Cargo.lock
+# from rust/vendor/lazy_static/Cargo.lock
 SRC_URI += " \
-    crate://crates.io/aho-corasick/1.1.3 \
-    crate://crates.io/atty/0.2.14 \
-    crate://crates.io/autocfg/1.4.0 \
-    crate://crates.io/bitflags/1.3.2 \
-    crate://crates.io/bumpalo/3.16.0 \
-    crate://crates.io/cast/0.3.0 \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/clap/2.34.0 \
-    crate://crates.io/criterion/0.3.6 \
-    crate://crates.io/criterion-plot/0.4.5 \
-    crate://crates.io/crossbeam-deque/0.8.6 \
-    crate://crates.io/crossbeam-epoch/0.9.18 \
-    crate://crates.io/crossbeam-utils/0.8.21 \
-    crate://crates.io/csv/1.3.1 \
-    crate://crates.io/csv-core/0.1.11 \
-    crate://crates.io/either/1.13.0 \
-    crate://crates.io/half/1.8.3 \
-    crate://crates.io/hermit-abi/0.1.19 \
-    crate://crates.io/itertools/0.10.5 \
-    crate://crates.io/itoa/1.0.14 \
-    crate://crates.io/js-sys/0.3.76 \
-    crate://crates.io/lazy_static/1.5.0 \
-    crate://crates.io/libc/0.2.169 \
-    crate://crates.io/log/0.4.22 \
+    crate://crates.io/doc-comment/0.3.3 \
+    crate://crates.io/equivalent/1.0.1 \
+    crate://crates.io/glob/0.3.1 \
+    crate://crates.io/hashbrown/0.14.5 \
+    crate://crates.io/indexmap/2.2.6 \
+    crate://crates.io/itoa/1.0.11 \
     crate://crates.io/memchr/2.7.4 \
-    crate://crates.io/num-traits/0.2.19 \
-    crate://crates.io/once_cell/1.20.2 \
-    crate://crates.io/oorandom/11.1.4 \
-    crate://crates.io/plotters/0.3.7 \
-    crate://crates.io/plotters-backend/0.3.7 \
-    crate://crates.io/plotters-svg/0.3.7 \
-    crate://crates.io/proc-macro2/1.0.93 \
-    crate://crates.io/quote/1.0.38 \
-    crate://crates.io/rayon/1.10.0 \
-    crate://crates.io/rayon-core/1.12.1 \
-    crate://crates.io/regex/1.11.1 \
-    crate://crates.io/regex-automata/0.4.9 \
-    crate://crates.io/regex-syntax/0.8.5 \
+    crate://crates.io/proc-macro2/1.0.86 \
+    crate://crates.io/quote/1.0.36 \
     crate://crates.io/ryu/1.0.18 \
+    crate://crates.io/serde/1.0.203 \
+    crate://crates.io/serde_derive/1.0.203 \
+    crate://crates.io/serde_json/1.0.117 \
+    crate://crates.io/serde_spanned/0.6.6 \
+    crate://crates.io/spin/0.9.8 \
+    crate://crates.io/syn/2.0.67 \
+    crate://crates.io/termcolor/1.4.1 \
+    crate://crates.io/toml/0.8.14 \
+    crate://crates.io/toml_datetime/0.6.6 \
+    crate://crates.io/toml_edit/0.22.14 \
+    crate://crates.io/trybuild/1.0.96 \
+    crate://crates.io/unicode-ident/1.0.12 \
+    crate://crates.io/winapi-util/0.1.8 \
+    crate://crates.io/windows-sys/0.52.0 \
+    crate://crates.io/windows-targets/0.52.5 \
+    crate://crates.io/windows_aarch64_gnullvm/0.52.5 \
+    crate://crates.io/windows_aarch64_msvc/0.52.5 \
+    crate://crates.io/windows_i686_gnu/0.52.5 \
+    crate://crates.io/windows_i686_gnullvm/0.52.5 \
+    crate://crates.io/windows_i686_msvc/0.52.5 \
+    crate://crates.io/windows_x86_64_gnu/0.52.5 \
+    crate://crates.io/windows_x86_64_gnullvm/0.52.5 \
+    crate://crates.io/windows_x86_64_msvc/0.52.5 \
+    crate://crates.io/winnow/0.6.13 \
+"
+
+SRC_URI[doc-comment-0.3.3.sha256sum] = "fea41bba32d969b513997752735605054bc0dfa92b4c56bf1189f2e174be7a10"
+SRC_URI[equivalent-1.0.1.sha256sum] = "5443807d6dff69373d433ab9ef5378ad8df50ca6298caf15de6e52e24aaf54d5"
+SRC_URI[glob-0.3.1.sha256sum] = "d2fabcfbdc87f4758337ca535fb41a6d701b65693ce38287d856d1674551ec9b"
+SRC_URI[hashbrown-0.14.5.sha256sum] = "e5274423e17b7c9fc20b6e7e208532f9b19825d82dfd615708b70edd83df41f1"
+SRC_URI[indexmap-2.2.6.sha256sum] = "168fb715dda47215e360912c096649d23d58bf392ac62f73919e831745e40f26"
+SRC_URI[itoa-1.0.11.sha256sum] = "49f1f14873335454500d59611f1cf4a4b0f786f9ac11f4312a78e4cf2566695b"
+SRC_URI[memchr-2.7.4.sha256sum] = "78ca9ab1a0babb1e7d5695e3530886289c18cf2f87ec19a575a0abdce112e3a3"
+SRC_URI[proc-macro2-1.0.86.sha256sum] = "5e719e8df665df0d1c8fbfd238015744736151d4445ec0836b8e628aae103b77"
+SRC_URI[quote-1.0.36.sha256sum] = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
+SRC_URI[ryu-1.0.18.sha256sum] = "f3cb5ba0dc43242ce17de99c180e96db90b235b8a9fdc9543c96d2209116bd9f"
+SRC_URI[serde-1.0.203.sha256sum] = "7253ab4de971e72fb7be983802300c30b5a7f0c2e56fab8abfc6a214307c0094"
+SRC_URI[serde_derive-1.0.203.sha256sum] = "500cbc0ebeb6f46627f50f3f5811ccf6bf00643be300b4c3eabc0ef55dc5b5ba"
+SRC_URI[serde_json-1.0.117.sha256sum] = "455182ea6142b14f93f4bc5320a2b31c1f266b66a4a5c858b013302a5d8cbfc3"
+SRC_URI[serde_spanned-0.6.6.sha256sum] = "79e674e01f999af37c49f70a6ede167a8a60b2503e56c5599532a65baa5969a0"
+SRC_URI[spin-0.9.8.sha256sum] = "6980e8d7511241f8acf4aebddbb1ff938df5eebe98691418c4468d0b72a96a67"
+SRC_URI[syn-2.0.67.sha256sum] = "ff8655ed1d86f3af4ee3fd3263786bc14245ad17c4c7e85ba7187fb3ae028c90"
+SRC_URI[termcolor-1.4.1.sha256sum] = "06794f8f6c5c898b3275aebefa6b8a1cb24cd2c6c79397ab15774837a0bc5755"
+SRC_URI[toml-0.8.14.sha256sum] = "6f49eb2ab21d2f26bd6db7bf383edc527a7ebaee412d17af4d40fdccd442f335"
+SRC_URI[toml_datetime-0.6.6.sha256sum] = "4badfd56924ae69bcc9039335b2e017639ce3f9b001c393c1b2d1ef846ce2cbf"
+SRC_URI[toml_edit-0.22.14.sha256sum] = "f21c7aaf97f1bd9ca9d4f9e73b0a6c74bd5afef56f2bc931943a6e1c37e04e38"
+SRC_URI[trybuild-1.0.96.sha256sum] = "33a5f13f11071020bb12de7a16b925d2d58636175c20c11dc5f96cb64bb6c9b3"
+SRC_URI[unicode-ident-1.0.12.sha256sum] = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
+SRC_URI[winapi-util-0.1.8.sha256sum] = "4d4cc384e1e73b93bafa6fb4f1df8c41695c8a91cf9c4c64358067d15a7b6c6b"
+SRC_URI[windows-sys-0.52.0.sha256sum] = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
+SRC_URI[windows-targets-0.52.5.sha256sum] = "6f0713a46559409d202e70e28227288446bf7841d3211583a4b53e3f6d96e7eb"
+SRC_URI[windows_aarch64_gnullvm-0.52.5.sha256sum] = "7088eed71e8b8dda258ecc8bac5fb1153c5cffaf2578fc8ff5d61e23578d3263"
+SRC_URI[windows_aarch64_msvc-0.52.5.sha256sum] = "9985fd1504e250c615ca5f281c3f7a6da76213ebd5ccc9561496568a2752afb6"
+SRC_URI[windows_i686_gnu-0.52.5.sha256sum] = "88ba073cf16d5372720ec942a8ccbf61626074c6d4dd2e745299726ce8b89670"
+SRC_URI[windows_i686_gnullvm-0.52.5.sha256sum] = "87f4261229030a858f36b459e748ae97545d6f1ec60e5e0d6a3d32e0dc232ee9"
+SRC_URI[windows_i686_msvc-0.52.5.sha256sum] = "db3c2bf3d13d5b658be73463284eaf12830ac9a26a90c717b7f771dfe97487bf"
+SRC_URI[windows_x86_64_gnu-0.52.5.sha256sum] = "4e4246f76bdeff09eb48875a0fd3e2af6aada79d409d33011886d3e1581517d9"
+SRC_URI[windows_x86_64_gnullvm-0.52.5.sha256sum] = "852298e482cd67c356ddd9570386e2862b5673c85bd5f88df9ab6802b334c596"
+SRC_URI[windows_x86_64_msvc-0.52.5.sha256sum] = "bec47e5bfd1bff0eeaf6d8b485cc1074891a197ab4225d504cb7a1ab88b02bf0"
+SRC_URI[winnow-0.6.13.sha256sum] = "59b5e5f6c299a3c7890b876a2a587f3115162487e704907d9b6cd29473052ba1"
+# from rust/vendor/nibble_vec/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/atty/0.2.14 \
+    crate://crates.io/autocfg/1.0.0 \
+    crate://crates.io/bitflags/1.2.1 \
+    crate://crates.io/bstr/0.2.13 \
+    crate://crates.io/bumpalo/3.4.0 \
+    crate://crates.io/byteorder/1.3.4 \
+    crate://crates.io/cast/0.2.3 \
+    crate://crates.io/cfg-if/0.1.10 \
+    crate://crates.io/clap/2.33.1 \
+    crate://crates.io/criterion/0.3.2 \
+    crate://crates.io/criterion-plot/0.4.2 \
+    crate://crates.io/crossbeam-deque/0.7.3 \
+    crate://crates.io/crossbeam-epoch/0.8.2 \
+    crate://crates.io/crossbeam-queue/0.2.3 \
+    crate://crates.io/crossbeam-utils/0.7.2 \
+    crate://crates.io/csv/1.1.3 \
+    crate://crates.io/csv-core/0.1.10 \
+    crate://crates.io/either/1.5.3 \
+    crate://crates.io/hermit-abi/0.1.14 \
+    crate://crates.io/itertools/0.9.0 \
+    crate://crates.io/itoa/0.4.6 \
+    crate://crates.io/js-sys/0.3.40 \
+    crate://crates.io/lazy_static/1.4.0 \
+    crate://crates.io/libc/0.2.71 \
+    crate://crates.io/log/0.4.8 \
+    crate://crates.io/maybe-uninit/2.0.0 \
+    crate://crates.io/memchr/2.3.3 \
+    crate://crates.io/memoffset/0.5.4 \
+    crate://crates.io/num-traits/0.2.12 \
+    crate://crates.io/num_cpus/1.13.0 \
+    crate://crates.io/oorandom/11.1.2 \
+    crate://crates.io/plotters/0.2.15 \
+    crate://crates.io/proc-macro2/1.0.18 \
+    crate://crates.io/quote/1.0.7 \
+    crate://crates.io/rayon/1.3.1 \
+    crate://crates.io/rayon-core/1.7.1 \
+    crate://crates.io/regex/1.3.9 \
+    crate://crates.io/regex-automata/0.1.9 \
+    crate://crates.io/regex-syntax/0.6.18 \
+    crate://crates.io/rustc_version/0.2.3 \
+    crate://crates.io/ryu/1.0.5 \
     crate://crates.io/same-file/1.0.6 \
-    crate://crates.io/serde/1.0.217 \
-    crate://crates.io/serde_cbor/0.11.2 \
-    crate://crates.io/serde_derive/1.0.217 \
-    crate://crates.io/serde_json/1.0.135 \
-    crate://crates.io/syn/2.0.96 \
+    crate://crates.io/scopeguard/1.1.0 \
+    crate://crates.io/semver/0.9.0 \
+    crate://crates.io/semver-parser/0.7.0 \
+    crate://crates.io/serde/1.0.114 \
+    crate://crates.io/serde_derive/1.0.114 \
+    crate://crates.io/serde_json/1.0.55 \
+    crate://crates.io/smallvec/1.4.0 \
+    crate://crates.io/syn/1.0.33 \
     crate://crates.io/textwrap/0.11.0 \
-    crate://crates.io/tinytemplate/1.2.1 \
-    crate://crates.io/unicode-ident/1.0.14 \
-    crate://crates.io/unicode-width/0.1.14 \
-    crate://crates.io/valuable-derive/0.1.1 \
-    crate://crates.io/walkdir/2.5.0 \
-    crate://crates.io/wasm-bindgen/0.2.99 \
-    crate://crates.io/wasm-bindgen-backend/0.2.99 \
-    crate://crates.io/wasm-bindgen-macro/0.2.99 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.99 \
-    crate://crates.io/wasm-bindgen-shared/0.2.99 \
-    crate://crates.io/web-sys/0.3.76 \
+    crate://crates.io/tinytemplate/1.1.0 \
+    crate://crates.io/unicode-width/0.1.7 \
+    crate://crates.io/unicode-xid/0.2.1 \
+    crate://crates.io/walkdir/2.3.1 \
+    crate://crates.io/wasm-bindgen/0.2.63 \
+    crate://crates.io/wasm-bindgen-backend/0.2.63 \
+    crate://crates.io/wasm-bindgen-macro/0.2.63 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.63 \
+    crate://crates.io/wasm-bindgen-shared/0.2.63 \
+    crate://crates.io/web-sys/0.3.40 \
     crate://crates.io/winapi/0.3.9 \
     crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-    crate://crates.io/winapi-util/0.1.9 \
+    crate://crates.io/winapi-util/0.1.5 \
     crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
-    crate://crates.io/windows-sys/0.59.0 \
-    crate://crates.io/windows-targets/0.52.6 \
-    crate://crates.io/windows_aarch64_gnullvm/0.52.6 \
-    crate://crates.io/windows_aarch64_msvc/0.52.6 \
-    crate://crates.io/windows_i686_gnu/0.52.6 \
-    crate://crates.io/windows_i686_gnullvm/0.52.6 \
-    crate://crates.io/windows_i686_msvc/0.52.6 \
-    crate://crates.io/windows_x86_64_gnu/0.52.6 \
-    crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
-    crate://crates.io/windows_x86_64_msvc/0.52.6 \
 "
 
-SRC_URI[aho-corasick-1.1.3.sha256sum] = "8e60d3430d3a69478ad0993f19238d2df97c507009a52b3c10addcd7f6bcb916"
-SRC_URI[atty-0.2.14.sha256sum] = "d9b39be18770d11421cdb1b9947a45dd3f37e93092cbf377614828a319d5fee8"
-SRC_URI[autocfg-1.4.0.sha256sum] = "ace50bade8e6234aa140d9a2f552bbee1db4d353f69b8217bc503490fc1a9f26"
-SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
-SRC_URI[bumpalo-3.16.0.sha256sum] = "79296716171880943b8470b5f8d03aa55eb2e645a4874bdbb28adb49162e012c"
-SRC_URI[cast-0.3.0.sha256sum] = "37b2a672a2cb129a2e41c10b1224bb368f9f37a2b16b612598138befd7b37eb5"
-SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[clap-2.34.0.sha256sum] = "a0610544180c38b88101fecf2dd634b174a62eef6946f84dfc6a7127512b381c"
-SRC_URI[criterion-0.3.6.sha256sum] = "b01d6de93b2b6c65e17c634a26653a29d107b3c98c607c765bf38d041531cd8f"
-SRC_URI[criterion-plot-0.4.5.sha256sum] = "2673cc8207403546f45f5fd319a974b1e6983ad1a3ee7e6041650013be041876"
-SRC_URI[crossbeam-deque-0.8.6.sha256sum] = "9dd111b7b7f7d55b72c0a6ae361660ee5853c9af73f70c3c2ef6858b950e2e51"
-SRC_URI[crossbeam-epoch-0.9.18.sha256sum] = "5b82ac4a3c2ca9c3460964f020e1402edd5753411d7737aa39c3714ad1b5420e"
-SRC_URI[crossbeam-utils-0.8.21.sha256sum] = "d0a5c400df2834b80a4c3327b3aad3a4c4cd4de0629063962b03235697506a28"
-SRC_URI[csv-1.3.1.sha256sum] = "acdc4883a9c96732e4733212c01447ebd805833b7275a73ca3ee080fd77afdaf"
-SRC_URI[csv-core-0.1.11.sha256sum] = "5efa2b3d7902f4b634a20cae3c9c4e6209dc4779feb6863329607560143efa70"
-SRC_URI[either-1.13.0.sha256sum] = "60b1af1c220855b6ceac025d3f6ecdd2b7c4894bfe9cd9bda4fbb4bc7c0d4cf0"
-SRC_URI[half-1.8.3.sha256sum] = "1b43ede17f21864e81be2fa654110bf1e793774238d86ef8555c37e6519c0403"
-SRC_URI[hermit-abi-0.1.19.sha256sum] = "62b467343b94ba476dcb2500d242dadbb39557df889310ac77c5d99100aaac33"
-SRC_URI[itertools-0.10.5.sha256sum] = "b0fd2260e829bddf4cb6ea802289de2f86d6a7a690192fbe91b3f46e0f2c8473"
-SRC_URI[itoa-1.0.14.sha256sum] = "d75a2a4b1b190afb6f5425f10f6a8f959d2ea0b9c2b1d79553551850539e4674"
-SRC_URI[js-sys-0.3.76.sha256sum] = "6717b6b5b077764fb5966237269cb3c64edddde4b14ce42647430a78ced9e7b7"
-SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
-SRC_URI[libc-0.2.169.sha256sum] = "b5aba8db14291edd000dfcc4d620c7ebfb122c613afb886ca8803fa4e128a20a"
-SRC_URI[log-0.4.22.sha256sum] = "a7a70ba024b9dc04c27ea2f0c0548feb474ec5c54bba33a7f72f873a39d07b24"
-SRC_URI[memchr-2.7.4.sha256sum] = "78ca9ab1a0babb1e7d5695e3530886289c18cf2f87ec19a575a0abdce112e3a3"
-SRC_URI[num-traits-0.2.19.sha256sum] = "071dfc062690e90b734c0b2273ce72ad0ffa95f0c74596bc250dcfd960262841"
-SRC_URI[once_cell-1.20.2.sha256sum] = "1261fe7e33c73b354eab43b1273a57c8f967d0391e80353e51f764ac02cf6775"
-SRC_URI[oorandom-11.1.4.sha256sum] = "b410bbe7e14ab526a0e86877eb47c6996a2bd7746f027ba551028c925390e4e9"
-SRC_URI[plotters-0.3.7.sha256sum] = "5aeb6f403d7a4911efb1e33402027fc44f29b5bf6def3effcc22d7bb75f2b747"
-SRC_URI[plotters-backend-0.3.7.sha256sum] = "df42e13c12958a16b3f7f4386b9ab1f3e7933914ecea48da7139435263a4172a"
-SRC_URI[plotters-svg-0.3.7.sha256sum] = "51bae2ac328883f7acdfea3d66a7c35751187f870bc81f94563733a154d7a670"
-SRC_URI[proc-macro2-1.0.93.sha256sum] = "60946a68e5f9d28b0dc1c21bb8a97ee7d018a8b322fa57838ba31cc878e22d99"
-SRC_URI[quote-1.0.38.sha256sum] = "0e4dccaaaf89514f546c693ddc140f729f958c247918a13380cccc6078391acc"
-SRC_URI[rayon-1.10.0.sha256sum] = "b418a60154510ca1a002a752ca9714984e21e4241e804d32555251faf8b78ffa"
-SRC_URI[rayon-core-1.12.1.sha256sum] = "1465873a3dfdaa8ae7cb14b4383657caab0b3e8a0aa9ae8e04b044854c8dfce2"
-SRC_URI[regex-1.11.1.sha256sum] = "b544ef1b4eac5dc2db33ea63606ae9ffcfac26c1416a2806ae0bf5f56b201191"
-SRC_URI[regex-automata-0.4.9.sha256sum] = "809e8dc61f6de73b46c85f4c96486310fe304c434cfa43669d7b40f711150908"
-SRC_URI[regex-syntax-0.8.5.sha256sum] = "2b15c43186be67a4fd63bee50d0303afffcef381492ebe2c5d87f324e1b8815c"
-SRC_URI[ryu-1.0.18.sha256sum] = "f3cb5ba0dc43242ce17de99c180e96db90b235b8a9fdc9543c96d2209116bd9f"
-SRC_URI[same-file-1.0.6.sha256sum] = "93fc1dc3aaa9bfed95e02e6eadabb4baf7e3078b0bd1b4d7b6b0b68378900502"
-SRC_URI[serde-1.0.217.sha256sum] = "02fc4265df13d6fa1d00ecff087228cc0a2b5f3c0e87e258d8b94a156e984c70"
-SRC_URI[serde_cbor-0.11.2.sha256sum] = "2bef2ebfde456fb76bbcf9f59315333decc4fda0b2b44b420243c11e0f5ec1f5"
-SRC_URI[serde_derive-1.0.217.sha256sum] = "5a9bf7cf98d04a2b28aead066b7496853d4779c9cc183c440dbac457641e19a0"
-SRC_URI[serde_json-1.0.135.sha256sum] = "2b0d7ba2887406110130a978386c4e1befb98c674b4fba677954e4db976630d9"
-SRC_URI[syn-2.0.96.sha256sum] = "d5d0adab1ae378d7f53bdebc67a39f1f151407ef230f0ce2883572f5d8985c80"
-SRC_URI[textwrap-0.11.0.sha256sum] = "d326610f408c7a4eb6f51c37c330e496b08506c9457c9d34287ecc38809fb060"
-SRC_URI[tinytemplate-1.2.1.sha256sum] = "be4d6b5f19ff7664e8c98d03e2139cb510db9b0a60b55f8e8709b689d939b6bc"
-SRC_URI[unicode-ident-1.0.14.sha256sum] = "adb9e6ca4f869e1180728b7950e35922a7fc6397f7b641499e8f3ef06e50dc83"
-SRC_URI[unicode-width-0.1.14.sha256sum] = "7dd6e30e90baa6f72411720665d41d89b9a3d039dc45b8faea1ddd07f617f6af"
-SRC_URI[valuable-derive-0.1.1.sha256sum] = "4e3a32a9bcc0f6c6ccfd5b27bcf298c58e753bcc9eeff268157a303393183a6d"
-SRC_URI[walkdir-2.5.0.sha256sum] = "29790946404f91d9c5d06f9874efddea1dc06c5efe94541a7d6863108e3a5e4b"
-SRC_URI[wasm-bindgen-0.2.99.sha256sum] = "a474f6281d1d70c17ae7aa6a613c87fce69a127e2624002df63dcb39d6cf6396"
-SRC_URI[wasm-bindgen-backend-0.2.99.sha256sum] = "5f89bb38646b4f81674e8f5c3fb81b562be1fd936d84320f3264486418519c79"
-SRC_URI[wasm-bindgen-macro-0.2.99.sha256sum] = "2cc6181fd9a7492eef6fef1f33961e3695e4579b9872a6f7c83aee556666d4fe"
-SRC_URI[wasm-bindgen-macro-support-0.2.99.sha256sum] = "30d7a95b763d3c45903ed6c81f156801839e5ee968bb07e534c44df0fcd330c2"
-SRC_URI[wasm-bindgen-shared-0.2.99.sha256sum] = "943aab3fdaaa029a6e0271b35ea10b72b943135afe9bffca82384098ad0e06a6"
-SRC_URI[web-sys-0.3.76.sha256sum] = "04dd7223427d52553d3702c004d3b2fe07c148165faa56313cb00211e31c12bc"
-SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
-SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
-SRC_URI[winapi-util-0.1.9.sha256sum] = "cf221c93e13a30d793f7645a0e7762c55d169dbb0a49671918a2319d289b10bb"
-SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
-SRC_URI[windows-sys-0.59.0.sha256sum] = "1e38bc4d79ed67fd075bcc251a1c39b32a1776bbe92e5bef1f0bf1f8c531853b"
-SRC_URI[windows-targets-0.52.6.sha256sum] = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
-SRC_URI[windows_aarch64_gnullvm-0.52.6.sha256sum] = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
-SRC_URI[windows_aarch64_msvc-0.52.6.sha256sum] = "09ec2a7bb152e2252b53fa7803150007879548bc709c039df7627cabbd05d469"
-SRC_URI[windows_i686_gnu-0.52.6.sha256sum] = "8e9b5ad5ab802e97eb8e295ac6720e509ee4c243f69d781394014ebfe8bbfa0b"
-SRC_URI[windows_i686_gnullvm-0.52.6.sha256sum] = "0eee52d38c090b3caa76c563b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
-SRC_URI[windows_i686_msvc-0.52.6.sha256sum] = "240948bc05c5e7c6dabba28bf89d89ffce3e303022809e73deaefe4f6ec56c66"
-SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
-SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
-SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
 # from rust/vendor/base64/Cargo.lock
 SRC_URI += " \
     crate://crates.io/anes/0.1.6 \
@@ -906,6 +901,154 @@ SRC_URI[windows_x86_64_gnullvm-0.48.5.sha256sum] = "0b7b52767868a23d5bab768e390d
 SRC_URI[windows_x86_64_gnullvm-0.52.4.sha256sum] = "77ca79f2451b49fa9e2af39f0747fe999fcda4f5e241b2898624dca97a1f2177"
 SRC_URI[windows_x86_64_msvc-0.48.5.sha256sum] = "ed94fce61571a4006852b7389a063ab983c02eb1bb37b47f8272ce92d06d9538"
 SRC_URI[windows_x86_64_msvc-0.52.4.sha256sum] = "32b752e52a2da0ddfbdbcc6fceadfeede4c939ed16d13e648833a61dfb611ed8"
+# from rust/vendor/once_cell/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/aho-corasick/1.1.3 \
+    crate://crates.io/bitflags/2.6.0 \
+    crate://crates.io/cfg-if/1.0.0 \
+    crate://crates.io/critical-section/1.1.3 \
+    crate://crates.io/libc/0.2.158 \
+    crate://crates.io/memchr/2.7.4 \
+    crate://crates.io/parking_lot_core/0.9.10 \
+    crate://crates.io/portable-atomic/1.9.0 \
+    crate://crates.io/redox_syscall/0.5.4 \
+    crate://crates.io/regex/1.10.6 \
+    crate://crates.io/regex-automata/0.4.7 \
+    crate://crates.io/regex-syntax/0.8.4 \
+    crate://crates.io/smallvec/1.13.2 \
+    crate://crates.io/windows-targets/0.52.6 \
+    crate://crates.io/windows_aarch64_gnullvm/0.52.6 \
+    crate://crates.io/windows_aarch64_msvc/0.52.6 \
+    crate://crates.io/windows_i686_gnu/0.52.6 \
+    crate://crates.io/windows_i686_gnullvm/0.52.6 \
+    crate://crates.io/windows_i686_msvc/0.52.6 \
+    crate://crates.io/windows_x86_64_gnu/0.52.6 \
+    crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
+    crate://crates.io/windows_x86_64_msvc/0.52.6 \
+"
+
+SRC_URI[aho-corasick-1.1.3.sha256sum] = "8e60d3430d3a69478ad0993f19238d2df97c507009a52b3c10addcd7f6bcb916"
+SRC_URI[bitflags-2.6.0.sha256sum] = "b048fb63fd8b5923fc5aa7b340d8e156aec7ec02f0c78fa8a6ddc2613f6f71de"
+SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+SRC_URI[critical-section-1.1.3.sha256sum] = "f64009896348fc5af4222e9cf7d7d82a95a256c634ebcf61c53e4ea461422242"
+SRC_URI[libc-0.2.158.sha256sum] = "d8adc4bb1803a324070e64a98ae98f38934d91957a99cfb3a43dcbc01bc56439"
+SRC_URI[memchr-2.7.4.sha256sum] = "78ca9ab1a0babb1e7d5695e3530886289c18cf2f87ec19a575a0abdce112e3a3"
+SRC_URI[parking_lot_core-0.9.10.sha256sum] = "1e401f977ab385c9e4e3ab30627d6f26d00e2c73eef317493c4ec6d468726cf8"
+SRC_URI[portable-atomic-1.9.0.sha256sum] = "cc9c68a3f6da06753e9335d63e27f6b9754dd1920d941135b7ea8224f141adb2"
+SRC_URI[redox_syscall-0.5.4.sha256sum] = "0884ad60e090bf1345b93da0a5de8923c93884cd03f40dfcfddd3b4bee661853"
+SRC_URI[regex-1.10.6.sha256sum] = "4219d74c6b67a3654a9fbebc4b419e22126d13d2f3c4a07ee0cb61ff79a79619"
+SRC_URI[regex-automata-0.4.7.sha256sum] = "38caf58cc5ef2fed281f89292ef23f6365465ed9a41b7a7754eb4e26496c92df"
+SRC_URI[regex-syntax-0.8.4.sha256sum] = "7a66a03ae7c801facd77a29370b4faec201768915ac14a721ba36f20bc9c209b"
+SRC_URI[smallvec-1.13.2.sha256sum] = "3c5e1a9a646d36c3599cd173a41282daf47c44583ad367b8e6837255952e5c67"
+SRC_URI[windows-targets-0.52.6.sha256sum] = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
+SRC_URI[windows_aarch64_gnullvm-0.52.6.sha256sum] = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
+SRC_URI[windows_aarch64_msvc-0.52.6.sha256sum] = "09ec2a7bb152e2252b53fa7803150007879548bc709c039df7627cabbd05d469"
+SRC_URI[windows_i686_gnu-0.52.6.sha256sum] = "8e9b5ad5ab802e97eb8e295ac6720e509ee4c243f69d781394014ebfe8bbfa0b"
+SRC_URI[windows_i686_gnullvm-0.52.6.sha256sum] = "0eee52d38c090b3caa76c563b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
+SRC_URI[windows_i686_msvc-0.52.6.sha256sum] = "240948bc05c5e7c6dabba28bf89d89ffce3e303022809e73deaefe4f6ec56c66"
+SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
+SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
+SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
+# from rust/vendor/bitflags/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/arbitrary/1.4.1 \
+    crate://crates.io/bytemuck/1.23.0 \
+    crate://crates.io/bytemuck_derive/1.9.3 \
+    crate://crates.io/compiler_builtins/0.1.159 \
+    crate://crates.io/derive_arbitrary/1.4.1 \
+    crate://crates.io/equivalent/1.0.2 \
+    crate://crates.io/glob/0.3.2 \
+    crate://crates.io/hashbrown/0.15.3 \
+    crate://crates.io/indexmap/2.9.0 \
+    crate://crates.io/itoa/1.0.15 \
+    crate://crates.io/memchr/2.7.4 \
+    crate://crates.io/proc-macro2/1.0.95 \
+    crate://crates.io/quote/1.0.40 \
+    crate://crates.io/rustc-std-workspace-core/1.0.1 \
+    crate://crates.io/rustversion/1.0.20 \
+    crate://crates.io/ryu/1.0.20 \
+    crate://crates.io/serde/1.0.219 \
+    crate://crates.io/serde_derive/1.0.219 \
+    crate://crates.io/serde_json/1.0.140 \
+    crate://crates.io/serde_spanned/0.6.8 \
+    crate://crates.io/serde_test/1.0.177 \
+    crate://crates.io/syn/2.0.101 \
+    crate://crates.io/target-triple/0.1.4 \
+    crate://crates.io/termcolor/1.4.1 \
+    crate://crates.io/toml/0.8.22 \
+    crate://crates.io/toml_datetime/0.6.9 \
+    crate://crates.io/toml_edit/0.22.26 \
+    crate://crates.io/toml_write/0.1.1 \
+    crate://crates.io/trybuild/1.0.105 \
+    crate://crates.io/unicode-ident/1.0.18 \
+    crate://crates.io/winapi-util/0.1.9 \
+    crate://crates.io/windows-sys/0.59.0 \
+    crate://crates.io/windows-targets/0.52.6 \
+    crate://crates.io/windows_aarch64_gnullvm/0.52.6 \
+    crate://crates.io/windows_aarch64_msvc/0.52.6 \
+    crate://crates.io/windows_i686_gnu/0.52.6 \
+    crate://crates.io/windows_i686_gnullvm/0.52.6 \
+    crate://crates.io/windows_i686_msvc/0.52.6 \
+    crate://crates.io/windows_x86_64_gnu/0.52.6 \
+    crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
+    crate://crates.io/windows_x86_64_msvc/0.52.6 \
+    crate://crates.io/winnow/0.7.10 \
+    crate://crates.io/zerocopy/0.8.25 \
+    crate://crates.io/zerocopy-derive/0.8.25 \
+"
+
+SRC_URI[arbitrary-1.4.1.sha256sum] = "dde20b3d026af13f561bdd0f15edf01fc734f0dafcedbaf42bba506a9517f223"
+SRC_URI[bytemuck-1.23.0.sha256sum] = "9134a6ef01ce4b366b50689c94f82c14bc72bc5d0386829828a2e2752ef7958c"
+SRC_URI[bytemuck_derive-1.9.3.sha256sum] = "7ecc273b49b3205b83d648f0690daa588925572cc5063745bfe547fe7ec8e1a1"
+SRC_URI[compiler_builtins-0.1.159.sha256sum] = "448068da8f2326b2a0472353cb401dd8795a89c007ef30fff90f50706e862e72"
+SRC_URI[derive_arbitrary-1.4.1.sha256sum] = "30542c1ad912e0e3d22a1935c290e12e8a29d704a420177a31faad4a601a0800"
+SRC_URI[equivalent-1.0.2.sha256sum] = "877a4ace8713b0bcf2a4e7eec82529c029f1d0619886d18145fea96c3ffe5c0f"
+SRC_URI[glob-0.3.2.sha256sum] = "a8d1add55171497b4705a648c6b583acafb01d58050a51727785f0b2c8e0a2b2"
+SRC_URI[hashbrown-0.15.3.sha256sum] = "84b26c544d002229e640969970a2e74021aadf6e2f96372b9c58eff97de08eb3"
+SRC_URI[indexmap-2.9.0.sha256sum] = "cea70ddb795996207ad57735b50c5982d8844f38ba9ee5f1aedcfb708a2aa11e"
+SRC_URI[itoa-1.0.15.sha256sum] = "4a5f13b858c8d314ee3e8f639011f7ccefe71f97f96e50151fb991f267928e2c"
+SRC_URI[memchr-2.7.4.sha256sum] = "78ca9ab1a0babb1e7d5695e3530886289c18cf2f87ec19a575a0abdce112e3a3"
+SRC_URI[proc-macro2-1.0.95.sha256sum] = "02b3e5e68a3a1a02aad3ec490a98007cbc13c37cbe84a3cd7b8e406d76e7f778"
+SRC_URI[quote-1.0.40.sha256sum] = "1885c039570dc00dcb4ff087a89e185fd56bae234ddc7f056a945bf36467248d"
+SRC_URI[rustc-std-workspace-core-1.0.1.sha256sum] = "aa9c45b374136f52f2d6311062c7146bff20fec063c3f5d46a410bd937746955"
+SRC_URI[rustversion-1.0.20.sha256sum] = "eded382c5f5f786b989652c49544c4877d9f015cc22e145a5ea8ea66c2921cd2"
+SRC_URI[ryu-1.0.20.sha256sum] = "28d3b2b1366ec20994f1fd18c3c594f05c5dd4bc44d8bb0c1c632c8d6829481f"
+SRC_URI[serde-1.0.219.sha256sum] = "5f0e2c6ed6606019b4e29e69dbaba95b11854410e5347d525002456dbbb786b6"
+SRC_URI[serde_derive-1.0.219.sha256sum] = "5b0276cf7f2c73365f7157c8123c21cd9a50fbbd844757af28ca1f5925fc2a00"
+SRC_URI[serde_json-1.0.140.sha256sum] = "20068b6e96dc6c9bd23e01df8827e6c7e1f2fddd43c21810382803c136b99373"
+SRC_URI[serde_spanned-0.6.8.sha256sum] = "87607cb1398ed59d48732e575a4c28a7a8ebf2454b964fe3f224f2afc07909e1"
+SRC_URI[serde_test-1.0.177.sha256sum] = "7f901ee573cab6b3060453d2d5f0bae4e6d628c23c0a962ff9b5f1d7c8d4f1ed"
+SRC_URI[syn-2.0.101.sha256sum] = "8ce2b7fc941b3a24138a0a7cf8e858bfc6a992e7978a068a5c760deb0ed43caf"
+SRC_URI[target-triple-0.1.4.sha256sum] = "1ac9aa371f599d22256307c24a9d748c041e548cbf599f35d890f9d365361790"
+SRC_URI[termcolor-1.4.1.sha256sum] = "06794f8f6c5c898b3275aebefa6b8a1cb24cd2c6c79397ab15774837a0bc5755"
+SRC_URI[toml-0.8.22.sha256sum] = "05ae329d1f08c4d17a59bed7ff5b5a769d062e64a62d34a3261b219e62cd5aae"
+SRC_URI[toml_datetime-0.6.9.sha256sum] = "3da5db5a963e24bc68be8b17b6fa82814bb22ee8660f192bb182771d498f09a3"
+SRC_URI[toml_edit-0.22.26.sha256sum] = "310068873db2c5b3e7659d2cc35d21855dbafa50d1ce336397c666e3cb08137e"
+SRC_URI[toml_write-0.1.1.sha256sum] = "bfb942dfe1d8e29a7ee7fcbde5bd2b9a25fb89aa70caea2eba3bee836ff41076"
+SRC_URI[trybuild-1.0.105.sha256sum] = "1c9bf9513a2f4aeef5fdac8677d7d349c79fdbcc03b9c86da6e9d254f1e43be2"
+SRC_URI[unicode-ident-1.0.18.sha256sum] = "5a5f39404a5da50712a4c1eecf25e90dd62b613502b7e925fd4e4d19b5c96512"
+SRC_URI[winapi-util-0.1.9.sha256sum] = "cf221c93e13a30d793f7645a0e7762c55d169dbb0a49671918a2319d289b10bb"
+SRC_URI[windows-sys-0.59.0.sha256sum] = "1e38bc4d79ed67fd075bcc251a1c39b32a1776bbe92e5bef1f0bf1f8c531853b"
+SRC_URI[windows-targets-0.52.6.sha256sum] = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
+SRC_URI[windows_aarch64_gnullvm-0.52.6.sha256sum] = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
+SRC_URI[windows_aarch64_msvc-0.52.6.sha256sum] = "09ec2a7bb152e2252b53fa7803150007879548bc709c039df7627cabbd05d469"
+SRC_URI[windows_i686_gnu-0.52.6.sha256sum] = "8e9b5ad5ab802e97eb8e295ac6720e509ee4c243f69d781394014ebfe8bbfa0b"
+SRC_URI[windows_i686_gnullvm-0.52.6.sha256sum] = "0eee52d38c090b3caa76c563b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
+SRC_URI[windows_i686_msvc-0.52.6.sha256sum] = "240948bc05c5e7c6dabba28bf89d89ffce3e303022809e73deaefe4f6ec56c66"
+SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
+SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
+SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
+SRC_URI[winnow-0.7.10.sha256sum] = "c06928c8748d81b05c9be96aad92e1b6ff01833332f281e8cfca3be4b35fc9ec"
+SRC_URI[zerocopy-0.8.25.sha256sum] = "a1702d9583232ddb9174e01bb7c15a2ab8fb1bc6f227aa1233858c351a3ba0cb"
+SRC_URI[zerocopy-derive-0.8.25.sha256sum] = "28a6e20d751156648aa063f3800b706ee209a32c0b4d9f24be3d980b01be55ef"
+# from rust/vendor/brotli-decompressor/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/alloc-no-stdlib/2.0.4 \
+    crate://crates.io/alloc-stdlib/0.2.2 \
+"
+
+SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
+SRC_URI[alloc-stdlib-0.2.2.sha256sum] = "94fb8275041c72129eb51b7d0322c29b8387a0386127718b096429201a5d6ece"
 # from rust/vendor/failure/Cargo.lock
 SRC_URI += " \
     crate://crates.io/backtrace/0.3.46 \
@@ -934,228 +1077,428 @@ SRC_URI[rustc-demangle-0.1.16.sha256sum] = "4c691c0e608126e00913e33f0ccf3727d5fc
 SRC_URI[syn-1.0.18.sha256sum] = "410a7488c0a728c7ceb4ad59b9567eb4053d02e8cc7f5c0e0eeeb39518369213"
 SRC_URI[synstructure-0.12.3.sha256sum] = "67656ea1dc1b41b1451851562ea232ec2e5a80242139f7e679ceccfb5d61f545"
 SRC_URI[unicode-xid-0.2.0.sha256sum] = "826e7639553986605ec5979c7dd957c7895e93eabed50ab2ffa7f6128a75097c"
-# from rust/vendor/toml/Cargo.lock
+# from rust/vendor/bendy/Cargo.lock
 SRC_URI += " \
-    crate://crates.io/autocfg/1.1.0 \
-    crate://crates.io/hashbrown/0.12.3 \
-    crate://crates.io/indexmap/1.9.2 \
-    crate://crates.io/itoa/1.0.5 \
-    crate://crates.io/proc-macro2/1.0.50 \
-    crate://crates.io/quote/1.0.23 \
-    crate://crates.io/ryu/1.0.12 \
-    crate://crates.io/serde/1.0.152 \
-    crate://crates.io/serde_derive/1.0.152 \
-    crate://crates.io/serde_json/1.0.91 \
-    crate://crates.io/syn/1.0.107 \
-    crate://crates.io/unicode-ident/1.0.6 \
+    crate://crates.io/addr2line/0.14.0 \
+    crate://crates.io/adler/0.2.3 \
+    crate://crates.io/aho-corasick/0.7.15 \
+    crate://crates.io/autocfg/1.0.1 \
+    crate://crates.io/backtrace/0.3.54 \
+    crate://crates.io/cfg-if/1.0.0 \
+    crate://crates.io/failure/0.1.8 \
+    crate://crates.io/failure_derive/0.1.8 \
+    crate://crates.io/gimli/0.23.0 \
+    crate://crates.io/lazy_static/1.4.0 \
+    crate://crates.io/libc/0.2.80 \
+    crate://crates.io/memchr/2.3.4 \
+    crate://crates.io/miniz_oxide/0.4.3 \
+    crate://crates.io/object/0.22.0 \
+    crate://crates.io/proc-macro2/1.0.24 \
+    crate://crates.io/quote/1.0.7 \
+    crate://crates.io/regex/1.4.2 \
+    crate://crates.io/regex-syntax/0.6.21 \
+    crate://crates.io/rustc-demangle/0.1.18 \
+    crate://crates.io/serde/1.0.117 \
+    crate://crates.io/serde_bytes/0.11.5 \
+    crate://crates.io/serde_derive/1.0.117 \
+    crate://crates.io/syn/1.0.48 \
+    crate://crates.io/synstructure/0.12.4 \
+    crate://crates.io/thread_local/1.0.1 \
+    crate://crates.io/unicode-xid/0.2.1 \
 "
 
-SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
-SRC_URI[hashbrown-0.12.3.sha256sum] = "8a9ee70c43aaf417c914396645a0fa852624801b24ebb7ae78fe8272889ac888"
-SRC_URI[indexmap-1.9.2.sha256sum] = "1885e79c1fc4b10f0e172c475f458b7f7b93061064d98c3293e98c5ba0c8b399"
-SRC_URI[itoa-1.0.5.sha256sum] = "fad582f4b9e86b6caa621cabeb0963332d92eea04729ab12892c2533951e6440"
-SRC_URI[proc-macro2-1.0.50.sha256sum] = "6ef7d57beacfaf2d8aee5937dab7b7f28de3cb8b1828479bb5de2a7106f2bae2"
-SRC_URI[quote-1.0.23.sha256sum] = "8856d8364d252a14d474036ea1358d63c9e6965c8e5c1885c18f73d70bff9c7b"
-SRC_URI[ryu-1.0.12.sha256sum] = "7b4b9743ed687d4b4bcedf9ff5eaa7398495ae14e61cba0a295704edbc7decde"
-SRC_URI[serde-1.0.152.sha256sum] = "bb7d1f0d3021d347a83e556fc4683dea2ea09d87bccdf88ff5c12545d89d5efb"
-SRC_URI[serde_derive-1.0.152.sha256sum] = "af487d118eecd09402d70a5d72551860e788df87b464af30e5ea6a38c75c541e"
-SRC_URI[serde_json-1.0.91.sha256sum] = "877c235533714907a8c2464236f5c4b2a17262ef1bd71f38f35ea592c8da6883"
-SRC_URI[syn-1.0.107.sha256sum] = "1f4064b5b16e03ae50984a5a8ed5d4f8803e6bc1fd170a3cda91a1be4b18e3f5"
-SRC_URI[unicode-ident-1.0.6.sha256sum] = "84a22b9f218b40614adcb3f4ff08b703773ad44fa9423e4e0d346d5db86e4ebc"
-# from rust/vendor/bstr/Cargo.lock
+SRC_URI[addr2line-0.14.0.sha256sum] = "7c0929d69e78dd9bf5408269919fcbcaeb2e35e5d43e5815517cdc6a8e11a423"
+SRC_URI[adler-0.2.3.sha256sum] = "ee2a4ec343196209d6594e19543ae87a39f96d5534d7174822a3ad825dd6ed7e"
+SRC_URI[aho-corasick-0.7.15.sha256sum] = "7404febffaa47dac81aa44dba71523c9d069b1bdc50a77db41195149e17f68e5"
+SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a"
+SRC_URI[backtrace-0.3.54.sha256sum] = "2baad346b2d4e94a24347adeee9c7a93f412ee94b9cc26e5b59dea23848e9f28"
+SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+SRC_URI[failure-0.1.8.sha256sum] = "d32e9bd16cc02eae7db7ef620b392808b89f6a5e16bb3497d159c6b92a0f4f86"
+SRC_URI[failure_derive-0.1.8.sha256sum] = "aa4da3c766cd7a0db8242e326e9e4e081edd567072893ed320008189715366a4"
+SRC_URI[gimli-0.23.0.sha256sum] = "f6503fe142514ca4799d4c26297c4248239fe8838d827db6bd6065c6ed29a6ce"
+SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
+SRC_URI[libc-0.2.80.sha256sum] = "4d58d1b70b004888f764dfbf6a26a3b0342a1632d33968e4a179d8011c760614"
+SRC_URI[memchr-2.3.4.sha256sum] = "0ee1c47aaa256ecabcaea351eae4a9b01ef39ed810004e298d2511ed284b1525"
+SRC_URI[miniz_oxide-0.4.3.sha256sum] = "0f2d26ec3309788e423cfbf68ad1800f061638098d76a83681af979dc4eda19d"
+SRC_URI[object-0.22.0.sha256sum] = "8d3b63360ec3cb337817c2dbd47ab4a0f170d285d8e5a2064600f3def1402397"
+SRC_URI[proc-macro2-1.0.24.sha256sum] = "1e0704ee1a7e00d7bb417d0770ea303c1bccbabf0ef1667dae92b5967f5f8a71"
+SRC_URI[quote-1.0.7.sha256sum] = "aa563d17ecb180e500da1cfd2b028310ac758de548efdd203e18f283af693f37"
+SRC_URI[regex-1.4.2.sha256sum] = "38cf2c13ed4745de91a5eb834e11c00bcc3709e773173b2ce4c56c9fbde04b9c"
+SRC_URI[regex-syntax-0.6.21.sha256sum] = "3b181ba2dcf07aaccad5448e8ead58db5b742cf85dfe035e2227f137a539a189"
+SRC_URI[rustc-demangle-0.1.18.sha256sum] = "6e3bad0ee36814ca07d7968269dd4b7ec89ec2da10c4bb613928d3077083c232"
+SRC_URI[serde-1.0.117.sha256sum] = "b88fa983de7720629c9387e9f517353ed404164b1e482c970a90c1a4aaf7dc1a"
+SRC_URI[serde_bytes-0.11.5.sha256sum] = "16ae07dd2f88a366f15bd0632ba725227018c69a1c8550a927324f8eb8368bb9"
+SRC_URI[serde_derive-1.0.117.sha256sum] = "cbd1ae72adb44aab48f325a02444a5fc079349a8d804c1fc922aed3f7454c74e"
+SRC_URI[syn-1.0.48.sha256sum] = "cc371affeffc477f42a221a1e4297aedcea33d47d19b61455588bd9d8f6b19ac"
+SRC_URI[synstructure-0.12.4.sha256sum] = "b834f2d66f734cb897113e34aaff2f1ab4719ca946f9a7358dba8f8064148701"
+SRC_URI[thread_local-1.0.1.sha256sum] = "d40c6d1b69745a6ec6fb1ca717914848da4b44ae29d9b3080cbee91d72a69b14"
+SRC_URI[unicode-xid-0.2.1.sha256sum] = "f7fe0bb3479651439c9112f72b6c505038574c9fbb575ed1bf3b797fa39dd564"
+# from rust/vendor/anstyle/Cargo.lock
 SRC_URI += " \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/getrandom/0.2.11 \
-    crate://crates.io/libc/0.2.151 \
-    crate://crates.io/memchr/2.7.1 \
-    crate://crates.io/proc-macro2/1.0.71 \
-    crate://crates.io/quickcheck/1.0.3 \
-    crate://crates.io/quote/1.0.33 \
-    crate://crates.io/rand/0.8.5 \
-    crate://crates.io/rand_core/0.6.4 \
-    crate://crates.io/regex-automata/0.4.3 \
-    crate://crates.io/regex-lite/0.1.5 \
-    crate://crates.io/serde/1.0.193 \
-    crate://crates.io/serde_derive/1.0.193 \
-    crate://crates.io/syn/2.0.43 \
-    crate://crates.io/ucd-parse/0.1.12 \
-    crate://crates.io/unicode-ident/1.0.12 \
-    crate://crates.io/unicode-segmentation/1.10.1 \
-    crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
+    crate://crates.io/lexopt/0.3.0 \
 "
 
-SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[getrandom-0.2.11.sha256sum] = "fe9006bed769170c11f845cf00c7c1e9092aeb3f268e007c3e760ac68008070f"
-SRC_URI[libc-0.2.151.sha256sum] = "302d7ab3130588088d277783b1e2d2e10c9e9e4a16dd9050e6ec93fb3e7048f4"
-SRC_URI[memchr-2.7.1.sha256sum] = "523dc4f511e55ab87b694dc30d0f820d60906ef06413f93d4d7a1385599cc149"
-SRC_URI[proc-macro2-1.0.71.sha256sum] = "75cb1540fadbd5b8fbccc4dddad2734eba435053f725621c070711a14bb5f4b8"
-SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
-SRC_URI[quote-1.0.33.sha256sum] = "5267fca4496028628a95160fc423a33e8b2e6af8a5302579e322e4b520293cae"
-SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
-SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
-SRC_URI[regex-automata-0.4.3.sha256sum] = "5f804c7828047e88b2d32e2d7fe5a105da8ee3264f01902f796c8e067dc2483f"
-SRC_URI[regex-lite-0.1.5.sha256sum] = "30b661b2f27137bdbc16f00eda72866a92bb28af1753ffbd56744fb6e2e9cd8e"
-SRC_URI[serde-1.0.193.sha256sum] = "25dd9975e68d0cb5aa1120c288333fc98731bd1dd12f561e468ea4728c042b89"
-SRC_URI[serde_derive-1.0.193.sha256sum] = "43576ca501357b9b071ac53cdc7da8ef0cbd9493d8df094cd821777ea6e894d3"
-SRC_URI[syn-2.0.43.sha256sum] = "ee659fb5f3d355364e1f3e5bc10fb82068efbf824a1e9d1c9504244a6469ad53"
-SRC_URI[ucd-parse-0.1.12.sha256sum] = "212c59636157b18c2f57eed2799e6606c52fc49c6a11685ffb0d08f06e55f428"
-SRC_URI[unicode-ident-1.0.12.sha256sum] = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
-SRC_URI[unicode-segmentation-1.10.1.sha256sum] = "1dd624098567895118886609431a7c3b8f516e41d30e0643f03d94592a147e36"
-SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
-# from rust/vendor/nom/Cargo.lock
+SRC_URI[lexopt-0.3.0.sha256sum] = "baff4b617f7df3d896f97fe922b64817f6cd9a756bb81d40f8883f2f66dcb401"
+# from rust/vendor/asn1-rs-0.6.2/Cargo.lock
 SRC_URI += " \
-    crate://crates.io/autocfg/1.0.1 \
-    crate://crates.io/bit-set/0.5.2 \
-    crate://crates.io/bit-vec/0.6.3 \
-    crate://crates.io/bitflags/1.3.2 \
-    crate://crates.io/byteorder/1.4.3 \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/doc-comment/0.3.3 \
-    crate://crates.io/fnv/1.0.7 \
-    crate://crates.io/getrandom/0.2.3 \
-    crate://crates.io/lazy_static/1.4.0 \
-    crate://crates.io/libc/0.2.106 \
-    crate://crates.io/memchr/2.4.1 \
+    crate://crates.io/asn1-rs-derive/0.5.1 \
+    crate://crates.io/asn1-rs-impl/0.2.0 \
+    crate://crates.io/autocfg/1.3.0 \
+    crate://crates.io/base64/0.22.1 \
+    crate://crates.io/bitvec/1.0.1 \
+    crate://crates.io/colored/2.1.0 \
+    crate://crates.io/cookie-factory/0.3.3 \
+    crate://crates.io/deranged/0.3.11 \
+    crate://crates.io/displaydoc/0.2.5 \
+    crate://crates.io/equivalent/1.0.1 \
+    crate://crates.io/funty/2.0.0 \
+    crate://crates.io/futures/0.3.30 \
+    crate://crates.io/futures-channel/0.3.30 \
+    crate://crates.io/futures-core/0.3.30 \
+    crate://crates.io/futures-executor/0.3.30 \
+    crate://crates.io/futures-io/0.3.30 \
+    crate://crates.io/futures-macro/0.3.30 \
+    crate://crates.io/futures-sink/0.3.30 \
+    crate://crates.io/futures-task/0.3.30 \
+    crate://crates.io/futures-util/0.3.30 \
+    crate://crates.io/glob/0.3.1 \
+    crate://crates.io/hashbrown/0.14.5 \
+    crate://crates.io/hex-literal/0.4.1 \
+    crate://crates.io/indexmap/2.2.6 \
+    crate://crates.io/itoa/1.0.11 \
+    crate://crates.io/lazy_static/1.5.0 \
+    crate://crates.io/memchr/2.7.4 \
     crate://crates.io/minimal-lexical/0.2.1 \
-    crate://crates.io/num-traits/0.2.14 \
-    crate://crates.io/ppv-lite86/0.2.15 \
-    crate://crates.io/proptest/1.0.0 \
-    crate://crates.io/quick-error/1.2.3 \
-    crate://crates.io/quick-error/2.0.1 \
-    crate://crates.io/rand/0.8.4 \
-    crate://crates.io/rand_chacha/0.3.1 \
-    crate://crates.io/rand_core/0.6.3 \
-    crate://crates.io/rand_hc/0.3.1 \
-    crate://crates.io/rand_xorshift/0.3.0 \
-    crate://crates.io/redox_syscall/0.2.10 \
-    crate://crates.io/regex-syntax/0.6.25 \
-    crate://crates.io/remove_dir_all/0.5.3 \
-    crate://crates.io/rusty-fork/0.3.0 \
-    crate://crates.io/tempfile/3.2.0 \
-    crate://crates.io/wait-timeout/0.2.0 \
-    crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
-    crate://crates.io/winapi/0.3.9 \
-    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+    crate://crates.io/nom/7.1.3 \
+    crate://crates.io/num-bigint/0.4.6 \
+    crate://crates.io/num-conv/0.1.0 \
+    crate://crates.io/num-integer/0.1.46 \
+    crate://crates.io/num-traits/0.2.19 \
+    crate://crates.io/pem/3.0.4 \
+    crate://crates.io/pin-project-lite/0.2.14 \
+    crate://crates.io/pin-utils/0.1.0 \
+    crate://crates.io/powerfmt/0.2.0 \
+    crate://crates.io/proc-macro2/1.0.86 \
+    crate://crates.io/quote/1.0.36 \
+    crate://crates.io/radium/0.7.0 \
+    crate://crates.io/rusticata-macros/4.1.0 \
+    crate://crates.io/ryu/1.0.18 \
+    crate://crates.io/serde/1.0.204 \
+    crate://crates.io/serde_derive/1.0.204 \
+    crate://crates.io/serde_json/1.0.121 \
+    crate://crates.io/serde_spanned/0.6.7 \
+    crate://crates.io/slab/0.4.9 \
+    crate://crates.io/syn/2.0.72 \
+    crate://crates.io/synstructure/0.13.1 \
+    crate://crates.io/tap/1.0.1 \
+    crate://crates.io/termcolor/1.4.1 \
+    crate://crates.io/thiserror/1.0.63 \
+    crate://crates.io/thiserror-impl/1.0.63 \
+    crate://crates.io/time/0.3.36 \
+    crate://crates.io/time-core/0.1.2 \
+    crate://crates.io/time-macros/0.2.18 \
+    crate://crates.io/toml/0.8.17 \
+    crate://crates.io/toml_datetime/0.6.8 \
+    crate://crates.io/toml_edit/0.22.18 \
+    crate://crates.io/trybuild/1.0.98 \
+    crate://crates.io/unicode-ident/1.0.12 \
+    crate://crates.io/winapi-util/0.1.8 \
+    crate://crates.io/windows-sys/0.48.0 \
+    crate://crates.io/windows-sys/0.52.0 \
+    crate://crates.io/windows-targets/0.48.5 \
+    crate://crates.io/windows-targets/0.52.6 \
+    crate://crates.io/windows_aarch64_gnullvm/0.48.5 \
+    crate://crates.io/windows_aarch64_gnullvm/0.52.6 \
+    crate://crates.io/windows_aarch64_msvc/0.48.5 \
+    crate://crates.io/windows_aarch64_msvc/0.52.6 \
+    crate://crates.io/windows_i686_gnu/0.48.5 \
+    crate://crates.io/windows_i686_gnu/0.52.6 \
+    crate://crates.io/windows_i686_gnullvm/0.52.6 \
+    crate://crates.io/windows_i686_msvc/0.48.5 \
+    crate://crates.io/windows_i686_msvc/0.52.6 \
+    crate://crates.io/windows_x86_64_gnu/0.48.5 \
+    crate://crates.io/windows_x86_64_gnu/0.52.6 \
+    crate://crates.io/windows_x86_64_gnullvm/0.48.5 \
+    crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
+    crate://crates.io/windows_x86_64_msvc/0.48.5 \
+    crate://crates.io/windows_x86_64_msvc/0.52.6 \
+    crate://crates.io/winnow/0.6.16 \
+    crate://crates.io/wyz/0.5.1 \
 "
 
-SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a"
-SRC_URI[bit-set-0.5.2.sha256sum] = "6e11e16035ea35e4e5997b393eacbf6f63983188f7a2ad25bfb13465f5ad59de"
-SRC_URI[bit-vec-0.6.3.sha256sum] = "349f9b6a179ed607305526ca489b34ad0a41aed5f7980fa90eb03160b69598fb"
-SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
-SRC_URI[byteorder-1.4.3.sha256sum] = "14c189c53d098945499cdfa7ecc63567cf3886b3332b312a5b4585d8d3a6a610"
-SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[doc-comment-0.3.3.sha256sum] = "fea41bba32d969b513997752735605054bc0dfa92b4c56bf1189f2e174be7a10"
-SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
-SRC_URI[getrandom-0.2.3.sha256sum] = "7fcd999463524c52659517fe2cea98493cfe485d10565e7b0fb07dbba7ad2753"
-SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
-SRC_URI[libc-0.2.106.sha256sum] = "a60553f9a9e039a333b4e9b20573b9e9b9c0bb3a11e201ccc48ef4283456d673"
-SRC_URI[memchr-2.4.1.sha256sum] = "308cc39be01b73d0d18f82a0e7b2a3df85245f84af96fdddc5d202d27e47b86a"
+SRC_URI[asn1-rs-derive-0.5.1.sha256sum] = "965c2d33e53cb6b267e148a4cb0760bc01f4904c1cd4bb4002a085bb016d1490"
+SRC_URI[asn1-rs-impl-0.2.0.sha256sum] = "7b18050c2cd6fe86c3a76584ef5e0baf286d038cda203eb6223df2cc413565f7"
+SRC_URI[autocfg-1.3.0.sha256sum] = "0c4b4d0bd25bd0b74681c0ad21497610ce1b7c91b1022cd21c80c6fbdd9476b0"
+SRC_URI[base64-0.22.1.sha256sum] = "72b3254f16251a8381aa12e40e3c4d2f0199f8c6508fbecb9d91f575e0fbb8c6"
+SRC_URI[bitvec-1.0.1.sha256sum] = "1bc2832c24239b0141d5674bb9174f9d68a8b5b3f2753311927c172ca46f7e9c"
+SRC_URI[colored-2.1.0.sha256sum] = "cbf2150cce219b664a8a70df7a1f933836724b503f8a413af9365b4dcc4d90b8"
+SRC_URI[cookie-factory-0.3.3.sha256sum] = "9885fa71e26b8ab7855e2ec7cae6e9b380edff76cd052e07c683a0319d51b3a2"
+SRC_URI[deranged-0.3.11.sha256sum] = "b42b6fa04a440b495c8b04d0e71b707c585f83cb9cb28cf8cd0d976c315e31b4"
+SRC_URI[displaydoc-0.2.5.sha256sum] = "97369cbbc041bc366949bc74d34658d6cda5621039731c6310521892a3a20ae0"
+SRC_URI[equivalent-1.0.1.sha256sum] = "5443807d6dff69373d433ab9ef5378ad8df50ca6298caf15de6e52e24aaf54d5"
+SRC_URI[funty-2.0.0.sha256sum] = "e6d5a32815ae3f33302d95fdcb2ce17862f8c65363dcfd29360480ba1001fc9c"
+SRC_URI[futures-0.3.30.sha256sum] = "645c6916888f6cb6350d2550b80fb63e734897a8498abe35cfb732b6487804b0"
+SRC_URI[futures-channel-0.3.30.sha256sum] = "eac8f7d7865dcb88bd4373ab671c8cf4508703796caa2b1985a9ca867b3fcb78"
+SRC_URI[futures-core-0.3.30.sha256sum] = "dfc6580bb841c5a68e9ef15c77ccc837b40a7504914d52e47b8b0e9bbda25a1d"
+SRC_URI[futures-executor-0.3.30.sha256sum] = "a576fc72ae164fca6b9db127eaa9a9dda0d61316034f33a0a0d4eda41f02b01d"
+SRC_URI[futures-io-0.3.30.sha256sum] = "a44623e20b9681a318efdd71c299b6b222ed6f231972bfe2f224ebad6311f0c1"
+SRC_URI[futures-macro-0.3.30.sha256sum] = "87750cf4b7a4c0625b1529e4c543c2182106e4dedc60a2a6455e00d212c489ac"
+SRC_URI[futures-sink-0.3.30.sha256sum] = "9fb8e00e87438d937621c1c6269e53f536c14d3fbd6a042bb24879e57d474fb5"
+SRC_URI[futures-task-0.3.30.sha256sum] = "38d84fa142264698cdce1a9f9172cf383a0c82de1bddcf3092901442c4097004"
+SRC_URI[futures-util-0.3.30.sha256sum] = "3d6401deb83407ab3da39eba7e33987a73c3df0c82b4bb5813ee871c19c41d48"
+SRC_URI[glob-0.3.1.sha256sum] = "d2fabcfbdc87f4758337ca535fb41a6d701b65693ce38287d856d1674551ec9b"
+SRC_URI[hashbrown-0.14.5.sha256sum] = "e5274423e17b7c9fc20b6e7e208532f9b19825d82dfd615708b70edd83df41f1"
+SRC_URI[hex-literal-0.4.1.sha256sum] = "6fe2267d4ed49bc07b63801559be28c718ea06c4738b7a03c94df7386d2cde46"
+SRC_URI[indexmap-2.2.6.sha256sum] = "168fb715dda47215e360912c096649d23d58bf392ac62f73919e831745e40f26"
+SRC_URI[itoa-1.0.11.sha256sum] = "49f1f14873335454500d59611f1cf4a4b0f786f9ac11f4312a78e4cf2566695b"
+SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
+SRC_URI[memchr-2.7.4.sha256sum] = "78ca9ab1a0babb1e7d5695e3530886289c18cf2f87ec19a575a0abdce112e3a3"
 SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
-SRC_URI[num-traits-0.2.14.sha256sum] = "9a64b1ec5cda2586e284722486d802acf1f7dbdc623e2bfc57e65ca1cd099290"
-SRC_URI[ppv-lite86-0.2.15.sha256sum] = "ed0cfbc8191465bed66e1718596ee0b0b35d5ee1f41c5df2189d0fe8bde535ba"
-SRC_URI[proptest-1.0.0.sha256sum] = "1e0d9cc07f18492d879586c92b485def06bc850da3118075cd45d50e9c95b0e5"
-SRC_URI[quick-error-1.2.3.sha256sum] = "a1d01941d82fa2ab50be1e79e6714289dd7cde78eba4c074bc5a4374f650dfe0"
-SRC_URI[quick-error-2.0.1.sha256sum] = "a993555f31e5a609f617c12db6250dedcac1b0a85076912c436e6fc9b2c8e6a3"
-SRC_URI[rand-0.8.4.sha256sum] = "2e7573632e6454cf6b99d7aac4ccca54be06da05aca2ef7423d22d27d4d4bcd8"
-SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
-SRC_URI[rand_core-0.6.3.sha256sum] = "d34f1408f55294453790c48b2f1ebbb1c5b4b7563eb1f418bcfcfdbb06ebb4e7"
-SRC_URI[rand_hc-0.3.1.sha256sum] = "d51e9f596de227fda2ea6c84607f5558e196eeaf43c986b724ba4fb8fdf497e7"
-SRC_URI[rand_xorshift-0.3.0.sha256sum] = "d25bf25ec5ae4a3f1b92f929810509a2f53d7dca2f50b794ff57e3face536c8f"
-SRC_URI[redox_syscall-0.2.10.sha256sum] = "8383f39639269cde97d255a32bdb68c047337295414940c68bdd30c2e13203ff"
-SRC_URI[regex-syntax-0.6.25.sha256sum] = "f497285884f3fcff424ffc933e56d7cbca511def0c9831a7f9b5f6153e3cc89b"
-SRC_URI[remove_dir_all-0.5.3.sha256sum] = "3acd125665422973a33ac9d3dd2df85edad0f4ae9b00dafb1a05e43a9f5ef8e7"
-SRC_URI[rusty-fork-0.3.0.sha256sum] = "cb3dcc6e454c328bb824492db107ab7c0ae8fcffe4ad210136ef014458c1bc4f"
-SRC_URI[tempfile-3.2.0.sha256sum] = "dac1c663cfc93810f88aed9b8941d48cabf856a1b111c29a40439018d870eb22"
-SRC_URI[wait-timeout-0.2.0.sha256sum] = "9f200f5b12eb75f8c1ed65abd4b2db8a6e1b138a20de009dacee265a2498f3f6"
-SRC_URI[wasi-0.10.2+wasi-snapshot-preview1.sha256sum] = "fd6fbd9a79829dd1ad0cc20627bf1ed606756a7f77edff7b66b7064f9cb327c6"
-SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
-SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
-SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
-# from rust/vendor/nibble_vec/Cargo.lock
+SRC_URI[nom-7.1.3.sha256sum] = "d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
+SRC_URI[num-bigint-0.4.6.sha256sum] = "a5e44f723f1133c9deac646763579fdb3ac745e418f2a7af9cd0c431da1f20b9"
+SRC_URI[num-conv-0.1.0.sha256sum] = "51d515d32fb182ee37cda2ccdcb92950d6a3c2893aa280e540671c2cd0f3b1d9"
+SRC_URI[num-integer-0.1.46.sha256sum] = "7969661fd2958a5cb096e56c8e1ad0444ac2bbcd0061bd28660485a44879858f"
+SRC_URI[num-traits-0.2.19.sha256sum] = "071dfc062690e90b734c0b2273ce72ad0ffa95f0c74596bc250dcfd960262841"
+SRC_URI[pem-3.0.4.sha256sum] = "8e459365e590736a54c3fa561947c84837534b8e9af6fc5bf781307e82658fae"
+SRC_URI[pin-project-lite-0.2.14.sha256sum] = "bda66fc9667c18cb2758a2ac84d1167245054bcf85d5d1aaa6923f45801bdd02"
+SRC_URI[pin-utils-0.1.0.sha256sum] = "8b870d8c151b6f2fb93e84a13146138f05d02ed11c7e7c54f8826aaaf7c9f184"
+SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
+SRC_URI[proc-macro2-1.0.86.sha256sum] = "5e719e8df665df0d1c8fbfd238015744736151d4445ec0836b8e628aae103b77"
+SRC_URI[quote-1.0.36.sha256sum] = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
+SRC_URI[radium-0.7.0.sha256sum] = "dc33ff2d4973d518d823d61aa239014831e521c75da58e3df4840d3f47749d09"
+SRC_URI[rusticata-macros-4.1.0.sha256sum] = "faf0c4a6ece9950b9abdb62b1cfcf2a68b3b67a10ba445b3bb85be2a293d0632"
+SRC_URI[ryu-1.0.18.sha256sum] = "f3cb5ba0dc43242ce17de99c180e96db90b235b8a9fdc9543c96d2209116bd9f"
+SRC_URI[serde-1.0.204.sha256sum] = "bc76f558e0cbb2a839d37354c575f1dc3fdc6546b5be373ba43d95f231bf7c12"
+SRC_URI[serde_derive-1.0.204.sha256sum] = "e0cd7e117be63d3c3678776753929474f3b04a43a080c744d6b0ae2a8c28e222"
+SRC_URI[serde_json-1.0.121.sha256sum] = "4ab380d7d9f22ef3f21ad3e6c1ebe8e4fc7a2000ccba2e4d71fc96f15b2cb609"
+SRC_URI[serde_spanned-0.6.7.sha256sum] = "eb5b1b31579f3811bf615c144393417496f152e12ac8b7663bf664f4a815306d"
+SRC_URI[slab-0.4.9.sha256sum] = "8f92a496fb766b417c996b9c5e57daf2f7ad3b0bebe1ccfca4856390e3d3bb67"
+SRC_URI[syn-2.0.72.sha256sum] = "dc4b9b9bf2add8093d3f2c0204471e951b2285580335de42f9d2534f3ae7a8af"
+SRC_URI[synstructure-0.13.1.sha256sum] = "c8af7666ab7b6390ab78131fb5b0fce11d6b7a6951602017c35fa82800708971"
+SRC_URI[tap-1.0.1.sha256sum] = "55937e1799185b12863d447f42597ed69d9928686b8d88a1df17376a097d8369"
+SRC_URI[termcolor-1.4.1.sha256sum] = "06794f8f6c5c898b3275aebefa6b8a1cb24cd2c6c79397ab15774837a0bc5755"
+SRC_URI[thiserror-1.0.63.sha256sum] = "c0342370b38b6a11b6cc11d6a805569958d54cfa061a29969c3b5ce2ea405724"
+SRC_URI[thiserror-impl-1.0.63.sha256sum] = "a4558b58466b9ad7ca0f102865eccc95938dca1a74a856f2b57b6629050da261"
+SRC_URI[time-0.3.36.sha256sum] = "5dfd88e563464686c916c7e46e623e520ddc6d79fa6641390f2e3fa86e83e885"
+SRC_URI[time-core-0.1.2.sha256sum] = "ef927ca75afb808a4d64dd374f00a2adf8d0fcff8e7b184af886c3c87ec4a3f3"
+SRC_URI[time-macros-0.2.18.sha256sum] = "3f252a68540fde3a3877aeea552b832b40ab9a69e318efd078774a01ddee1ccf"
+SRC_URI[toml-0.8.17.sha256sum] = "7a44eede9b727419af8095cb2d72fab15487a541f54647ad4414b34096ee4631"
+SRC_URI[toml_datetime-0.6.8.sha256sum] = "0dd7358ecb8fc2f8d014bf86f6f638ce72ba252a2c3a2572f2a795f1d23efb41"
+SRC_URI[toml_edit-0.22.18.sha256sum] = "1490595c74d930da779e944f5ba2ecdf538af67df1a9848cbd156af43c1b7cf0"
+SRC_URI[trybuild-1.0.98.sha256sum] = "b55265878356bdd85c9baa15859c87de93b2bf1f33acf752040a561e4a228f62"
+SRC_URI[unicode-ident-1.0.12.sha256sum] = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
+SRC_URI[winapi-util-0.1.8.sha256sum] = "4d4cc384e1e73b93bafa6fb4f1df8c41695c8a91cf9c4c64358067d15a7b6c6b"
+SRC_URI[windows-sys-0.48.0.sha256sum] = "677d2418bec65e3338edb076e806bc1ec15693c5d0104683f2efe857f61056a9"
+SRC_URI[windows-sys-0.52.0.sha256sum] = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
+SRC_URI[windows-targets-0.48.5.sha256sum] = "9a2fa6e2155d7247be68c096456083145c183cbbbc2764150dda45a87197940c"
+SRC_URI[windows-targets-0.52.6.sha256sum] = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
+SRC_URI[windows_aarch64_gnullvm-0.48.5.sha256sum] = "2b38e32f0abccf9987a4e3079dfb67dcd799fb61361e53e2882c3cbaf0d905d8"
+SRC_URI[windows_aarch64_gnullvm-0.52.6.sha256sum] = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
+SRC_URI[windows_aarch64_msvc-0.48.5.sha256sum] = "dc35310971f3b2dbbf3f0690a219f40e2d9afcf64f9ab7cc1be722937c26b4bc"
+SRC_URI[windows_aarch64_msvc-0.52.6.sha256sum] = "09ec2a7bb152e2252b53fa7803150007879548bc709c039df7627cabbd05d469"
+SRC_URI[windows_i686_gnu-0.48.5.sha256sum] = "a75915e7def60c94dcef72200b9a8e58e5091744960da64ec734a6c6e9b3743e"
+SRC_URI[windows_i686_gnu-0.52.6.sha256sum] = "8e9b5ad5ab802e97eb8e295ac6720e509ee4c243f69d781394014ebfe8bbfa0b"
+SRC_URI[windows_i686_gnullvm-0.52.6.sha256sum] = "0eee52d38c090b3caa76c563b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
+SRC_URI[windows_i686_msvc-0.48.5.sha256sum] = "8f55c233f70c4b27f66c523580f78f1004e8b5a8b659e05a4eb49d4166cca406"
+SRC_URI[windows_i686_msvc-0.52.6.sha256sum] = "240948bc05c5e7c6dabba28bf89d89ffce3e303022809e73deaefe4f6ec56c66"
+SRC_URI[windows_x86_64_gnu-0.48.5.sha256sum] = "53d40abd2583d23e4718fddf1ebec84dbff8381c07cae67ff7768bbf19c6718e"
+SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
+SRC_URI[windows_x86_64_gnullvm-0.48.5.sha256sum] = "0b7b52767868a23d5bab768e390dc5f5c55825b6d30b86c844ff2dc7414044cc"
+SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
+SRC_URI[windows_x86_64_msvc-0.48.5.sha256sum] = "ed94fce61571a4006852b7389a063ab983c02eb1bb37b47f8272ce92d06d9538"
+SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
+SRC_URI[winnow-0.6.16.sha256sum] = "b480ae9340fc261e6be3e95a1ba86d54ae3f9171132a73ce8d4bbaf68339507c"
+SRC_URI[wyz-0.5.1.sha256sum] = "05f360fc0b24296329c78fda852a1e9ae82de9cf7b27dae4b7f62f118f77b9ed"
+# from rust/vendor/radix_trie/Cargo.lock
 SRC_URI += " \
+    crate://crates.io/aho-corasick/0.5.3 \
     crate://crates.io/atty/0.2.14 \
-    crate://crates.io/autocfg/1.0.0 \
+    crate://crates.io/autocfg/1.0.1 \
     crate://crates.io/bitflags/1.2.1 \
-    crate://crates.io/bstr/0.2.13 \
+    crate://crates.io/bstr/0.2.14 \
     crate://crates.io/bumpalo/3.4.0 \
     crate://crates.io/byteorder/1.3.4 \
     crate://crates.io/cast/0.2.3 \
     crate://crates.io/cfg-if/0.1.10 \
-    crate://crates.io/clap/2.33.1 \
-    crate://crates.io/criterion/0.3.2 \
-    crate://crates.io/criterion-plot/0.4.2 \
-    crate://crates.io/crossbeam-deque/0.7.3 \
-    crate://crates.io/crossbeam-epoch/0.8.2 \
-    crate://crates.io/crossbeam-queue/0.2.3 \
-    crate://crates.io/crossbeam-utils/0.7.2 \
+    crate://crates.io/cfg-if/1.0.0 \
+    crate://crates.io/clap/2.33.3 \
+    crate://crates.io/const_fn/0.4.2 \
+    crate://crates.io/criterion/0.3.3 \
+    crate://crates.io/criterion-plot/0.4.3 \
+    crate://crates.io/crossbeam-channel/0.5.0 \
+    crate://crates.io/crossbeam-deque/0.8.0 \
+    crate://crates.io/crossbeam-epoch/0.9.0 \
+    crate://crates.io/crossbeam-utils/0.8.0 \
     crate://crates.io/csv/1.1.3 \
     crate://crates.io/csv-core/0.1.10 \
-    crate://crates.io/either/1.5.3 \
-    crate://crates.io/hermit-abi/0.1.14 \
+    crate://crates.io/either/1.6.1 \
+    crate://crates.io/endian-type/0.1.2 \
+    crate://crates.io/env_logger/0.3.5 \
+    crate://crates.io/fuchsia-cprng/0.1.1 \
+    crate://crates.io/half/1.6.0 \
+    crate://crates.io/hermit-abi/0.1.17 \
     crate://crates.io/itertools/0.9.0 \
     crate://crates.io/itoa/0.4.6 \
-    crate://crates.io/js-sys/0.3.40 \
+    crate://crates.io/js-sys/0.3.45 \
+    crate://crates.io/kernel32-sys/0.2.2 \
     crate://crates.io/lazy_static/1.4.0 \
-    crate://crates.io/libc/0.2.71 \
-    crate://crates.io/log/0.4.8 \
-    crate://crates.io/maybe-uninit/2.0.0 \
+    crate://crates.io/libc/0.2.79 \
+    crate://crates.io/log/0.3.9 \
+    crate://crates.io/log/0.4.11 \
+    crate://crates.io/memchr/0.1.11 \
     crate://crates.io/memchr/2.3.3 \
-    crate://crates.io/memoffset/0.5.4 \
+    crate://crates.io/memoffset/0.5.6 \
+    crate://crates.io/nibble_vec/0.1.0 \
     crate://crates.io/num-traits/0.2.12 \
     crate://crates.io/num_cpus/1.13.0 \
     crate://crates.io/oorandom/11.1.2 \
     crate://crates.io/plotters/0.2.15 \
-    crate://crates.io/proc-macro2/1.0.18 \
+    crate://crates.io/proc-macro2/1.0.24 \
+    crate://crates.io/quickcheck/0.4.1 \
     crate://crates.io/quote/1.0.7 \
-    crate://crates.io/rayon/1.3.1 \
-    crate://crates.io/rayon-core/1.7.1 \
-    crate://crates.io/regex/1.3.9 \
+    crate://crates.io/rand/0.3.23 \
+    crate://crates.io/rand/0.4.6 \
+    crate://crates.io/rand_core/0.3.1 \
+    crate://crates.io/rand_core/0.4.2 \
+    crate://crates.io/rayon/1.5.0 \
+    crate://crates.io/rayon-core/1.9.0 \
+    crate://crates.io/rdrand/0.4.0 \
+    crate://crates.io/regex/0.1.80 \
+    crate://crates.io/regex/1.4.1 \
     crate://crates.io/regex-automata/0.1.9 \
-    crate://crates.io/regex-syntax/0.6.18 \
+    crate://crates.io/regex-syntax/0.3.9 \
+    crate://crates.io/regex-syntax/0.6.20 \
     crate://crates.io/rustc_version/0.2.3 \
     crate://crates.io/ryu/1.0.5 \
     crate://crates.io/same-file/1.0.6 \
     crate://crates.io/scopeguard/1.1.0 \
     crate://crates.io/semver/0.9.0 \
     crate://crates.io/semver-parser/0.7.0 \
-    crate://crates.io/serde/1.0.114 \
-    crate://crates.io/serde_derive/1.0.114 \
-    crate://crates.io/serde_json/1.0.55 \
-    crate://crates.io/smallvec/1.4.0 \
-    crate://crates.io/syn/1.0.33 \
+    crate://crates.io/serde/1.0.117 \
+    crate://crates.io/serde_cbor/0.11.1 \
+    crate://crates.io/serde_derive/1.0.117 \
+    crate://crates.io/serde_json/1.0.59 \
+    crate://crates.io/serde_test/1.0.117 \
+    crate://crates.io/smallvec/1.4.2 \
+    crate://crates.io/syn/1.0.46 \
     crate://crates.io/textwrap/0.11.0 \
+    crate://crates.io/thread-id/2.0.0 \
+    crate://crates.io/thread_local/0.2.7 \
     crate://crates.io/tinytemplate/1.1.0 \
-    crate://crates.io/unicode-width/0.1.7 \
+    crate://crates.io/unicode-width/0.1.8 \
     crate://crates.io/unicode-xid/0.2.1 \
+    crate://crates.io/utf8-ranges/0.1.3 \
     crate://crates.io/walkdir/2.3.1 \
-    crate://crates.io/wasm-bindgen/0.2.63 \
-    crate://crates.io/wasm-bindgen-backend/0.2.63 \
-    crate://crates.io/wasm-bindgen-macro/0.2.63 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.63 \
-    crate://crates.io/wasm-bindgen-shared/0.2.63 \
-    crate://crates.io/web-sys/0.3.40 \
+    crate://crates.io/wasm-bindgen/0.2.68 \
+    crate://crates.io/wasm-bindgen-backend/0.2.68 \
+    crate://crates.io/wasm-bindgen-macro/0.2.68 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.68 \
+    crate://crates.io/wasm-bindgen-shared/0.2.68 \
+    crate://crates.io/web-sys/0.3.45 \
+    crate://crates.io/winapi/0.2.8 \
+    crate://crates.io/winapi/0.3.9 \
+    crate://crates.io/winapi-build/0.1.1 \
+    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
+    crate://crates.io/winapi-util/0.1.5 \
+    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+"
+
+# from rust/vendor/alloc-stdlib/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/alloc-no-stdlib/2.0.4 \
+"
+
+SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
+# from rust/vendor/nom/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/autocfg/1.0.1 \
+    crate://crates.io/bit-set/0.5.2 \
+    crate://crates.io/bit-vec/0.6.3 \
+    crate://crates.io/bitflags/1.3.2 \
+    crate://crates.io/byteorder/1.4.3 \
+    crate://crates.io/cfg-if/1.0.0 \
+    crate://crates.io/doc-comment/0.3.3 \
+    crate://crates.io/fnv/1.0.7 \
+    crate://crates.io/getrandom/0.2.3 \
+    crate://crates.io/lazy_static/1.4.0 \
+    crate://crates.io/libc/0.2.106 \
+    crate://crates.io/memchr/2.4.1 \
+    crate://crates.io/minimal-lexical/0.2.1 \
+    crate://crates.io/num-traits/0.2.14 \
+    crate://crates.io/ppv-lite86/0.2.15 \
+    crate://crates.io/proptest/1.0.0 \
+    crate://crates.io/quick-error/1.2.3 \
+    crate://crates.io/quick-error/2.0.1 \
+    crate://crates.io/rand/0.8.4 \
+    crate://crates.io/rand_chacha/0.3.1 \
+    crate://crates.io/rand_core/0.6.3 \
+    crate://crates.io/rand_hc/0.3.1 \
+    crate://crates.io/rand_xorshift/0.3.0 \
+    crate://crates.io/redox_syscall/0.2.10 \
+    crate://crates.io/regex-syntax/0.6.25 \
+    crate://crates.io/remove_dir_all/0.5.3 \
+    crate://crates.io/rusty-fork/0.3.0 \
+    crate://crates.io/tempfile/3.2.0 \
+    crate://crates.io/wait-timeout/0.2.0 \
+    crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
     crate://crates.io/winapi/0.3.9 \
     crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-    crate://crates.io/winapi-util/0.1.5 \
     crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
 "
 
-# from rust/vendor/once_cell/Cargo.lock
+SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a"
+SRC_URI[bit-set-0.5.2.sha256sum] = "6e11e16035ea35e4e5997b393eacbf6f63983188f7a2ad25bfb13465f5ad59de"
+SRC_URI[bit-vec-0.6.3.sha256sum] = "349f9b6a179ed607305526ca489b34ad0a41aed5f7980fa90eb03160b69598fb"
+SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
+SRC_URI[byteorder-1.4.3.sha256sum] = "14c189c53d098945499cdfa7ecc63567cf3886b3332b312a5b4585d8d3a6a610"
+SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+SRC_URI[doc-comment-0.3.3.sha256sum] = "fea41bba32d969b513997752735605054bc0dfa92b4c56bf1189f2e174be7a10"
+SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
+SRC_URI[getrandom-0.2.3.sha256sum] = "7fcd999463524c52659517fe2cea98493cfe485d10565e7b0fb07dbba7ad2753"
+SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
+SRC_URI[libc-0.2.106.sha256sum] = "a60553f9a9e039a333b4e9b20573b9e9b9c0bb3a11e201ccc48ef4283456d673"
+SRC_URI[memchr-2.4.1.sha256sum] = "308cc39be01b73d0d18f82a0e7b2a3df85245f84af96fdddc5d202d27e47b86a"
+SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
+SRC_URI[num-traits-0.2.14.sha256sum] = "9a64b1ec5cda2586e284722486d802acf1f7dbdc623e2bfc57e65ca1cd099290"
+SRC_URI[ppv-lite86-0.2.15.sha256sum] = "ed0cfbc8191465bed66e1718596ee0b0b35d5ee1f41c5df2189d0fe8bde535ba"
+SRC_URI[proptest-1.0.0.sha256sum] = "1e0d9cc07f18492d879586c92b485def06bc850da3118075cd45d50e9c95b0e5"
+SRC_URI[quick-error-1.2.3.sha256sum] = "a1d01941d82fa2ab50be1e79e6714289dd7cde78eba4c074bc5a4374f650dfe0"
+SRC_URI[quick-error-2.0.1.sha256sum] = "a993555f31e5a609f617c12db6250dedcac1b0a85076912c436e6fc9b2c8e6a3"
+SRC_URI[rand-0.8.4.sha256sum] = "2e7573632e6454cf6b99d7aac4ccca54be06da05aca2ef7423d22d27d4d4bcd8"
+SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
+SRC_URI[rand_core-0.6.3.sha256sum] = "d34f1408f55294453790c48b2f1ebbb1c5b4b7563eb1f418bcfcfdbb06ebb4e7"
+SRC_URI[rand_hc-0.3.1.sha256sum] = "d51e9f596de227fda2ea6c84607f5558e196eeaf43c986b724ba4fb8fdf497e7"
+SRC_URI[rand_xorshift-0.3.0.sha256sum] = "d25bf25ec5ae4a3f1b92f929810509a2f53d7dca2f50b794ff57e3face536c8f"
+SRC_URI[redox_syscall-0.2.10.sha256sum] = "8383f39639269cde97d255a32bdb68c047337295414940c68bdd30c2e13203ff"
+SRC_URI[regex-syntax-0.6.25.sha256sum] = "f497285884f3fcff424ffc933e56d7cbca511def0c9831a7f9b5f6153e3cc89b"
+SRC_URI[remove_dir_all-0.5.3.sha256sum] = "3acd125665422973a33ac9d3dd2df85edad0f4ae9b00dafb1a05e43a9f5ef8e7"
+SRC_URI[rusty-fork-0.3.0.sha256sum] = "cb3dcc6e454c328bb824492db107ab7c0ae8fcffe4ad210136ef014458c1bc4f"
+SRC_URI[tempfile-3.2.0.sha256sum] = "dac1c663cfc93810f88aed9b8941d48cabf856a1b111c29a40439018d870eb22"
+SRC_URI[wait-timeout-0.2.0.sha256sum] = "9f200f5b12eb75f8c1ed65abd4b2db8a6e1b138a20de009dacee265a2498f3f6"
+SRC_URI[wasi-0.10.2+wasi-snapshot-preview1.sha256sum] = "fd6fbd9a79829dd1ad0cc20627bf1ed606756a7f77edff7b66b7064f9cb327c6"
+SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
+SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
+SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
+# from rust/vendor/ryu/Cargo.lock
 SRC_URI += " \
-    crate://crates.io/aho-corasick/1.1.3 \
-    crate://crates.io/bitflags/2.6.0 \
+    crate://crates.io/bitflags/2.9.0 \
+    crate://crates.io/byteorder/1.5.0 \
     crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/critical-section/1.1.3 \
-    crate://crates.io/libc/0.2.158 \
-    crate://crates.io/memchr/2.7.4 \
-    crate://crates.io/parking_lot_core/0.9.10 \
-    crate://crates.io/portable-atomic/1.9.0 \
-    crate://crates.io/redox_syscall/0.5.4 \
-    crate://crates.io/regex/1.10.6 \
-    crate://crates.io/regex-automata/0.4.7 \
-    crate://crates.io/regex-syntax/0.8.4 \
-    crate://crates.io/smallvec/1.13.2 \
+    crate://crates.io/getrandom/0.3.1 \
+    crate://crates.io/hermit-abi/0.3.9 \
+    crate://crates.io/libc/0.2.170 \
+    crate://crates.io/no-panic/0.1.34 \
+    crate://crates.io/num_cpus/1.16.0 \
+    crate://crates.io/ppv-lite86/0.2.20 \
+    crate://crates.io/proc-macro2/1.0.94 \
+    crate://crates.io/quote/1.0.39 \
+    crate://crates.io/rand/0.9.0 \
+    crate://crates.io/rand_chacha/0.9.0 \
+    crate://crates.io/rand_core/0.9.3 \
+    crate://crates.io/rand_xorshift/0.4.0 \
+    crate://crates.io/syn/2.0.99 \
+    crate://crates.io/unicode-ident/1.0.17 \
+    crate://crates.io/wasi/0.13.3+wasi-0.2.2 \
     crate://crates.io/windows-targets/0.52.6 \
     crate://crates.io/windows_aarch64_gnullvm/0.52.6 \
     crate://crates.io/windows_aarch64_msvc/0.52.6 \
@@ -1165,21 +1508,31 @@ SRC_URI += " \
     crate://crates.io/windows_x86_64_gnu/0.52.6 \
     crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
     crate://crates.io/windows_x86_64_msvc/0.52.6 \
+    crate://crates.io/wit-bindgen-rt/0.33.0 \
+    crate://crates.io/zerocopy/0.7.35 \
+    crate://crates.io/zerocopy/0.8.21 \
+    crate://crates.io/zerocopy-derive/0.7.35 \
+    crate://crates.io/zerocopy-derive/0.8.21 \
 "
 
-SRC_URI[aho-corasick-1.1.3.sha256sum] = "8e60d3430d3a69478ad0993f19238d2df97c507009a52b3c10addcd7f6bcb916"
-SRC_URI[bitflags-2.6.0.sha256sum] = "b048fb63fd8b5923fc5aa7b340d8e156aec7ec02f0c78fa8a6ddc2613f6f71de"
+SRC_URI[bitflags-2.9.0.sha256sum] = "5c8214115b7bf84099f1309324e63141d4c5d7cc26862f97a0a857dbefe165bd"
+SRC_URI[byteorder-1.5.0.sha256sum] = "1fd0f2584146f6f2ef48085050886acf353beff7305ebd1ae69500e27c67f64b"
 SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[critical-section-1.1.3.sha256sum] = "f64009896348fc5af4222e9cf7d7d82a95a256c634ebcf61c53e4ea461422242"
-SRC_URI[libc-0.2.158.sha256sum] = "d8adc4bb1803a324070e64a98ae98f38934d91957a99cfb3a43dcbc01bc56439"
-SRC_URI[memchr-2.7.4.sha256sum] = "78ca9ab1a0babb1e7d5695e3530886289c18cf2f87ec19a575a0abdce112e3a3"
-SRC_URI[parking_lot_core-0.9.10.sha256sum] = "1e401f977ab385c9e4e3ab30627d6f26d00e2c73eef317493c4ec6d468726cf8"
-SRC_URI[portable-atomic-1.9.0.sha256sum] = "cc9c68a3f6da06753e9335d63e27f6b9754dd1920d941135b7ea8224f141adb2"
-SRC_URI[redox_syscall-0.5.4.sha256sum] = "0884ad60e090bf1345b93da0a5de8923c93884cd03f40dfcfddd3b4bee661853"
-SRC_URI[regex-1.10.6.sha256sum] = "4219d74c6b67a3654a9fbebc4b419e22126d13d2f3c4a07ee0cb61ff79a79619"
-SRC_URI[regex-automata-0.4.7.sha256sum] = "38caf58cc5ef2fed281f89292ef23f6365465ed9a41b7a7754eb4e26496c92df"
-SRC_URI[regex-syntax-0.8.4.sha256sum] = "7a66a03ae7c801facd77a29370b4faec201768915ac14a721ba36f20bc9c209b"
-SRC_URI[smallvec-1.13.2.sha256sum] = "3c5e1a9a646d36c3599cd173a41282daf47c44583ad367b8e6837255952e5c67"
+SRC_URI[getrandom-0.3.1.sha256sum] = "43a49c392881ce6d5c3b8cb70f98717b7c07aabbdff06687b9030dbfbe2725f8"
+SRC_URI[hermit-abi-0.3.9.sha256sum] = "d231dfb89cfffdbc30e7fc41579ed6066ad03abda9e567ccafae602b97ec5024"
+SRC_URI[libc-0.2.170.sha256sum] = "875b3680cb2f8f71bdcf9a30f38d48282f5d3c95cbf9b3fa57269bb5d5c06828"
+SRC_URI[no-panic-0.1.34.sha256sum] = "e5b926eaa50591fb2d593d569431833cf8fb4457754a576f47f0d0afe1be73a3"
+SRC_URI[num_cpus-1.16.0.sha256sum] = "4161fcb6d602d4d2081af7c3a45852d875a03dd337a6bfdd6e06407b61342a43"
+SRC_URI[ppv-lite86-0.2.20.sha256sum] = "77957b295656769bb8ad2b6a6b09d897d94f05c41b069aede1fcdaa675eaea04"
+SRC_URI[proc-macro2-1.0.94.sha256sum] = "a31971752e70b8b2686d7e46ec17fb38dad4051d94024c88df49b667caea9c84"
+SRC_URI[quote-1.0.39.sha256sum] = "c1f1914ce909e1658d9907913b4b91947430c7d9be598b15a1912935b8c04801"
+SRC_URI[rand-0.9.0.sha256sum] = "3779b94aeb87e8bd4e834cee3650289ee9e0d5677f976ecdb6d219e5f4f6cd94"
+SRC_URI[rand_chacha-0.9.0.sha256sum] = "d3022b5f1df60f26e1ffddd6c66e8aa15de382ae63b3a0c1bfc0e4d3e3f325cb"
+SRC_URI[rand_core-0.9.3.sha256sum] = "99d9a13982dcf210057a8a78572b2217b667c3beacbf3a0d8b454f6f82837d38"
+SRC_URI[rand_xorshift-0.4.0.sha256sum] = "513962919efc330f829edb2535844d1b912b0fbe2ca165d613e4e8788bb05a5a"
+SRC_URI[syn-2.0.99.sha256sum] = "e02e925281e18ffd9d640e234264753c43edc62d64b2d4cf898f1bc5e75f3fc2"
+SRC_URI[unicode-ident-1.0.17.sha256sum] = "00e2473a93778eb0bad35909dff6a10d28e63f792f16ed15e404fca9d5eeedbe"
+SRC_URI[wasi-0.13.3+wasi-0.2.2.sha256sum] = "26816d2e1a4a36a2940b96c5296ce403917633dff8f3440e9b236ed6f6bacad2"
 SRC_URI[windows-targets-0.52.6.sha256sum] = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
 SRC_URI[windows_aarch64_gnullvm-0.52.6.sha256sum] = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
 SRC_URI[windows_aarch64_msvc-0.52.6.sha256sum] = "09ec2a7bb152e2252b53fa7803150007879548bc709c039df7627cabbd05d469"
@@ -1189,226 +1542,125 @@ SRC_URI[windows_i686_msvc-0.52.6.sha256sum] = "240948bc05c5e7c6dabba28bf89d89ffc
 SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
 SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
 SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
-# from rust/vendor/brotli-decompressor/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/alloc-no-stdlib/2.0.4 \
-    crate://crates.io/alloc-stdlib/0.2.2 \
-"
-
-SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
-SRC_URI[alloc-stdlib-0.2.2.sha256sum] = "94fb8275041c72129eb51b7d0322c29b8387a0386127718b096429201a5d6ece"
-# from rust/vendor/displaydoc/Cargo.lock
+SRC_URI[wit-bindgen-rt-0.33.0.sha256sum] = "3268f3d866458b787f390cf61f4bbb563b922d091359f9608842999eaee3943c"
+SRC_URI[zerocopy-0.7.35.sha256sum] = "1b9b4fd18abc82b8136838da5d50bae7bdea537c574d8dc1a34ed098d6c166f0"
+SRC_URI[zerocopy-0.8.21.sha256sum] = "dcf01143b2dd5d134f11f545cf9f1431b13b749695cb33bcce051e7568f99478"
+SRC_URI[zerocopy-derive-0.7.35.sha256sum] = "fa4f8080344d4671fb4e831a13ad1e68092748387dfc4f55e356242fae12ce3e"
+SRC_URI[zerocopy-derive-0.8.21.sha256sum] = "712c8386f4f4299382c9abee219bee7084f78fb939d88b6840fcc1320d5f6da2"
+# from rust/vendor/flate2/Cargo.lock
 SRC_URI += " \
-    crate://crates.io/ansi_term/0.11.0 \
-    crate://crates.io/ctor/0.1.26 \
-    crate://crates.io/difference/2.0.0 \
-    crate://crates.io/equivalent/1.0.1 \
-    crate://crates.io/glob/0.3.1 \
-    crate://crates.io/hashbrown/0.14.5 \
-    crate://crates.io/indexmap/2.2.6 \
-    crate://crates.io/itoa/1.0.11 \
-    crate://crates.io/libc/0.2.155 \
-    crate://crates.io/memchr/2.7.4 \
-    crate://crates.io/output_vt100/0.1.3 \
-    crate://crates.io/pretty_assertions/0.6.1 \
-    crate://crates.io/proc-macro2/1.0.85 \
-    crate://crates.io/quote/1.0.36 \
-    crate://crates.io/rustversion/1.0.17 \
-    crate://crates.io/ryu/1.0.18 \
-    crate://crates.io/serde/1.0.203 \
-    crate://crates.io/serde_derive/1.0.203 \
-    crate://crates.io/serde_json/1.0.117 \
-    crate://crates.io/serde_spanned/0.6.6 \
-    crate://crates.io/static_assertions/1.1.0 \
-    crate://crates.io/syn/1.0.109 \
-    crate://crates.io/syn/2.0.66 \
-    crate://crates.io/termcolor/1.4.1 \
-    crate://crates.io/thiserror/1.0.61 \
-    crate://crates.io/thiserror-impl/1.0.61 \
-    crate://crates.io/toml/0.8.14 \
-    crate://crates.io/toml_datetime/0.6.6 \
-    crate://crates.io/toml_edit/0.22.14 \
-    crate://crates.io/trybuild/1.0.96 \
-    crate://crates.io/unicode-ident/1.0.12 \
-    crate://crates.io/winapi/0.3.9 \
-    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-    crate://crates.io/winapi-util/0.1.8 \
-    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
-    crate://crates.io/windows-sys/0.52.0 \
-    crate://crates.io/windows-targets/0.52.5 \
-    crate://crates.io/windows_aarch64_gnullvm/0.52.5 \
-    crate://crates.io/windows_aarch64_msvc/0.52.5 \
-    crate://crates.io/windows_i686_gnu/0.52.5 \
-    crate://crates.io/windows_i686_gnullvm/0.52.5 \
-    crate://crates.io/windows_i686_msvc/0.52.5 \
-    crate://crates.io/windows_x86_64_gnu/0.52.5 \
-    crate://crates.io/windows_x86_64_gnullvm/0.52.5 \
-    crate://crates.io/windows_x86_64_msvc/0.52.5 \
-    crate://crates.io/winnow/0.6.13 \
+    crate://crates.io/adler2/2.0.0 \
+    crate://crates.io/cc/1.1.14 \
+    crate://crates.io/cfg-if/1.0.0 \
+    crate://crates.io/cloudflare-zlib-sys/0.3.3 \
+    crate://crates.io/cmake/0.1.50 \
+    crate://crates.io/crc32fast/1.4.0 \
+    crate://crates.io/getrandom/0.2.12 \
+    crate://crates.io/libc/0.2.153 \
+    crate://crates.io/libz-ng-sys/1.1.16 \
+    crate://crates.io/libz-rs-sys/0.4.0 \
+    crate://crates.io/libz-sys/1.1.20 \
+    crate://crates.io/miniz_oxide/0.8.0 \
+    crate://crates.io/pkg-config/0.3.30 \
+    crate://crates.io/ppv-lite86/0.2.17 \
+    crate://crates.io/quickcheck/1.0.3 \
+    crate://crates.io/rand/0.8.5 \
+    crate://crates.io/rand_chacha/0.3.1 \
+    crate://crates.io/rand_core/0.6.4 \
+    crate://crates.io/shlex/1.3.0 \
+    crate://crates.io/vcpkg/0.2.15 \
+    crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
+    crate://crates.io/zlib-rs/0.4.0 \
 "
 
-SRC_URI[ansi_term-0.11.0.sha256sum] = "ee49baf6cb617b853aa8d93bf420db2383fab46d314482ca2803b40d5fde979b"
-SRC_URI[ctor-0.1.26.sha256sum] = "6d2301688392eb071b0bf1a37be05c469d3cc4dbbd95df672fe28ab021e6a096"
-SRC_URI[difference-2.0.0.sha256sum] = "524cbf6897b527295dff137cec09ecf3a05f4fddffd7dfcd1585403449e74198"
-SRC_URI[equivalent-1.0.1.sha256sum] = "5443807d6dff69373d433ab9ef5378ad8df50ca6298caf15de6e52e24aaf54d5"
-SRC_URI[glob-0.3.1.sha256sum] = "d2fabcfbdc87f4758337ca535fb41a6d701b65693ce38287d856d1674551ec9b"
-SRC_URI[hashbrown-0.14.5.sha256sum] = "e5274423e17b7c9fc20b6e7e208532f9b19825d82dfd615708b70edd83df41f1"
-SRC_URI[indexmap-2.2.6.sha256sum] = "168fb715dda47215e360912c096649d23d58bf392ac62f73919e831745e40f26"
-SRC_URI[itoa-1.0.11.sha256sum] = "49f1f14873335454500d59611f1cf4a4b0f786f9ac11f4312a78e4cf2566695b"
-SRC_URI[libc-0.2.155.sha256sum] = "97b3888a4aecf77e811145cadf6eef5901f4782c53886191b2f693f24761847c"
-SRC_URI[memchr-2.7.4.sha256sum] = "78ca9ab1a0babb1e7d5695e3530886289c18cf2f87ec19a575a0abdce112e3a3"
-SRC_URI[output_vt100-0.1.3.sha256sum] = "628223faebab4e3e40667ee0b2336d34a5b960ff60ea743ddfdbcf7770bcfb66"
-SRC_URI[pretty_assertions-0.6.1.sha256sum] = "3f81e1644e1b54f5a68959a29aa86cde704219254669da328ecfdf6a1f09d427"
-SRC_URI[proc-macro2-1.0.85.sha256sum] = "22244ce15aa966053a896d1accb3a6e68469b97c7f33f284b99f0d576879fc23"
-SRC_URI[quote-1.0.36.sha256sum] = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
-SRC_URI[rustversion-1.0.17.sha256sum] = "955d28af4278de8121b7ebeb796b6a45735dc01436d898801014aced2773a3d6"
-SRC_URI[ryu-1.0.18.sha256sum] = "f3cb5ba0dc43242ce17de99c180e96db90b235b8a9fdc9543c96d2209116bd9f"
-SRC_URI[serde-1.0.203.sha256sum] = "7253ab4de971e72fb7be983802300c30b5a7f0c2e56fab8abfc6a214307c0094"
-SRC_URI[serde_derive-1.0.203.sha256sum] = "500cbc0ebeb6f46627f50f3f5811ccf6bf00643be300b4c3eabc0ef55dc5b5ba"
-SRC_URI[serde_json-1.0.117.sha256sum] = "455182ea6142b14f93f4bc5320a2b31c1f266b66a4a5c858b013302a5d8cbfc3"
-SRC_URI[serde_spanned-0.6.6.sha256sum] = "79e674e01f999af37c49f70a6ede167a8a60b2503e56c5599532a65baa5969a0"
-SRC_URI[static_assertions-1.1.0.sha256sum] = "a2eb9349b6444b326872e140eb1cf5e7c522154d69e7a0ffb0fb81c06b37543f"
-SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
-SRC_URI[syn-2.0.66.sha256sum] = "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5"
-SRC_URI[termcolor-1.4.1.sha256sum] = "06794f8f6c5c898b3275aebefa6b8a1cb24cd2c6c79397ab15774837a0bc5755"
-SRC_URI[thiserror-1.0.61.sha256sum] = "c546c80d6be4bc6a00c0f01730c08df82eaa7a7a61f11d656526506112cc1709"
-SRC_URI[thiserror-impl-1.0.61.sha256sum] = "46c3384250002a6d5af4d114f2845d37b57521033f30d5c3f46c4d70e1197533"
-SRC_URI[toml-0.8.14.sha256sum] = "6f49eb2ab21d2f26bd6db7bf383edc527a7ebaee412d17af4d40fdccd442f335"
-SRC_URI[toml_datetime-0.6.6.sha256sum] = "4badfd56924ae69bcc9039335b2e017639ce3f9b001c393c1b2d1ef846ce2cbf"
-SRC_URI[toml_edit-0.22.14.sha256sum] = "f21c7aaf97f1bd9ca9d4f9e73b0a6c74bd5afef56f2bc931943a6e1c37e04e38"
-SRC_URI[trybuild-1.0.96.sha256sum] = "33a5f13f11071020bb12de7a16b925d2d58636175c20c11dc5f96cb64bb6c9b3"
-SRC_URI[unicode-ident-1.0.12.sha256sum] = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
-SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
-SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
-SRC_URI[winapi-util-0.1.8.sha256sum] = "4d4cc384e1e73b93bafa6fb4f1df8c41695c8a91cf9c4c64358067d15a7b6c6b"
-SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
-SRC_URI[windows-sys-0.52.0.sha256sum] = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
-SRC_URI[windows-targets-0.52.5.sha256sum] = "6f0713a46559409d202e70e28227288446bf7841d3211583a4b53e3f6d96e7eb"
-SRC_URI[windows_aarch64_gnullvm-0.52.5.sha256sum] = "7088eed71e8b8dda258ecc8bac5fb1153c5cffaf2578fc8ff5d61e23578d3263"
-SRC_URI[windows_aarch64_msvc-0.52.5.sha256sum] = "9985fd1504e250c615ca5f281c3f7a6da76213ebd5ccc9561496568a2752afb6"
-SRC_URI[windows_i686_gnu-0.52.5.sha256sum] = "88ba073cf16d5372720ec942a8ccbf61626074c6d4dd2e745299726ce8b89670"
-SRC_URI[windows_i686_gnullvm-0.52.5.sha256sum] = "87f4261229030a858f36b459e748ae97545d6f1ec60e5e0d6a3d32e0dc232ee9"
-SRC_URI[windows_i686_msvc-0.52.5.sha256sum] = "db3c2bf3d13d5b658be73463284eaf12830ac9a26a90c717b7f771dfe97487bf"
-SRC_URI[windows_x86_64_gnu-0.52.5.sha256sum] = "4e4246f76bdeff09eb48875a0fd3e2af6aada79d409d33011886d3e1581517d9"
-SRC_URI[windows_x86_64_gnullvm-0.52.5.sha256sum] = "852298e482cd67c356ddd9570386e2862b5673c85bd5f88df9ab6802b334c596"
-SRC_URI[windows_x86_64_msvc-0.52.5.sha256sum] = "bec47e5bfd1bff0eeaf6d8b485cc1074891a197ab4225d504cb7a1ab88b02bf0"
-SRC_URI[winnow-0.6.13.sha256sum] = "59b5e5f6c299a3c7890b876a2a587f3115162487e704907d9b6cd29473052ba1"
-# from rust/vendor/nu-ansi-term/Cargo.lock
+SRC_URI[adler2-2.0.0.sha256sum] = "512761e0bb2578dd7380c6baaa0f4ce03e84f95e960231d1dec8bf4d7d6e2627"
+SRC_URI[cc-1.1.14.sha256sum] = "50d2eb3cd3d1bf4529e31c215ee6f93ec5a3d536d9f578f93d9d33ee19562932"
+SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+SRC_URI[cloudflare-zlib-sys-0.3.3.sha256sum] = "c3185ff8c69c53ab346d5ac89f418e194b997d48393cae321cb611dd05f83c90"
+SRC_URI[cmake-0.1.50.sha256sum] = "a31c789563b815f77f4250caee12365734369f942439b7defd71e18a48197130"
+SRC_URI[crc32fast-1.4.0.sha256sum] = "b3855a8a784b474f333699ef2bbca9db2c4a1f6d9088a90a2d25b1eb53111eaa"
+SRC_URI[getrandom-0.2.12.sha256sum] = "190092ea657667030ac6a35e305e62fc4dd69fd98ac98631e5d3a2b1575a12b5"
+SRC_URI[libc-0.2.153.sha256sum] = "9c198f91728a82281a64e1f4f9eeb25d82cb32a5de251c6bd1b5154d63a8e7bd"
+SRC_URI[libz-ng-sys-1.1.16.sha256sum] = "4436751a01da56f1277f323c80d584ffad94a3d14aecd959dd0dff75aa73a438"
+SRC_URI[libz-rs-sys-0.4.0.sha256sum] = "39cc71ac688c22a9f5730a38171ac94795c071ac81d1a0ab5537f6ef164fff30"
+SRC_URI[libz-sys-1.1.20.sha256sum] = "d2d16453e800a8cf6dd2fc3eb4bc99b786a9b90c663b8559a5b1a041bf89e472"
+SRC_URI[miniz_oxide-0.8.0.sha256sum] = "e2d80299ef12ff69b16a84bb182e3b9df68b5a91574d3d4fa6e41b65deec4df1"
+SRC_URI[pkg-config-0.3.30.sha256sum] = "d231b230927b5e4ad203db57bbcbee2802f6bce620b1e4a9024a07d94e2907ec"
+SRC_URI[ppv-lite86-0.2.17.sha256sum] = "5b40af805b3121feab8a3c29f04d8ad262fa8e0561883e7653e024ae4479e6de"
+SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
+SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
+SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
+SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
+SRC_URI[shlex-1.3.0.sha256sum] = "0fda2ff0d084019ba4d7c6f371c95d8fd75ce3524c3cb8fb653a3023f6323e64"
+SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
+SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
+SRC_URI[zlib-rs-0.4.0.sha256sum] = "2ca4a9dc6566c9224cc161dedc5577bd81f4a9ee0f9fbe80592756d096b07ee5"
+# from rust/vendor/regex/Cargo.lock
 SRC_URI += " \
-    crate://crates.io/doc-comment/0.3.3 \
-    crate://crates.io/itoa/1.0.11 \
-    crate://crates.io/proc-macro2/1.0.86 \
-    crate://crates.io/quote/1.0.36 \
-    crate://crates.io/ryu/1.0.18 \
-    crate://crates.io/serde/1.0.204 \
-    crate://crates.io/serde_derive/1.0.204 \
-    crate://crates.io/serde_json/1.0.120 \
-    crate://crates.io/syn/2.0.72 \
-    crate://crates.io/unicode-ident/1.0.12 \
-    crate://crates.io/windows-sys/0.52.0 \
-    crate://crates.io/windows-targets/0.52.6 \
-    crate://crates.io/windows_aarch64_gnullvm/0.52.6 \
-    crate://crates.io/windows_aarch64_msvc/0.52.6 \
-    crate://crates.io/windows_i686_gnu/0.52.6 \
-    crate://crates.io/windows_i686_gnullvm/0.52.6 \
-    crate://crates.io/windows_i686_msvc/0.52.6 \
-    crate://crates.io/windows_x86_64_gnu/0.52.6 \
-    crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
-    crate://crates.io/windows_x86_64_msvc/0.52.6 \
+    crate://crates.io/aho-corasick/0.7.18 \
+    crate://crates.io/cfg-if/1.0.0 \
+    crate://crates.io/getrandom/0.2.6 \
+    crate://crates.io/lazy_static/1.4.0 \
+    crate://crates.io/libc/0.2.125 \
+    crate://crates.io/memchr/2.5.0 \
+    crate://crates.io/quickcheck/1.0.3 \
+    crate://crates.io/rand/0.8.5 \
+    crate://crates.io/rand_core/0.6.3 \
+    crate://crates.io/regex-syntax/0.6.26 \
+    crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
 "
 
-SRC_URI[doc-comment-0.3.3.sha256sum] = "fea41bba32d969b513997752735605054bc0dfa92b4c56bf1189f2e174be7a10"
-SRC_URI[itoa-1.0.11.sha256sum] = "49f1f14873335454500d59611f1cf4a4b0f786f9ac11f4312a78e4cf2566695b"
-SRC_URI[proc-macro2-1.0.86.sha256sum] = "5e719e8df665df0d1c8fbfd238015744736151d4445ec0836b8e628aae103b77"
-SRC_URI[quote-1.0.36.sha256sum] = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
-SRC_URI[ryu-1.0.18.sha256sum] = "f3cb5ba0dc43242ce17de99c180e96db90b235b8a9fdc9543c96d2209116bd9f"
-SRC_URI[serde-1.0.204.sha256sum] = "bc76f558e0cbb2a839d37354c575f1dc3fdc6546b5be373ba43d95f231bf7c12"
-SRC_URI[serde_derive-1.0.204.sha256sum] = "e0cd7e117be63d3c3678776753929474f3b04a43a080c744d6b0ae2a8c28e222"
-SRC_URI[serde_json-1.0.120.sha256sum] = "4e0d21c9a8cae1235ad58a00c11cb40d4b1e5c784f1ef2c537876ed6ffd8b7c5"
-SRC_URI[syn-2.0.72.sha256sum] = "dc4b9b9bf2add8093d3f2c0204471e951b2285580335de42f9d2534f3ae7a8af"
-SRC_URI[unicode-ident-1.0.12.sha256sum] = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
-SRC_URI[windows-sys-0.52.0.sha256sum] = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
-SRC_URI[windows-targets-0.52.6.sha256sum] = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
-SRC_URI[windows_aarch64_gnullvm-0.52.6.sha256sum] = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
-SRC_URI[windows_aarch64_msvc-0.52.6.sha256sum] = "09ec2a7bb152e2252b53fa7803150007879548bc709c039df7627cabbd05d469"
-SRC_URI[windows_i686_gnu-0.52.6.sha256sum] = "8e9b5ad5ab802e97eb8e295ac6720e509ee4c243f69d781394014ebfe8bbfa0b"
-SRC_URI[windows_i686_gnullvm-0.52.6.sha256sum] = "0eee52d38c090b3caa76c563b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
-SRC_URI[windows_i686_msvc-0.52.6.sha256sum] = "240948bc05c5e7c6dabba28bf89d89ffce3e303022809e73deaefe4f6ec56c66"
-SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
-SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
-SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
-# from rust/vendor/lazy_static/Cargo.lock
+SRC_URI[aho-corasick-0.7.18.sha256sum] = "1e37cfd5e7657ada45f742d6e99ca5788580b5c529dc78faf11ece6dc702656f"
+SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+SRC_URI[getrandom-0.2.6.sha256sum] = "9be70c98951c83b8d2f8f60d7065fa6d5146873094452a1008da8c2f1e4205ad"
+SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
+SRC_URI[libc-0.2.125.sha256sum] = "5916d2ae698f6de9bfb891ad7a8d65c09d232dc58cc4ac433c7da3b2fd84bc2b"
+SRC_URI[memchr-2.5.0.sha256sum] = "2dffe52ecf27772e601905b7522cb4ef790d2cc203488bbd0e2fe85fcb74566d"
+SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
+SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
+SRC_URI[rand_core-0.6.3.sha256sum] = "d34f1408f55294453790c48b2f1ebbb1c5b4b7563eb1f418bcfcfdbb06ebb4e7"
+SRC_URI[regex-syntax-0.6.26.sha256sum] = "49b3de9ec5dc0a3417da371aab17d729997c15010e7fd24ff707773a33bddb64"
+SRC_URI[wasi-0.10.2+wasi-snapshot-preview1.sha256sum] = "fd6fbd9a79829dd1ad0cc20627bf1ed606756a7f77edff7b66b7064f9cb327c6"
+# from rust/vendor/bstr/Cargo.lock
 SRC_URI += " \
-    crate://crates.io/doc-comment/0.3.3 \
-    crate://crates.io/equivalent/1.0.1 \
-    crate://crates.io/glob/0.3.1 \
-    crate://crates.io/hashbrown/0.14.5 \
-    crate://crates.io/indexmap/2.2.6 \
-    crate://crates.io/itoa/1.0.11 \
-    crate://crates.io/memchr/2.7.4 \
-    crate://crates.io/proc-macro2/1.0.86 \
-    crate://crates.io/quote/1.0.36 \
-    crate://crates.io/ryu/1.0.18 \
-    crate://crates.io/serde/1.0.203 \
-    crate://crates.io/serde_derive/1.0.203 \
-    crate://crates.io/serde_json/1.0.117 \
-    crate://crates.io/serde_spanned/0.6.6 \
-    crate://crates.io/spin/0.9.8 \
-    crate://crates.io/syn/2.0.67 \
-    crate://crates.io/termcolor/1.4.1 \
-    crate://crates.io/toml/0.8.14 \
-    crate://crates.io/toml_datetime/0.6.6 \
-    crate://crates.io/toml_edit/0.22.14 \
-    crate://crates.io/trybuild/1.0.96 \
+    crate://crates.io/cfg-if/1.0.0 \
+    crate://crates.io/getrandom/0.2.11 \
+    crate://crates.io/libc/0.2.151 \
+    crate://crates.io/memchr/2.7.1 \
+    crate://crates.io/proc-macro2/1.0.71 \
+    crate://crates.io/quickcheck/1.0.3 \
+    crate://crates.io/quote/1.0.33 \
+    crate://crates.io/rand/0.8.5 \
+    crate://crates.io/rand_core/0.6.4 \
+    crate://crates.io/regex-automata/0.4.3 \
+    crate://crates.io/regex-lite/0.1.5 \
+    crate://crates.io/serde/1.0.193 \
+    crate://crates.io/serde_derive/1.0.193 \
+    crate://crates.io/syn/2.0.43 \
+    crate://crates.io/ucd-parse/0.1.12 \
     crate://crates.io/unicode-ident/1.0.12 \
-    crate://crates.io/winapi-util/0.1.8 \
-    crate://crates.io/windows-sys/0.52.0 \
-    crate://crates.io/windows-targets/0.52.5 \
-    crate://crates.io/windows_aarch64_gnullvm/0.52.5 \
-    crate://crates.io/windows_aarch64_msvc/0.52.5 \
-    crate://crates.io/windows_i686_gnu/0.52.5 \
-    crate://crates.io/windows_i686_gnullvm/0.52.5 \
-    crate://crates.io/windows_i686_msvc/0.52.5 \
-    crate://crates.io/windows_x86_64_gnu/0.52.5 \
-    crate://crates.io/windows_x86_64_gnullvm/0.52.5 \
-    crate://crates.io/windows_x86_64_msvc/0.52.5 \
-    crate://crates.io/winnow/0.6.13 \
+    crate://crates.io/unicode-segmentation/1.10.1 \
+    crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
 "
 
-SRC_URI[doc-comment-0.3.3.sha256sum] = "fea41bba32d969b513997752735605054bc0dfa92b4c56bf1189f2e174be7a10"
-SRC_URI[equivalent-1.0.1.sha256sum] = "5443807d6dff69373d433ab9ef5378ad8df50ca6298caf15de6e52e24aaf54d5"
-SRC_URI[glob-0.3.1.sha256sum] = "d2fabcfbdc87f4758337ca535fb41a6d701b65693ce38287d856d1674551ec9b"
-SRC_URI[hashbrown-0.14.5.sha256sum] = "e5274423e17b7c9fc20b6e7e208532f9b19825d82dfd615708b70edd83df41f1"
-SRC_URI[indexmap-2.2.6.sha256sum] = "168fb715dda47215e360912c096649d23d58bf392ac62f73919e831745e40f26"
-SRC_URI[itoa-1.0.11.sha256sum] = "49f1f14873335454500d59611f1cf4a4b0f786f9ac11f4312a78e4cf2566695b"
-SRC_URI[memchr-2.7.4.sha256sum] = "78ca9ab1a0babb1e7d5695e3530886289c18cf2f87ec19a575a0abdce112e3a3"
-SRC_URI[proc-macro2-1.0.86.sha256sum] = "5e719e8df665df0d1c8fbfd238015744736151d4445ec0836b8e628aae103b77"
-SRC_URI[quote-1.0.36.sha256sum] = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
-SRC_URI[ryu-1.0.18.sha256sum] = "f3cb5ba0dc43242ce17de99c180e96db90b235b8a9fdc9543c96d2209116bd9f"
-SRC_URI[serde-1.0.203.sha256sum] = "7253ab4de971e72fb7be983802300c30b5a7f0c2e56fab8abfc6a214307c0094"
-SRC_URI[serde_derive-1.0.203.sha256sum] = "500cbc0ebeb6f46627f50f3f5811ccf6bf00643be300b4c3eabc0ef55dc5b5ba"
-SRC_URI[serde_json-1.0.117.sha256sum] = "455182ea6142b14f93f4bc5320a2b31c1f266b66a4a5c858b013302a5d8cbfc3"
-SRC_URI[serde_spanned-0.6.6.sha256sum] = "79e674e01f999af37c49f70a6ede167a8a60b2503e56c5599532a65baa5969a0"
-SRC_URI[spin-0.9.8.sha256sum] = "6980e8d7511241f8acf4aebddbb1ff938df5eebe98691418c4468d0b72a96a67"
-SRC_URI[syn-2.0.67.sha256sum] = "ff8655ed1d86f3af4ee3fd3263786bc14245ad17c4c7e85ba7187fb3ae028c90"
-SRC_URI[termcolor-1.4.1.sha256sum] = "06794f8f6c5c898b3275aebefa6b8a1cb24cd2c6c79397ab15774837a0bc5755"
-SRC_URI[toml-0.8.14.sha256sum] = "6f49eb2ab21d2f26bd6db7bf383edc527a7ebaee412d17af4d40fdccd442f335"
-SRC_URI[toml_datetime-0.6.6.sha256sum] = "4badfd56924ae69bcc9039335b2e017639ce3f9b001c393c1b2d1ef846ce2cbf"
-SRC_URI[toml_edit-0.22.14.sha256sum] = "f21c7aaf97f1bd9ca9d4f9e73b0a6c74bd5afef56f2bc931943a6e1c37e04e38"
-SRC_URI[trybuild-1.0.96.sha256sum] = "33a5f13f11071020bb12de7a16b925d2d58636175c20c11dc5f96cb64bb6c9b3"
+SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+SRC_URI[getrandom-0.2.11.sha256sum] = "fe9006bed769170c11f845cf00c7c1e9092aeb3f268e007c3e760ac68008070f"
+SRC_URI[libc-0.2.151.sha256sum] = "302d7ab3130588088d277783b1e2d2e10c9e9e4a16dd9050e6ec93fb3e7048f4"
+SRC_URI[memchr-2.7.1.sha256sum] = "523dc4f511e55ab87b694dc30d0f820d60906ef06413f93d4d7a1385599cc149"
+SRC_URI[proc-macro2-1.0.71.sha256sum] = "75cb1540fadbd5b8fbccc4dddad2734eba435053f725621c070711a14bb5f4b8"
+SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
+SRC_URI[quote-1.0.33.sha256sum] = "5267fca4496028628a95160fc423a33e8b2e6af8a5302579e322e4b520293cae"
+SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
+SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
+SRC_URI[regex-automata-0.4.3.sha256sum] = "5f804c7828047e88b2d32e2d7fe5a105da8ee3264f01902f796c8e067dc2483f"
+SRC_URI[regex-lite-0.1.5.sha256sum] = "30b661b2f27137bdbc16f00eda72866a92bb28af1753ffbd56744fb6e2e9cd8e"
+SRC_URI[serde-1.0.193.sha256sum] = "25dd9975e68d0cb5aa1120c288333fc98731bd1dd12f561e468ea4728c042b89"
+SRC_URI[serde_derive-1.0.193.sha256sum] = "43576ca501357b9b071ac53cdc7da8ef0cbd9493d8df094cd821777ea6e894d3"
+SRC_URI[syn-2.0.43.sha256sum] = "ee659fb5f3d355364e1f3e5bc10fb82068efbf824a1e9d1c9504244a6469ad53"
+SRC_URI[ucd-parse-0.1.12.sha256sum] = "212c59636157b18c2f57eed2799e6606c52fc49c6a11685ffb0d08f06e55f428"
 SRC_URI[unicode-ident-1.0.12.sha256sum] = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
-SRC_URI[winapi-util-0.1.8.sha256sum] = "4d4cc384e1e73b93bafa6fb4f1df8c41695c8a91cf9c4c64358067d15a7b6c6b"
-SRC_URI[windows-sys-0.52.0.sha256sum] = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
-SRC_URI[windows-targets-0.52.5.sha256sum] = "6f0713a46559409d202e70e28227288446bf7841d3211583a4b53e3f6d96e7eb"
-SRC_URI[windows_aarch64_gnullvm-0.52.5.sha256sum] = "7088eed71e8b8dda258ecc8bac5fb1153c5cffaf2578fc8ff5d61e23578d3263"
-SRC_URI[windows_aarch64_msvc-0.52.5.sha256sum] = "9985fd1504e250c615ca5f281c3f7a6da76213ebd5ccc9561496568a2752afb6"
-SRC_URI[windows_i686_gnu-0.52.5.sha256sum] = "88ba073cf16d5372720ec942a8ccbf61626074c6d4dd2e745299726ce8b89670"
-SRC_URI[windows_i686_gnullvm-0.52.5.sha256sum] = "87f4261229030a858f36b459e748ae97545d6f1ec60e5e0d6a3d32e0dc232ee9"
-SRC_URI[windows_i686_msvc-0.52.5.sha256sum] = "db3c2bf3d13d5b658be73463284eaf12830ac9a26a90c717b7f771dfe97487bf"
-SRC_URI[windows_x86_64_gnu-0.52.5.sha256sum] = "4e4246f76bdeff09eb48875a0fd3e2af6aada79d409d33011886d3e1581517d9"
-SRC_URI[windows_x86_64_gnullvm-0.52.5.sha256sum] = "852298e482cd67c356ddd9570386e2862b5673c85bd5f88df9ab6802b334c596"
-SRC_URI[windows_x86_64_msvc-0.52.5.sha256sum] = "bec47e5bfd1bff0eeaf6d8b485cc1074891a197ab4225d504cb7a1ab88b02bf0"
-SRC_URI[winnow-0.6.13.sha256sum] = "59b5e5f6c299a3c7890b876a2a587f3115162487e704907d9b6cd29473052ba1"
+SRC_URI[unicode-segmentation-1.10.1.sha256sum] = "1dd624098567895118886609431a7c3b8f516e41d30e0643f03d94592a147e36"
+SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
 # from rust/vendor/asn1-rs/Cargo.lock
 SRC_URI += " \
     crate://crates.io/asn1-rs-derive/0.6.0 \
@@ -1556,172 +1808,53 @@ SRC_URI[windows_aarch64_msvc-0.52.6.sha256sum] = "09ec2a7bb152e2252b53fa78031500
 SRC_URI[windows_i686_gnu-0.52.6.sha256sum] = "8e9b5ad5ab802e97eb8e295ac6720e509ee4c243f69d781394014ebfe8bbfa0b"
 SRC_URI[windows_i686_gnullvm-0.52.6.sha256sum] = "0eee52d38c090b3caa76c563b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
 SRC_URI[windows_i686_msvc-0.52.6.sha256sum] = "240948bc05c5e7c6dabba28bf89d89ffce3e303022809e73deaefe4f6ec56c66"
-SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
-SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
-SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
-SRC_URI[winnow-0.7.4.sha256sum] = "0e97b544156e9bebe1a0ffbc03484fc1ffe3100cbce3ffb17eac35f7cdd7ab36"
-SRC_URI[wyz-0.5.1.sha256sum] = "05f360fc0b24296329c78fda852a1e9ae82de9cf7b27dae4b7f62f118f77b9ed"
-# from rust/vendor/brotli/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/alloc-no-stdlib/2.0.4 \
-    crate://crates.io/alloc-stdlib/0.2.2 \
-    crate://crates.io/block-buffer/0.10.4 \
-    crate://crates.io/brotli-decompressor/5.0.0 \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/cpufeatures/0.2.17 \
-    crate://crates.io/crypto-common/0.1.6 \
-    crate://crates.io/digest/0.10.7 \
-    crate://crates.io/generic-array/0.14.7 \
-    crate://crates.io/libc/0.2.172 \
-    crate://crates.io/sha2/0.10.9 \
-    crate://crates.io/typenum/1.18.0 \
-    crate://crates.io/version_check/0.9.5 \
-"
-
-SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
-SRC_URI[alloc-stdlib-0.2.2.sha256sum] = "94fb8275041c72129eb51b7d0322c29b8387a0386127718b096429201a5d6ece"
-SRC_URI[block-buffer-0.10.4.sha256sum] = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
-SRC_URI[brotli-decompressor-5.0.0.sha256sum] = "874bb8112abecc98cbd6d81ea4fa7e94fb9449648c93cc89aa40c81c24d7de03"
-SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[cpufeatures-0.2.17.sha256sum] = "59ed5838eebb26a2bb2e58f6d5b5316989ae9d08bab10e0e6d103e656d1b0280"
-SRC_URI[crypto-common-0.1.6.sha256sum] = "1bfb12502f3fc46cca1bb51ac28df9d618d813cdc3d2f25b9fe775a34af26bb3"
-SRC_URI[digest-0.10.7.sha256sum] = "9ed9a281f7bc9b7576e61468ba615a66a5c8cfdff42420a70aa82701a3b1e292"
-SRC_URI[generic-array-0.14.7.sha256sum] = "85649ca51fd72272d7821adaf274ad91c288277713d9c18820d8499a7ff69e9a"
-SRC_URI[libc-0.2.172.sha256sum] = "d750af042f7ef4f724306de029d18836c26c1765a54a6a3f094cbd23a7267ffa"
-SRC_URI[sha2-0.10.9.sha256sum] = "a7507d819769d01a365ab707794a4084392c824f54a7a6a7862f8c3d0892b283"
-SRC_URI[typenum-1.18.0.sha256sum] = "1dccffe3ce07af9386bfd29e80c0ab1a8205a2fc34e4bcd40364df902cfa8f3f"
-SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
-# from rust/vendor/rustyline/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/ahash/0.8.11 \
-    crate://crates.io/aho-corasick/1.1.2 \
-    crate://crates.io/allocator-api2/0.2.16 \
-    crate://crates.io/android-tzdata/0.1.1 \
-    crate://crates.io/android_system_properties/0.1.5 \
-    crate://crates.io/arrayvec/0.7.4 \
-    crate://crates.io/assert_matches/1.5.0 \
-    crate://crates.io/autocfg/1.1.0 \
-    crate://crates.io/beef/0.5.2 \
-    crate://crates.io/bitflags/1.3.2 \
-    crate://crates.io/bitflags/2.4.2 \
-    crate://crates.io/buffer-redux/1.0.1 \
-    crate://crates.io/bumpalo/3.15.3 \
-    crate://crates.io/cc/1.0.89 \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/cfg_aliases/0.1.1 \
-    crate://crates.io/chrono/0.4.35 \
-    crate://crates.io/clipboard-win/5.2.0 \
-    crate://crates.io/core-foundation-sys/0.8.6 \
-    crate://crates.io/crossbeam/0.8.4 \
-    crate://crates.io/crossbeam-channel/0.5.12 \
-    crate://crates.io/crossbeam-deque/0.8.5 \
-    crate://crates.io/crossbeam-epoch/0.9.18 \
-    crate://crates.io/crossbeam-queue/0.3.11 \
-    crate://crates.io/crossbeam-utils/0.8.19 \
-    crate://crates.io/darling/0.14.4 \
-    crate://crates.io/darling_core/0.14.4 \
-    crate://crates.io/darling_macro/0.14.4 \
-    crate://crates.io/defer-drop/1.3.0 \
-    crate://crates.io/deranged/0.3.11 \
-    crate://crates.io/derive_builder/0.11.2 \
-    crate://crates.io/derive_builder_core/0.11.2 \
-    crate://crates.io/derive_builder_macro/0.11.2 \
-    crate://crates.io/dirs-next/2.0.0 \
-    crate://crates.io/dirs-sys-next/0.1.2 \
-    crate://crates.io/doc-comment/0.3.3 \
-    crate://crates.io/either/1.10.0 \
-    crate://crates.io/endian-type/0.1.2 \
-    crate://crates.io/env_filter/0.1.0 \
-    crate://crates.io/env_logger/0.11.3 \
-    crate://crates.io/errno/0.3.8 \
-    crate://crates.io/error-code/3.2.0 \
-    crate://crates.io/fallible-iterator/0.3.0 \
-    crate://crates.io/fallible-streaming-iterator/0.1.9 \
-    crate://crates.io/fastrand/2.0.1 \
-    crate://crates.io/fd-lock/4.0.2 \
-    crate://crates.io/fnv/1.0.7 \
-    crate://crates.io/fuzzy-matcher/0.3.7 \
+SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
+SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
+SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
+SRC_URI[winnow-0.7.4.sha256sum] = "0e97b544156e9bebe1a0ffbc03484fc1ffe3100cbce3ffb17eac35f7cdd7ab36"
+SRC_URI[wyz-0.5.1.sha256sum] = "05f360fc0b24296329c78fda852a1e9ae82de9cf7b27dae4b7f62f118f77b9ed"
+# from rust/vendor/x509-parser/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/asn1-rs/0.6.1 \
+    crate://crates.io/asn1-rs-derive/0.5.0 \
+    crate://crates.io/asn1-rs-impl/0.2.0 \
+    crate://crates.io/autocfg/1.1.0 \
+    crate://crates.io/cc/1.0.88 \
+    crate://crates.io/cfg-if/1.0.0 \
+    crate://crates.io/data-encoding/2.5.0 \
+    crate://crates.io/der-parser/9.0.0 \
+    crate://crates.io/deranged/0.3.11 \
+    crate://crates.io/displaydoc/0.2.4 \
     crate://crates.io/getrandom/0.2.12 \
-    crate://crates.io/hashbrown/0.14.3 \
-    crate://crates.io/hashlink/0.9.0 \
-    crate://crates.io/home/0.5.9 \
-    crate://crates.io/iana-time-zone/0.1.60 \
-    crate://crates.io/iana-time-zone-haiku/0.1.2 \
-    crate://crates.io/ident_case/1.0.1 \
-    crate://crates.io/js-sys/0.3.69 \
+    crate://crates.io/itoa/1.0.10 \
     crate://crates.io/lazy_static/1.4.0 \
     crate://crates.io/libc/0.2.153 \
-    crate://crates.io/libredox/0.0.1 \
-    crate://crates.io/libsqlite3-sys/0.28.0 \
-    crate://crates.io/linux-raw-sys/0.4.13 \
-    crate://crates.io/log/0.4.21 \
     crate://crates.io/memchr/2.7.1 \
-    crate://crates.io/memoffset/0.6.5 \
-    crate://crates.io/nibble_vec/0.1.0 \
-    crate://crates.io/nix/0.24.3 \
-    crate://crates.io/nix/0.25.1 \
-    crate://crates.io/nix/0.28.0 \
+    crate://crates.io/minimal-lexical/0.2.1 \
+    crate://crates.io/nom/7.1.3 \
+    crate://crates.io/num-bigint/0.4.4 \
     crate://crates.io/num-conv/0.1.0 \
+    crate://crates.io/num-integer/0.1.46 \
     crate://crates.io/num-traits/0.2.18 \
-    crate://crates.io/once_cell/1.19.0 \
-    crate://crates.io/pin-utils/0.1.0 \
-    crate://crates.io/pkg-config/0.3.30 \
+    crate://crates.io/oid-registry/0.7.0 \
     crate://crates.io/powerfmt/0.2.0 \
-    crate://crates.io/ppv-lite86/0.2.17 \
     crate://crates.io/proc-macro2/1.0.78 \
     crate://crates.io/quote/1.0.35 \
-    crate://crates.io/radix_trie/0.2.1 \
-    crate://crates.io/rand/0.8.5 \
-    crate://crates.io/rand_chacha/0.3.1 \
-    crate://crates.io/rand_core/0.6.4 \
-    crate://crates.io/rayon/1.9.0 \
-    crate://crates.io/rayon-core/1.12.1 \
-    crate://crates.io/redox_syscall/0.4.1 \
-    crate://crates.io/redox_users/0.4.4 \
-    crate://crates.io/regex/1.10.3 \
-    crate://crates.io/regex-automata/0.4.6 \
-    crate://crates.io/regex-syntax/0.8.2 \
-    crate://crates.io/rusqlite/0.31.0 \
-    crate://crates.io/rustix/0.38.31 \
-    crate://crates.io/rustversion/1.0.14 \
-    crate://crates.io/rustyline-derive/0.10.0 \
+    crate://crates.io/ring/0.17.8 \
+    crate://crates.io/rusticata-macros/4.1.0 \
     crate://crates.io/serde/1.0.197 \
     crate://crates.io/serde_derive/1.0.197 \
-    crate://crates.io/signal-hook/0.3.17 \
-    crate://crates.io/signal-hook-registry/1.4.1 \
-    crate://crates.io/skim/0.10.4 \
-    crate://crates.io/smallvec/1.13.1 \
-    crate://crates.io/strsim/0.10.0 \
-    crate://crates.io/syn/1.0.109 \
+    crate://crates.io/spin/0.9.8 \
     crate://crates.io/syn/2.0.52 \
-    crate://crates.io/tempfile/3.10.1 \
-    crate://crates.io/term/0.7.0 \
-    crate://crates.io/termios/0.3.3 \
+    crate://crates.io/synstructure/0.13.1 \
     crate://crates.io/thiserror/1.0.57 \
     crate://crates.io/thiserror-impl/1.0.57 \
-    crate://crates.io/thread_local/1.1.8 \
     crate://crates.io/time/0.3.34 \
     crate://crates.io/time-core/0.1.2 \
-    crate://crates.io/timer/0.2.0 \
-    crate://crates.io/tuikit/0.5.0 \
+    crate://crates.io/time-macros/0.2.17 \
     crate://crates.io/unicode-ident/1.0.12 \
-    crate://crates.io/unicode-segmentation/1.11.0 \
-    crate://crates.io/unicode-width/0.1.11 \
-    crate://crates.io/utf8parse/0.2.1 \
-    crate://crates.io/vcpkg/0.2.15 \
-    crate://crates.io/version_check/0.9.4 \
-    crate://crates.io/vte/0.11.1 \
-    crate://crates.io/vte_generate_state_changes/0.1.1 \
+    crate://crates.io/untrusted/0.9.0 \
     crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
-    crate://crates.io/wasm-bindgen/0.2.92 \
-    crate://crates.io/wasm-bindgen-backend/0.2.92 \
-    crate://crates.io/wasm-bindgen-macro/0.2.92 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.92 \
-    crate://crates.io/wasm-bindgen-shared/0.2.92 \
-    crate://crates.io/winapi/0.3.9 \
-    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
-    crate://crates.io/windows-core/0.52.0 \
     crate://crates.io/windows-sys/0.52.0 \
     crate://crates.io/windows-targets/0.52.4 \
     crate://crates.io/windows_aarch64_gnullvm/0.52.4 \
@@ -1731,277 +1864,420 @@ SRC_URI += " \
     crate://crates.io/windows_x86_64_gnu/0.52.4 \
     crate://crates.io/windows_x86_64_gnullvm/0.52.4 \
     crate://crates.io/windows_x86_64_msvc/0.52.4 \
-    crate://crates.io/zerocopy/0.7.32 \
-    crate://crates.io/zerocopy-derive/0.7.32 \
 "
 
-SRC_URI[ahash-0.8.11.sha256sum] = "e89da841a80418a9b391ebaea17f5c112ffaaa96f621d2c285b5174da76b9011"
-SRC_URI[aho-corasick-1.1.2.sha256sum] = "b2969dcb958b36655471fc61f7e416fa76033bdd4bfed0678d8fee1e2d07a1f0"
-SRC_URI[allocator-api2-0.2.16.sha256sum] = "0942ffc6dcaadf03badf6e6a2d0228460359d5e34b57ccdc720b7382dfbd5ec5"
-SRC_URI[android-tzdata-0.1.1.sha256sum] = "e999941b234f3131b00bc13c22d06e8c5ff726d1b6318ac7eb276997bbb4fef0"
-SRC_URI[android_system_properties-0.1.5.sha256sum] = "819e7219dbd41043ac279b19830f2efc897156490d7fd6ea916720117ee66311"
-SRC_URI[arrayvec-0.7.4.sha256sum] = "96d30a06541fbafbc7f82ed10c06164cfbd2c401138f6addd8404629c4b16711"
-SRC_URI[assert_matches-1.5.0.sha256sum] = "9b34d609dfbaf33d6889b2b7106d3ca345eacad44200913df5ba02bfd31d2ba9"
+SRC_URI[asn1-rs-0.6.1.sha256sum] = "22ad1373757efa0f70ec53939aabc7152e1591cb485208052993070ac8d2429d"
+SRC_URI[asn1-rs-derive-0.5.0.sha256sum] = "7378575ff571966e99a744addeff0bff98b8ada0dedf1956d59e634db95eaac1"
+SRC_URI[asn1-rs-impl-0.2.0.sha256sum] = "7b18050c2cd6fe86c3a76584ef5e0baf286d038cda203eb6223df2cc413565f7"
 SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
-SRC_URI[beef-0.5.2.sha256sum] = "3a8241f3ebb85c056b509d4327ad0358fbbba6ffb340bf388f26350aeda225b1"
-SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
-SRC_URI[bitflags-2.4.2.sha256sum] = "ed570934406eb16438a4e976b1b4500774099c13b8cb96eec99f620f05090ddf"
-SRC_URI[buffer-redux-1.0.1.sha256sum] = "4c9f8ddd22e0a12391d1e7ada69ec3b0da1914f1cec39c5cf977143c5b2854f5"
-SRC_URI[bumpalo-3.15.3.sha256sum] = "8ea184aa71bb362a1157c896979544cc23974e08fd265f29ea96b59f0b4a555b"
-SRC_URI[cc-1.0.89.sha256sum] = "a0ba8f7aaa012f30d5b2861462f6708eccd49c3c39863fe083a308035f63d723"
+SRC_URI[cc-1.0.88.sha256sum] = "02f341c093d19155a6e41631ce5971aac4e9a868262212153124c15fa22d1cdc"
 SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[cfg_aliases-0.1.1.sha256sum] = "fd16c4719339c4530435d38e511904438d07cce7950afa3718a84ac36c10e89e"
-SRC_URI[chrono-0.4.35.sha256sum] = "8eaf5903dcbc0a39312feb77df2ff4c76387d591b9fc7b04a238dcf8bb62639a"
-SRC_URI[clipboard-win-5.2.0.sha256sum] = "12f9a0700e0127ba15d1d52dd742097f821cd9c65939303a44d970465040a297"
-SRC_URI[core-foundation-sys-0.8.6.sha256sum] = "06ea2b9bc92be3c2baa9334a323ebca2d6f074ff852cd1d7b11064035cd3868f"
-SRC_URI[crossbeam-0.8.4.sha256sum] = "1137cd7e7fc0fb5d3c5a8678be38ec56e819125d8d7907411fe24ccb943faca8"
-SRC_URI[crossbeam-channel-0.5.12.sha256sum] = "ab3db02a9c5b5121e1e42fbdb1aeb65f5e02624cc58c43f2884c6ccac0b82f95"
-SRC_URI[crossbeam-deque-0.8.5.sha256sum] = "613f8cc01fe9cf1a3eb3d7f488fd2fa8388403e97039e2f73692932e291a770d"
-SRC_URI[crossbeam-epoch-0.9.18.sha256sum] = "5b82ac4a3c2ca9c3460964f020e1402edd5753411d7737aa39c3714ad1b5420e"
-SRC_URI[crossbeam-queue-0.3.11.sha256sum] = "df0346b5d5e76ac2fe4e327c5fd1118d6be7c51dfb18f9b7922923f287471e35"
-SRC_URI[crossbeam-utils-0.8.19.sha256sum] = "248e3bacc7dc6baa3b21e405ee045c3047101a49145e7e9eca583ab4c2ca5345"
-SRC_URI[darling-0.14.4.sha256sum] = "7b750cb3417fd1b327431a470f388520309479ab0bf5e323505daf0290cd3850"
-SRC_URI[darling_core-0.14.4.sha256sum] = "109c1ca6e6b7f82cc233a97004ea8ed7ca123a9af07a8230878fcfda9b158bf0"
-SRC_URI[darling_macro-0.14.4.sha256sum] = "a4aab4dbc9f7611d8b55048a3a16d2d010c2c8334e46304b40ac1cc14bf3b48e"
-SRC_URI[defer-drop-1.3.0.sha256sum] = "f613ec9fa66a6b28cdb1842b27f9adf24f39f9afc4dcdd9fdecee4aca7945c57"
+SRC_URI[data-encoding-2.5.0.sha256sum] = "7e962a19be5cfc3f3bf6dd8f61eb50107f356ad6270fbb3ed41476571db78be5"
+SRC_URI[der-parser-9.0.0.sha256sum] = "5cd0a5c643689626bec213c4d8bd4d96acc8ffdb4ad4bb6bc16abf27d5f4b553"
 SRC_URI[deranged-0.3.11.sha256sum] = "b42b6fa04a440b495c8b04d0e71b707c585f83cb9cb28cf8cd0d976c315e31b4"
-SRC_URI[derive_builder-0.11.2.sha256sum] = "d07adf7be193b71cc36b193d0f5fe60b918a3a9db4dad0449f57bcfd519704a3"
-SRC_URI[derive_builder_core-0.11.2.sha256sum] = "1f91d4cfa921f1c05904dc3c57b4a32c38aed3340cce209f3a6fd1478babafc4"
-SRC_URI[derive_builder_macro-0.11.2.sha256sum] = "8f0314b72bed045f3a68671b3c86328386762c93f82d98c65c3cb5e5f573dd68"
-SRC_URI[dirs-next-2.0.0.sha256sum] = "b98cf8ebf19c3d1b223e151f99a4f9f0690dca41414773390fc824184ac833e1"
-SRC_URI[dirs-sys-next-0.1.2.sha256sum] = "4ebda144c4fe02d1f7ea1a7d9641b6fc6b580adcfa024ae48797ecdeb6825b4d"
-SRC_URI[doc-comment-0.3.3.sha256sum] = "fea41bba32d969b513997752735605054bc0dfa92b4c56bf1189f2e174be7a10"
-SRC_URI[either-1.10.0.sha256sum] = "11157ac094ffbdde99aa67b23417ebdd801842852b500e395a45a9c0aac03e4a"
-SRC_URI[endian-type-0.1.2.sha256sum] = "c34f04666d835ff5d62e058c3995147c06f42fe86ff053337632bca83e42702d"
-SRC_URI[env_filter-0.1.0.sha256sum] = "a009aa4810eb158359dda09d0c87378e4bbb89b5a801f016885a4707ba24f7ea"
-SRC_URI[env_logger-0.11.3.sha256sum] = "38b35839ba51819680ba087cd351788c9a3c476841207e0b8cee0b04722343b9"
-SRC_URI[errno-0.3.8.sha256sum] = "a258e46cdc063eb8519c00b9fc845fc47bcfca4130e2f08e88665ceda8474245"
-SRC_URI[error-code-3.2.0.sha256sum] = "a0474425d51df81997e2f90a21591180b38eccf27292d755f3e30750225c175b"
-SRC_URI[fallible-iterator-0.3.0.sha256sum] = "2acce4a10f12dc2fb14a218589d4f1f62ef011b2d0cc4b3cb1bba8e94da14649"
-SRC_URI[fallible-streaming-iterator-0.1.9.sha256sum] = "7360491ce676a36bf9bb3c56c1aa791658183a54d2744120f27285738d90465a"
-SRC_URI[fastrand-2.0.1.sha256sum] = "25cbce373ec4653f1a01a31e8a5e5ec0c622dc27ff9c4e6606eefef5cbbed4a5"
-SRC_URI[fd-lock-4.0.2.sha256sum] = "7e5768da2206272c81ef0b5e951a41862938a6070da63bcea197899942d3b947"
-SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
-SRC_URI[fuzzy-matcher-0.3.7.sha256sum] = "54614a3312934d066701a80f20f15fa3b56d67ac7722b39eea5b4c9dd1d66c94"
+SRC_URI[displaydoc-0.2.4.sha256sum] = "487585f4d0c6655fe74905e2504d8ad6908e4db67f744eb140876906c2f3175d"
 SRC_URI[getrandom-0.2.12.sha256sum] = "190092ea657667030ac6a35e305e62fc4dd69fd98ac98631e5d3a2b1575a12b5"
-SRC_URI[hashbrown-0.14.3.sha256sum] = "290f1a1d9242c78d09ce40a5e87e7554ee637af1351968159f4952f028f75604"
-SRC_URI[hashlink-0.9.0.sha256sum] = "692eaaf7f7607518dd3cef090f1474b61edc5301d8012f09579920df68b725ee"
-SRC_URI[home-0.5.9.sha256sum] = "e3d1354bf6b7235cb4a0576c2619fd4ed18183f689b12b006a0ee7329eeff9a5"
-SRC_URI[iana-time-zone-0.1.60.sha256sum] = "e7ffbb5a1b541ea2561f8c41c087286cc091e21e556a4f09a8f6cbf17b69b141"
-SRC_URI[iana-time-zone-haiku-0.1.2.sha256sum] = "f31827a206f56af32e590ba56d5d2d085f558508192593743f16b2306495269f"
-SRC_URI[ident_case-1.0.1.sha256sum] = "b9e0384b61958566e926dc50660321d12159025e767c18e043daf26b70104c39"
-SRC_URI[js-sys-0.3.69.sha256sum] = "29c15563dc2726973df627357ce0c9ddddbea194836909d655df6a75d2cf296d"
+SRC_URI[itoa-1.0.10.sha256sum] = "b1a46d1a171d865aa5f83f92695765caa047a9b4cbae2cbf37dbd613a793fd4c"
 SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
 SRC_URI[libc-0.2.153.sha256sum] = "9c198f91728a82281a64e1f4f9eeb25d82cb32a5de251c6bd1b5154d63a8e7bd"
-SRC_URI[libredox-0.0.1.sha256sum] = "85c833ca1e66078851dba29046874e38f08b2c883700aa29a03ddd3b23814ee8"
-SRC_URI[libsqlite3-sys-0.28.0.sha256sum] = "0c10584274047cb335c23d3e61bcef8e323adae7c5c8c760540f73610177fc3f"
-SRC_URI[linux-raw-sys-0.4.13.sha256sum] = "01cda141df6706de531b6c46c3a33ecca755538219bd484262fa09410c13539c"
-SRC_URI[log-0.4.21.sha256sum] = "90ed8c1e510134f979dbc4f070f87d4313098b704861a105fe34231c70a3901c"
 SRC_URI[memchr-2.7.1.sha256sum] = "523dc4f511e55ab87b694dc30d0f820d60906ef06413f93d4d7a1385599cc149"
-SRC_URI[memoffset-0.6.5.sha256sum] = "5aa361d4faea93603064a027415f07bd8e1d5c88c9fbf68bf56a285428fd79ce"
-SRC_URI[nibble_vec-0.1.0.sha256sum] = "77a5d83df9f36fe23f0c3648c6bbb8b0298bb5f1939c8f2704431371f4b84d43"
-SRC_URI[nix-0.24.3.sha256sum] = "fa52e972a9a719cecb6864fb88568781eb706bac2cd1d4f04a648542dbf78069"
-SRC_URI[nix-0.25.1.sha256sum] = "f346ff70e7dbfd675fe90590b92d59ef2de15a8779ae305ebcbfd3f0caf59be4"
-SRC_URI[nix-0.28.0.sha256sum] = "ab2156c4fce2f8df6c499cc1c763e4394b7482525bf2a9701c9d79d215f519e4"
+SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
+SRC_URI[nom-7.1.3.sha256sum] = "d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
+SRC_URI[num-bigint-0.4.4.sha256sum] = "608e7659b5c3d7cba262d894801b9ec9d00de989e8a82bd4bef91d08da45cdc0"
 SRC_URI[num-conv-0.1.0.sha256sum] = "51d515d32fb182ee37cda2ccdcb92950d6a3c2893aa280e540671c2cd0f3b1d9"
+SRC_URI[num-integer-0.1.46.sha256sum] = "7969661fd2958a5cb096e56c8e1ad0444ac2bbcd0061bd28660485a44879858f"
 SRC_URI[num-traits-0.2.18.sha256sum] = "da0df0e5185db44f69b44f26786fe401b6c293d1907744beaa7fa62b2e5a517a"
-SRC_URI[once_cell-1.19.0.sha256sum] = "3fdb12b2476b595f9358c5161aa467c2438859caa136dec86c26fdd2efe17b92"
-SRC_URI[pin-utils-0.1.0.sha256sum] = "8b870d8c151b6f2fb93e84a13146138f05d02ed11c7e7c54f8826aaaf7c9f184"
-SRC_URI[pkg-config-0.3.30.sha256sum] = "d231b230927b5e4ad203db57bbcbee2802f6bce620b1e4a9024a07d94e2907ec"
+SRC_URI[oid-registry-0.7.0.sha256sum] = "1c958dd45046245b9c3c2547369bb634eb461670b2e7e0de552905801a648d1d"
 SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
-SRC_URI[ppv-lite86-0.2.17.sha256sum] = "5b40af805b3121feab8a3c29f04d8ad262fa8e0561883e7653e024ae4479e6de"
 SRC_URI[proc-macro2-1.0.78.sha256sum] = "e2422ad645d89c99f8f3e6b88a9fdeca7fabeac836b1002371c4367c8f984aae"
 SRC_URI[quote-1.0.35.sha256sum] = "291ec9ab5efd934aaf503a6466c5d5251535d108ee747472c3977cc5acc868ef"
-SRC_URI[radix_trie-0.2.1.sha256sum] = "c069c179fcdc6a2fe24d8d18305cf085fdbd4f922c041943e203685d6a1c58fd"
-SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
-SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
-SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
-SRC_URI[rayon-1.9.0.sha256sum] = "e4963ed1bc86e4f3ee217022bd855b297cef07fb9eac5dfa1f788b220b49b3bd"
-SRC_URI[rayon-core-1.12.1.sha256sum] = "1465873a3dfdaa8ae7cb14b4383657caab0b3e8a0aa9ae8e04b044854c8dfce2"
-SRC_URI[redox_syscall-0.4.1.sha256sum] = "4722d768eff46b75989dd134e5c353f0d6296e5aaa3132e776cbdb56be7731aa"
-SRC_URI[redox_users-0.4.4.sha256sum] = "a18479200779601e498ada4e8c1e1f50e3ee19deb0259c25825a98b5603b2cb4"
-SRC_URI[regex-1.10.3.sha256sum] = "b62dbe01f0b06f9d8dc7d49e05a0785f153b00b2c227856282f671e0318c9b15"
-SRC_URI[regex-automata-0.4.6.sha256sum] = "86b83b8b9847f9bf95ef68afb0b8e6cdb80f498442f5179a29fad448fcc1eaea"
-SRC_URI[regex-syntax-0.8.2.sha256sum] = "c08c74e62047bb2de4ff487b251e4a92e24f48745648451635cec7d591162d9f"
-SRC_URI[rusqlite-0.31.0.sha256sum] = "b838eba278d213a8beaf485bd313fd580ca4505a00d5871caeb1457c55322cae"
-SRC_URI[rustix-0.38.31.sha256sum] = "6ea3e1a662af26cd7a3ba09c0297a31af215563ecf42817c98df621387f4e949"
-SRC_URI[rustversion-1.0.14.sha256sum] = "7ffc183a10b4478d04cbbbfc96d0873219d962dd5accaff2ffbd4ceb7df837f4"
-SRC_URI[rustyline-derive-0.10.0.sha256sum] = "e5af959c8bf6af1aff6d2b463a57f71aae53d1332da58419e30ad8dc7011d951"
+SRC_URI[ring-0.17.8.sha256sum] = "c17fa4cb658e3583423e915b9f3acc01cceaee1860e33d59ebae66adc3a2dc0d"
+SRC_URI[rusticata-macros-4.1.0.sha256sum] = "faf0c4a6ece9950b9abdb62b1cfcf2a68b3b67a10ba445b3bb85be2a293d0632"
 SRC_URI[serde-1.0.197.sha256sum] = "3fb1c873e1b9b056a4dc4c0c198b24c3ffa059243875552b2bd0933b1aee4ce2"
 SRC_URI[serde_derive-1.0.197.sha256sum] = "7eb0b34b42edc17f6b7cac84a52a1c5f0e1bb2227e997ca9011ea3dd34e8610b"
-SRC_URI[signal-hook-0.3.17.sha256sum] = "8621587d4798caf8eb44879d42e56b9a93ea5dcd315a6487c357130095b62801"
-SRC_URI[signal-hook-registry-1.4.1.sha256sum] = "d8229b473baa5980ac72ef434c4415e70c4b5e71b423043adb4ba059f89c99a1"
-SRC_URI[skim-0.10.4.sha256sum] = "e5d28de0a6cb2cdd83a076f1de9d965b973ae08b244df1aa70b432946dda0f32"
-SRC_URI[smallvec-1.13.1.sha256sum] = "e6ecd384b10a64542d77071bd64bd7b231f4ed5940fba55e98c3de13824cf3d7"
-SRC_URI[strsim-0.10.0.sha256sum] = "73473c0e59e6d5812c5dfe2a064a6444949f089e20eec9a2e5506596494e4623"
+SRC_URI[spin-0.9.8.sha256sum] = "6980e8d7511241f8acf4aebddbb1ff938df5eebe98691418c4468d0b72a96a67"
+SRC_URI[syn-2.0.52.sha256sum] = "b699d15b36d1f02c3e7c69f8ffef53de37aefae075d8488d4ba1a7788d574a07"
+SRC_URI[synstructure-0.13.1.sha256sum] = "c8af7666ab7b6390ab78131fb5b0fce11d6b7a6951602017c35fa82800708971"
+SRC_URI[thiserror-1.0.57.sha256sum] = "1e45bcbe8ed29775f228095caf2cd67af7a4ccf756ebff23a306bf3e8b47b24b"
+SRC_URI[thiserror-impl-1.0.57.sha256sum] = "a953cb265bef375dae3de6663da4d3804eee9682ea80d8e2542529b73c531c81"
+SRC_URI[time-0.3.34.sha256sum] = "c8248b6521bb14bc45b4067159b9b6ad792e2d6d754d6c41fb50e29fefe38749"
+SRC_URI[time-core-0.1.2.sha256sum] = "ef927ca75afb808a4d64dd374f00a2adf8d0fcff8e7b184af886c3c87ec4a3f3"
+SRC_URI[time-macros-0.2.17.sha256sum] = "7ba3a3ef41e6672a2f0f001392bb5dcd3ff0a9992d618ca761a11c3121547774"
+SRC_URI[unicode-ident-1.0.12.sha256sum] = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
+SRC_URI[untrusted-0.9.0.sha256sum] = "8ecb6da28b8a351d773b68d5825ac39017e680750f980f3a1a85cd8dd28a47c1"
+SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
+SRC_URI[windows-sys-0.52.0.sha256sum] = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
+SRC_URI[windows-targets-0.52.4.sha256sum] = "7dd37b7e5ab9018759f893a1952c9420d060016fc19a472b4bb20d1bdd694d1b"
+SRC_URI[windows_aarch64_gnullvm-0.52.4.sha256sum] = "bcf46cf4c365c6f2d1cc93ce535f2c8b244591df96ceee75d8e83deb70a9cac9"
+SRC_URI[windows_aarch64_msvc-0.52.4.sha256sum] = "da9f259dd3bcf6990b55bffd094c4f7235817ba4ceebde8e6d11cd0c5633b675"
+SRC_URI[windows_i686_gnu-0.52.4.sha256sum] = "b474d8268f99e0995f25b9f095bc7434632601028cf86590aea5c8a5cb7801d3"
+SRC_URI[windows_i686_msvc-0.52.4.sha256sum] = "1515e9a29e5bed743cb4415a9ecf5dfca648ce85ee42e15873c3cd8610ff8e02"
+SRC_URI[windows_x86_64_gnu-0.52.4.sha256sum] = "5eee091590e89cc02ad514ffe3ead9eb6b660aedca2183455434b93546371a03"
+SRC_URI[windows_x86_64_gnullvm-0.52.4.sha256sum] = "77ca79f2451b49fa9e2af39f0747fe999fcda4f5e241b2898624dca97a1f2177"
+SRC_URI[windows_x86_64_msvc-0.52.4.sha256sum] = "32b752e52a2da0ddfbdbcc6fceadfeede4c939ed16d13e648833a61dfb611ed8"
+# from rust/vendor/displaydoc/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/ansi_term/0.11.0 \
+    crate://crates.io/ctor/0.1.26 \
+    crate://crates.io/difference/2.0.0 \
+    crate://crates.io/equivalent/1.0.1 \
+    crate://crates.io/glob/0.3.1 \
+    crate://crates.io/hashbrown/0.14.5 \
+    crate://crates.io/indexmap/2.2.6 \
+    crate://crates.io/itoa/1.0.11 \
+    crate://crates.io/libc/0.2.155 \
+    crate://crates.io/memchr/2.7.4 \
+    crate://crates.io/output_vt100/0.1.3 \
+    crate://crates.io/pretty_assertions/0.6.1 \
+    crate://crates.io/proc-macro2/1.0.85 \
+    crate://crates.io/quote/1.0.36 \
+    crate://crates.io/rustversion/1.0.17 \
+    crate://crates.io/ryu/1.0.18 \
+    crate://crates.io/serde/1.0.203 \
+    crate://crates.io/serde_derive/1.0.203 \
+    crate://crates.io/serde_json/1.0.117 \
+    crate://crates.io/serde_spanned/0.6.6 \
+    crate://crates.io/static_assertions/1.1.0 \
+    crate://crates.io/syn/1.0.109 \
+    crate://crates.io/syn/2.0.66 \
+    crate://crates.io/termcolor/1.4.1 \
+    crate://crates.io/thiserror/1.0.61 \
+    crate://crates.io/thiserror-impl/1.0.61 \
+    crate://crates.io/toml/0.8.14 \
+    crate://crates.io/toml_datetime/0.6.6 \
+    crate://crates.io/toml_edit/0.22.14 \
+    crate://crates.io/trybuild/1.0.96 \
+    crate://crates.io/unicode-ident/1.0.12 \
+    crate://crates.io/winapi/0.3.9 \
+    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
+    crate://crates.io/winapi-util/0.1.8 \
+    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+    crate://crates.io/windows-sys/0.52.0 \
+    crate://crates.io/windows-targets/0.52.5 \
+    crate://crates.io/windows_aarch64_gnullvm/0.52.5 \
+    crate://crates.io/windows_aarch64_msvc/0.52.5 \
+    crate://crates.io/windows_i686_gnu/0.52.5 \
+    crate://crates.io/windows_i686_gnullvm/0.52.5 \
+    crate://crates.io/windows_i686_msvc/0.52.5 \
+    crate://crates.io/windows_x86_64_gnu/0.52.5 \
+    crate://crates.io/windows_x86_64_gnullvm/0.52.5 \
+    crate://crates.io/windows_x86_64_msvc/0.52.5 \
+    crate://crates.io/winnow/0.6.13 \
+"
+
+SRC_URI[ansi_term-0.11.0.sha256sum] = "ee49baf6cb617b853aa8d93bf420db2383fab46d314482ca2803b40d5fde979b"
+SRC_URI[ctor-0.1.26.sha256sum] = "6d2301688392eb071b0bf1a37be05c469d3cc4dbbd95df672fe28ab021e6a096"
+SRC_URI[difference-2.0.0.sha256sum] = "524cbf6897b527295dff137cec09ecf3a05f4fddffd7dfcd1585403449e74198"
+SRC_URI[equivalent-1.0.1.sha256sum] = "5443807d6dff69373d433ab9ef5378ad8df50ca6298caf15de6e52e24aaf54d5"
+SRC_URI[glob-0.3.1.sha256sum] = "d2fabcfbdc87f4758337ca535fb41a6d701b65693ce38287d856d1674551ec9b"
+SRC_URI[hashbrown-0.14.5.sha256sum] = "e5274423e17b7c9fc20b6e7e208532f9b19825d82dfd615708b70edd83df41f1"
+SRC_URI[indexmap-2.2.6.sha256sum] = "168fb715dda47215e360912c096649d23d58bf392ac62f73919e831745e40f26"
+SRC_URI[itoa-1.0.11.sha256sum] = "49f1f14873335454500d59611f1cf4a4b0f786f9ac11f4312a78e4cf2566695b"
+SRC_URI[libc-0.2.155.sha256sum] = "97b3888a4aecf77e811145cadf6eef5901f4782c53886191b2f693f24761847c"
+SRC_URI[memchr-2.7.4.sha256sum] = "78ca9ab1a0babb1e7d5695e3530886289c18cf2f87ec19a575a0abdce112e3a3"
+SRC_URI[output_vt100-0.1.3.sha256sum] = "628223faebab4e3e40667ee0b2336d34a5b960ff60ea743ddfdbcf7770bcfb66"
+SRC_URI[pretty_assertions-0.6.1.sha256sum] = "3f81e1644e1b54f5a68959a29aa86cde704219254669da328ecfdf6a1f09d427"
+SRC_URI[proc-macro2-1.0.85.sha256sum] = "22244ce15aa966053a896d1accb3a6e68469b97c7f33f284b99f0d576879fc23"
+SRC_URI[quote-1.0.36.sha256sum] = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
+SRC_URI[rustversion-1.0.17.sha256sum] = "955d28af4278de8121b7ebeb796b6a45735dc01436d898801014aced2773a3d6"
+SRC_URI[ryu-1.0.18.sha256sum] = "f3cb5ba0dc43242ce17de99c180e96db90b235b8a9fdc9543c96d2209116bd9f"
+SRC_URI[serde-1.0.203.sha256sum] = "7253ab4de971e72fb7be983802300c30b5a7f0c2e56fab8abfc6a214307c0094"
+SRC_URI[serde_derive-1.0.203.sha256sum] = "500cbc0ebeb6f46627f50f3f5811ccf6bf00643be300b4c3eabc0ef55dc5b5ba"
+SRC_URI[serde_json-1.0.117.sha256sum] = "455182ea6142b14f93f4bc5320a2b31c1f266b66a4a5c858b013302a5d8cbfc3"
+SRC_URI[serde_spanned-0.6.6.sha256sum] = "79e674e01f999af37c49f70a6ede167a8a60b2503e56c5599532a65baa5969a0"
+SRC_URI[static_assertions-1.1.0.sha256sum] = "a2eb9349b6444b326872e140eb1cf5e7c522154d69e7a0ffb0fb81c06b37543f"
 SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
-SRC_URI[syn-2.0.52.sha256sum] = "b699d15b36d1f02c3e7c69f8ffef53de37aefae075d8488d4ba1a7788d574a07"
-SRC_URI[tempfile-3.10.1.sha256sum] = "85b77fafb263dd9d05cbeac119526425676db3784113aa9295c88498cbf8bff1"
-SRC_URI[term-0.7.0.sha256sum] = "c59df8ac95d96ff9bede18eb7300b0fda5e5d8d90960e76f8e14ae765eedbf1f"
-SRC_URI[termios-0.3.3.sha256sum] = "411c5bf740737c7918b8b1fe232dca4dc9f8e754b8ad5e20966814001ed0ac6b"
-SRC_URI[thiserror-1.0.57.sha256sum] = "1e45bcbe8ed29775f228095caf2cd67af7a4ccf756ebff23a306bf3e8b47b24b"
-SRC_URI[thiserror-impl-1.0.57.sha256sum] = "a953cb265bef375dae3de6663da4d3804eee9682ea80d8e2542529b73c531c81"
-SRC_URI[thread_local-1.1.8.sha256sum] = "8b9ef9bad013ada3808854ceac7b46812a6465ba368859a37e2100283d2d719c"
-SRC_URI[time-0.3.34.sha256sum] = "c8248b6521bb14bc45b4067159b9b6ad792e2d6d754d6c41fb50e29fefe38749"
-SRC_URI[time-core-0.1.2.sha256sum] = "ef927ca75afb808a4d64dd374f00a2adf8d0fcff8e7b184af886c3c87ec4a3f3"
-SRC_URI[timer-0.2.0.sha256sum] = "31d42176308937165701f50638db1c31586f183f1aab416268216577aec7306b"
-SRC_URI[tuikit-0.5.0.sha256sum] = "5e19c6ab038babee3d50c8c12ff8b910bdb2196f62278776422f50390d8e53d8"
+SRC_URI[syn-2.0.66.sha256sum] = "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5"
+SRC_URI[termcolor-1.4.1.sha256sum] = "06794f8f6c5c898b3275aebefa6b8a1cb24cd2c6c79397ab15774837a0bc5755"
+SRC_URI[thiserror-1.0.61.sha256sum] = "c546c80d6be4bc6a00c0f01730c08df82eaa7a7a61f11d656526506112cc1709"
+SRC_URI[thiserror-impl-1.0.61.sha256sum] = "46c3384250002a6d5af4d114f2845d37b57521033f30d5c3f46c4d70e1197533"
+SRC_URI[toml-0.8.14.sha256sum] = "6f49eb2ab21d2f26bd6db7bf383edc527a7ebaee412d17af4d40fdccd442f335"
+SRC_URI[toml_datetime-0.6.6.sha256sum] = "4badfd56924ae69bcc9039335b2e017639ce3f9b001c393c1b2d1ef846ce2cbf"
+SRC_URI[toml_edit-0.22.14.sha256sum] = "f21c7aaf97f1bd9ca9d4f9e73b0a6c74bd5afef56f2bc931943a6e1c37e04e38"
+SRC_URI[trybuild-1.0.96.sha256sum] = "33a5f13f11071020bb12de7a16b925d2d58636175c20c11dc5f96cb64bb6c9b3"
 SRC_URI[unicode-ident-1.0.12.sha256sum] = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
-SRC_URI[unicode-segmentation-1.11.0.sha256sum] = "d4c87d22b6e3f4a18d4d40ef354e97c90fcb14dd91d7dc0aa9d8a1172ebf7202"
-SRC_URI[unicode-width-0.1.11.sha256sum] = "e51733f11c9c4f72aa0c160008246859e340b00807569a0da0e7a1079b27ba85"
-SRC_URI[utf8parse-0.2.1.sha256sum] = "711b9620af191e0cdc7468a8d14e709c3dcdb115b36f838e601583af800a370a"
-SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
-SRC_URI[version_check-0.9.4.sha256sum] = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
-SRC_URI[vte-0.11.1.sha256sum] = "f5022b5fbf9407086c180e9557be968742d839e68346af7792b8592489732197"
-SRC_URI[vte_generate_state_changes-0.1.1.sha256sum] = "d257817081c7dffcdbab24b9e62d2def62e2ff7d00b1c20062551e6cccc145ff"
-SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
-SRC_URI[wasm-bindgen-0.2.92.sha256sum] = "4be2531df63900aeb2bca0daaaddec08491ee64ceecbee5076636a3b026795a8"
-SRC_URI[wasm-bindgen-backend-0.2.92.sha256sum] = "614d787b966d3989fa7bb98a654e369c762374fd3213d212cfc0251257e747da"
-SRC_URI[wasm-bindgen-macro-0.2.92.sha256sum] = "a1f8823de937b71b9460c0c34e25f3da88250760bec0ebac694b49997550d726"
-SRC_URI[wasm-bindgen-macro-support-0.2.92.sha256sum] = "e94f17b526d0a461a191c78ea52bbce64071ed5c04c9ffe424dcb38f74171bb7"
-SRC_URI[wasm-bindgen-shared-0.2.92.sha256sum] = "af190c94f2773fdb3729c55b007a722abb5384da03bc0986df4c289bf5567e96"
 SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
+SRC_URI[winapi-util-0.1.8.sha256sum] = "4d4cc384e1e73b93bafa6fb4f1df8c41695c8a91cf9c4c64358067d15a7b6c6b"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
-SRC_URI[windows-core-0.52.0.sha256sum] = "33ab640c8d7e35bf8ba19b884ba838ceb4fba93a4e8c65a9059d08afcfc683d9"
 SRC_URI[windows-sys-0.52.0.sha256sum] = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
-SRC_URI[windows-targets-0.52.4.sha256sum] = "7dd37b7e5ab9018759f893a1952c9420d060016fc19a472b4bb20d1bdd694d1b"
-SRC_URI[windows_aarch64_gnullvm-0.52.4.sha256sum] = "bcf46cf4c365c6f2d1cc93ce535f2c8b244591df96ceee75d8e83deb70a9cac9"
-SRC_URI[windows_aarch64_msvc-0.52.4.sha256sum] = "da9f259dd3bcf6990b55bffd094c4f7235817ba4ceebde8e6d11cd0c5633b675"
-SRC_URI[windows_i686_gnu-0.52.4.sha256sum] = "b474d8268f99e0995f25b9f095bc7434632601028cf86590aea5c8a5cb7801d3"
-SRC_URI[windows_i686_msvc-0.52.4.sha256sum] = "1515e9a29e5bed743cb4415a9ecf5dfca648ce85ee42e15873c3cd8610ff8e02"
-SRC_URI[windows_x86_64_gnu-0.52.4.sha256sum] = "5eee091590e89cc02ad514ffe3ead9eb6b660aedca2183455434b93546371a03"
-SRC_URI[windows_x86_64_gnullvm-0.52.4.sha256sum] = "77ca79f2451b49fa9e2af39f0747fe999fcda4f5e241b2898624dca97a1f2177"
-SRC_URI[windows_x86_64_msvc-0.52.4.sha256sum] = "32b752e52a2da0ddfbdbcc6fceadfeede4c939ed16d13e648833a61dfb611ed8"
-SRC_URI[zerocopy-0.7.32.sha256sum] = "74d4d3961e53fa4c9a25a8637fc2bfaf2595b3d3ae34875568a5cf64787716be"
-SRC_URI[zerocopy-derive-0.7.32.sha256sum] = "9ce1b18ccd8e73a9321186f97e46f9f04b778851177567b1975109d26a08d2a6"
-# from rust/vendor/radix_trie/Cargo.lock
+SRC_URI[windows-targets-0.52.5.sha256sum] = "6f0713a46559409d202e70e28227288446bf7841d3211583a4b53e3f6d96e7eb"
+SRC_URI[windows_aarch64_gnullvm-0.52.5.sha256sum] = "7088eed71e8b8dda258ecc8bac5fb1153c5cffaf2578fc8ff5d61e23578d3263"
+SRC_URI[windows_aarch64_msvc-0.52.5.sha256sum] = "9985fd1504e250c615ca5f281c3f7a6da76213ebd5ccc9561496568a2752afb6"
+SRC_URI[windows_i686_gnu-0.52.5.sha256sum] = "88ba073cf16d5372720ec942a8ccbf61626074c6d4dd2e745299726ce8b89670"
+SRC_URI[windows_i686_gnullvm-0.52.5.sha256sum] = "87f4261229030a858f36b459e748ae97545d6f1ec60e5e0d6a3d32e0dc232ee9"
+SRC_URI[windows_i686_msvc-0.52.5.sha256sum] = "db3c2bf3d13d5b658be73463284eaf12830ac9a26a90c717b7f771dfe97487bf"
+SRC_URI[windows_x86_64_gnu-0.52.5.sha256sum] = "4e4246f76bdeff09eb48875a0fd3e2af6aada79d409d33011886d3e1581517d9"
+SRC_URI[windows_x86_64_gnullvm-0.52.5.sha256sum] = "852298e482cd67c356ddd9570386e2862b5673c85bd5f88df9ab6802b334c596"
+SRC_URI[windows_x86_64_msvc-0.52.5.sha256sum] = "bec47e5bfd1bff0eeaf6d8b485cc1074891a197ab4225d504cb7a1ab88b02bf0"
+SRC_URI[winnow-0.6.13.sha256sum] = "59b5e5f6c299a3c7890b876a2a587f3115162487e704907d9b6cd29473052ba1"
+# from rust/vendor/toml/Cargo.lock
 SRC_URI += " \
-    crate://crates.io/aho-corasick/0.5.3 \
-    crate://crates.io/atty/0.2.14 \
-    crate://crates.io/autocfg/1.0.1 \
-    crate://crates.io/bitflags/1.2.1 \
-    crate://crates.io/bstr/0.2.14 \
-    crate://crates.io/bumpalo/3.4.0 \
-    crate://crates.io/byteorder/1.3.4 \
-    crate://crates.io/cast/0.2.3 \
-    crate://crates.io/cfg-if/0.1.10 \
+    crate://crates.io/autocfg/1.1.0 \
+    crate://crates.io/hashbrown/0.12.3 \
+    crate://crates.io/indexmap/1.9.2 \
+    crate://crates.io/itoa/1.0.5 \
+    crate://crates.io/proc-macro2/1.0.50 \
+    crate://crates.io/quote/1.0.23 \
+    crate://crates.io/ryu/1.0.12 \
+    crate://crates.io/serde/1.0.152 \
+    crate://crates.io/serde_derive/1.0.152 \
+    crate://crates.io/serde_json/1.0.91 \
+    crate://crates.io/syn/1.0.107 \
+    crate://crates.io/unicode-ident/1.0.6 \
+"
+
+SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
+SRC_URI[hashbrown-0.12.3.sha256sum] = "8a9ee70c43aaf417c914396645a0fa852624801b24ebb7ae78fe8272889ac888"
+SRC_URI[indexmap-1.9.2.sha256sum] = "1885e79c1fc4b10f0e172c475f458b7f7b93061064d98c3293e98c5ba0c8b399"
+SRC_URI[itoa-1.0.5.sha256sum] = "fad582f4b9e86b6caa621cabeb0963332d92eea04729ab12892c2533951e6440"
+SRC_URI[proc-macro2-1.0.50.sha256sum] = "6ef7d57beacfaf2d8aee5937dab7b7f28de3cb8b1828479bb5de2a7106f2bae2"
+SRC_URI[quote-1.0.23.sha256sum] = "8856d8364d252a14d474036ea1358d63c9e6965c8e5c1885c18f73d70bff9c7b"
+SRC_URI[ryu-1.0.12.sha256sum] = "7b4b9743ed687d4b4bcedf9ff5eaa7398495ae14e61cba0a295704edbc7decde"
+SRC_URI[serde-1.0.152.sha256sum] = "bb7d1f0d3021d347a83e556fc4683dea2ea09d87bccdf88ff5c12545d89d5efb"
+SRC_URI[serde_derive-1.0.152.sha256sum] = "af487d118eecd09402d70a5d72551860e788df87b464af30e5ea6a38c75c541e"
+SRC_URI[serde_json-1.0.91.sha256sum] = "877c235533714907a8c2464236f5c4b2a17262ef1bd71f38f35ea592c8da6883"
+SRC_URI[syn-1.0.107.sha256sum] = "1f4064b5b16e03ae50984a5a8ed5d4f8803e6bc1fd170a3cda91a1be4b18e3f5"
+SRC_URI[unicode-ident-1.0.6.sha256sum] = "84a22b9f218b40614adcb3f4ff08b703773ad44fa9423e4e0d346d5db86e4ebc"
+# from rust/vendor/brotli/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/alloc-no-stdlib/2.0.4 \
+    crate://crates.io/alloc-stdlib/0.2.2 \
+    crate://crates.io/block-buffer/0.10.4 \
+    crate://crates.io/brotli-decompressor/5.0.0 \
     crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/clap/2.33.3 \
-    crate://crates.io/const_fn/0.4.2 \
-    crate://crates.io/criterion/0.3.3 \
-    crate://crates.io/criterion-plot/0.4.3 \
-    crate://crates.io/crossbeam-channel/0.5.0 \
-    crate://crates.io/crossbeam-deque/0.8.0 \
-    crate://crates.io/crossbeam-epoch/0.9.0 \
-    crate://crates.io/crossbeam-utils/0.8.0 \
-    crate://crates.io/csv/1.1.3 \
-    crate://crates.io/csv-core/0.1.10 \
-    crate://crates.io/either/1.6.1 \
-    crate://crates.io/endian-type/0.1.2 \
-    crate://crates.io/env_logger/0.3.5 \
-    crate://crates.io/fuchsia-cprng/0.1.1 \
-    crate://crates.io/half/1.6.0 \
-    crate://crates.io/hermit-abi/0.1.17 \
-    crate://crates.io/itertools/0.9.0 \
-    crate://crates.io/itoa/0.4.6 \
-    crate://crates.io/js-sys/0.3.45 \
-    crate://crates.io/kernel32-sys/0.2.2 \
-    crate://crates.io/lazy_static/1.4.0 \
-    crate://crates.io/libc/0.2.79 \
-    crate://crates.io/log/0.3.9 \
-    crate://crates.io/log/0.4.11 \
-    crate://crates.io/memchr/0.1.11 \
-    crate://crates.io/memchr/2.3.3 \
-    crate://crates.io/memoffset/0.5.6 \
-    crate://crates.io/nibble_vec/0.1.0 \
-    crate://crates.io/num-traits/0.2.12 \
-    crate://crates.io/num_cpus/1.13.0 \
-    crate://crates.io/oorandom/11.1.2 \
-    crate://crates.io/plotters/0.2.15 \
-    crate://crates.io/proc-macro2/1.0.24 \
-    crate://crates.io/quickcheck/0.4.1 \
-    crate://crates.io/quote/1.0.7 \
-    crate://crates.io/rand/0.3.23 \
-    crate://crates.io/rand/0.4.6 \
-    crate://crates.io/rand_core/0.3.1 \
-    crate://crates.io/rand_core/0.4.2 \
-    crate://crates.io/rayon/1.5.0 \
-    crate://crates.io/rayon-core/1.9.0 \
-    crate://crates.io/rdrand/0.4.0 \
-    crate://crates.io/regex/0.1.80 \
-    crate://crates.io/regex/1.4.1 \
-    crate://crates.io/regex-automata/0.1.9 \
-    crate://crates.io/regex-syntax/0.3.9 \
-    crate://crates.io/regex-syntax/0.6.20 \
+    crate://crates.io/cpufeatures/0.2.17 \
+    crate://crates.io/crypto-common/0.1.6 \
+    crate://crates.io/digest/0.10.7 \
+    crate://crates.io/generic-array/0.14.7 \
+    crate://crates.io/libc/0.2.172 \
+    crate://crates.io/sha2/0.10.9 \
+    crate://crates.io/typenum/1.18.0 \
+    crate://crates.io/version_check/0.9.5 \
+"
+
+SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
+SRC_URI[alloc-stdlib-0.2.2.sha256sum] = "94fb8275041c72129eb51b7d0322c29b8387a0386127718b096429201a5d6ece"
+SRC_URI[block-buffer-0.10.4.sha256sum] = "3078c7629b62d3f0439517fa394996acacc5cbc91c5a20d8c658e77abd503a71"
+SRC_URI[brotli-decompressor-5.0.0.sha256sum] = "874bb8112abecc98cbd6d81ea4fa7e94fb9449648c93cc89aa40c81c24d7de03"
+SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+SRC_URI[cpufeatures-0.2.17.sha256sum] = "59ed5838eebb26a2bb2e58f6d5b5316989ae9d08bab10e0e6d103e656d1b0280"
+SRC_URI[crypto-common-0.1.6.sha256sum] = "1bfb12502f3fc46cca1bb51ac28df9d618d813cdc3d2f25b9fe775a34af26bb3"
+SRC_URI[digest-0.10.7.sha256sum] = "9ed9a281f7bc9b7576e61468ba615a66a5c8cfdff42420a70aa82701a3b1e292"
+SRC_URI[generic-array-0.14.7.sha256sum] = "85649ca51fd72272d7821adaf274ad91c288277713d9c18820d8499a7ff69e9a"
+SRC_URI[libc-0.2.172.sha256sum] = "d750af042f7ef4f724306de029d18836c26c1765a54a6a3f094cbd23a7267ffa"
+SRC_URI[sha2-0.10.9.sha256sum] = "a7507d819769d01a365ab707794a4084392c824f54a7a6a7862f8c3d0892b283"
+SRC_URI[typenum-1.18.0.sha256sum] = "1dccffe3ce07af9386bfd29e80c0ab1a8205a2fc34e4bcd40364df902cfa8f3f"
+SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
+# from rust/vendor/psl/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/base-x/0.2.11 \
+    crate://crates.io/bumpalo/3.20.3 \
+    crate://crates.io/cfg-if/1.0.4 \
+    crate://crates.io/colored/2.2.0 \
+    crate://crates.io/const_fn/0.4.12 \
+    crate://crates.io/crossbeam-deque/0.8.6 \
+    crate://crates.io/crossbeam-epoch/0.9.18 \
+    crate://crates.io/crossbeam-utils/0.8.21 \
+    crate://crates.io/darling/0.10.2 \
+    crate://crates.io/darling_core/0.10.2 \
+    crate://crates.io/darling_macro/0.10.2 \
+    crate://crates.io/derive-new/0.5.9 \
+    crate://crates.io/derive_builder/0.9.0 \
+    crate://crates.io/derive_builder_core/0.9.0 \
+    crate://crates.io/discard/1.0.4 \
+    crate://crates.io/either/1.16.0 \
+    crate://crates.io/fnv/1.0.7 \
+    crate://crates.io/ident_case/1.0.1 \
+    crate://crates.io/itoa/1.0.18 \
+    crate://crates.io/lazy_static/1.5.0 \
+    crate://crates.io/libc/0.2.186 \
+    crate://crates.io/memchr/2.8.2 \
+    crate://crates.io/once_cell/1.21.4 \
+    crate://crates.io/proc-macro-hack/0.5.20+deprecated \
+    crate://crates.io/proc-macro2/1.0.106 \
+    crate://crates.io/psl-types/2.0.11 \
+    crate://crates.io/quote/1.0.46 \
+    crate://crates.io/rayon/1.12.0 \
+    crate://crates.io/rayon-core/1.13.0 \
+    crate://crates.io/rspec/1.0.0 \
     crate://crates.io/rustc_version/0.2.3 \
-    crate://crates.io/ryu/1.0.5 \
-    crate://crates.io/same-file/1.0.6 \
-    crate://crates.io/scopeguard/1.1.0 \
+    crate://crates.io/rustversion/1.0.22 \
     crate://crates.io/semver/0.9.0 \
     crate://crates.io/semver-parser/0.7.0 \
-    crate://crates.io/serde/1.0.117 \
-    crate://crates.io/serde_cbor/0.11.1 \
-    crate://crates.io/serde_derive/1.0.117 \
-    crate://crates.io/serde_json/1.0.59 \
-    crate://crates.io/serde_test/1.0.117 \
-    crate://crates.io/smallvec/1.4.2 \
-    crate://crates.io/syn/1.0.46 \
-    crate://crates.io/textwrap/0.11.0 \
-    crate://crates.io/thread-id/2.0.0 \
-    crate://crates.io/thread_local/0.2.7 \
-    crate://crates.io/tinytemplate/1.1.0 \
-    crate://crates.io/unicode-width/0.1.8 \
-    crate://crates.io/unicode-xid/0.2.1 \
-    crate://crates.io/utf8-ranges/0.1.3 \
-    crate://crates.io/walkdir/2.3.1 \
-    crate://crates.io/wasm-bindgen/0.2.68 \
-    crate://crates.io/wasm-bindgen-backend/0.2.68 \
-    crate://crates.io/wasm-bindgen-macro/0.2.68 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.68 \
-    crate://crates.io/wasm-bindgen-shared/0.2.68 \
-    crate://crates.io/web-sys/0.3.45 \
-    crate://crates.io/winapi/0.2.8 \
+    crate://crates.io/serde/1.0.228 \
+    crate://crates.io/serde_core/1.0.228 \
+    crate://crates.io/serde_derive/1.0.228 \
+    crate://crates.io/serde_json/1.0.150 \
+    crate://crates.io/sha1/0.6.1 \
+    crate://crates.io/sha1_smol/1.0.1 \
+    crate://crates.io/standback/0.2.17 \
+    crate://crates.io/stdweb/0.4.20 \
+    crate://crates.io/stdweb-derive/0.5.3 \
+    crate://crates.io/stdweb-internal-macros/0.2.9 \
+    crate://crates.io/stdweb-internal-runtime/0.1.5 \
+    crate://crates.io/strsim/0.9.3 \
+    crate://crates.io/syn/1.0.109 \
+    crate://crates.io/syn/2.0.118 \
+    crate://crates.io/time/0.2.27 \
+    crate://crates.io/time-macros/0.1.1 \
+    crate://crates.io/time-macros-impl/0.1.2 \
+    crate://crates.io/unicode-ident/1.0.24 \
+    crate://crates.io/version_check/0.9.5 \
+    crate://crates.io/wasm-bindgen/0.2.126 \
+    crate://crates.io/wasm-bindgen-macro/0.2.126 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.126 \
+    crate://crates.io/wasm-bindgen-shared/0.2.126 \
     crate://crates.io/winapi/0.3.9 \
-    crate://crates.io/winapi-build/0.1.1 \
     crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-    crate://crates.io/winapi-util/0.1.5 \
     crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+    crate://crates.io/windows-sys/0.59.0 \
+    crate://crates.io/windows-targets/0.52.6 \
+    crate://crates.io/windows_aarch64_gnullvm/0.52.6 \
+    crate://crates.io/windows_aarch64_msvc/0.52.6 \
+    crate://crates.io/windows_i686_gnu/0.52.6 \
+    crate://crates.io/windows_i686_gnullvm/0.52.6 \
+    crate://crates.io/windows_i686_msvc/0.52.6 \
+    crate://crates.io/windows_x86_64_gnu/0.52.6 \
+    crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
+    crate://crates.io/windows_x86_64_msvc/0.52.6 \
+    crate://crates.io/zmij/1.0.21 \
 "
 
-# from rust/vendor/bitflags/Cargo.lock
+SRC_URI[base-x-0.2.11.sha256sum] = "4cbbc9d0964165b47557570cce6c952866c2678457aca742aafc9fb771d30270"
+SRC_URI[bumpalo-3.20.3.sha256sum] = "72f5acc6cb2ba439de613abc23857ec3d78374d8ed5ac84e9d11336e87da8649"
+SRC_URI[cfg-if-1.0.4.sha256sum] = "9330f8b2ff13f34540b44e946ef35111825727b38d33286ef986142615121801"
+SRC_URI[colored-2.2.0.sha256sum] = "117725a109d387c937a1533ce01b450cbde6b88abceea8473c4d7a85853cda3c"
+SRC_URI[const_fn-0.4.12.sha256sum] = "413d67b29ef1021b4d60f4aa1e925ca031751e213832b4b1d588fae623c05c60"
+SRC_URI[crossbeam-deque-0.8.6.sha256sum] = "9dd111b7b7f7d55b72c0a6ae361660ee5853c9af73f70c3c2ef6858b950e2e51"
+SRC_URI[crossbeam-epoch-0.9.18.sha256sum] = "5b82ac4a3c2ca9c3460964f020e1402edd5753411d7737aa39c3714ad1b5420e"
+SRC_URI[crossbeam-utils-0.8.21.sha256sum] = "d0a5c400df2834b80a4c3327b3aad3a4c4cd4de0629063962b03235697506a28"
+SRC_URI[darling-0.10.2.sha256sum] = "0d706e75d87e35569db781a9b5e2416cff1236a47ed380831f959382ccd5f858"
+SRC_URI[darling_core-0.10.2.sha256sum] = "f0c960ae2da4de88a91b2d920c2a7233b400bc33cb28453a2987822d8392519b"
+SRC_URI[darling_macro-0.10.2.sha256sum] = "d9b5a2f4ac4969822c62224815d069952656cadc7084fdca9751e6d959189b72"
+SRC_URI[derive-new-0.5.9.sha256sum] = "3418329ca0ad70234b9735dc4ceed10af4df60eff9c8e7b06cb5e520d92c3535"
+SRC_URI[derive_builder-0.9.0.sha256sum] = "a2658621297f2cf68762a6f7dc0bb7e1ff2cfd6583daef8ee0fed6f7ec468ec0"
+SRC_URI[derive_builder_core-0.9.0.sha256sum] = "2791ea3e372c8495c0bc2033991d76b512cd799d07491fbd6890124db9458bef"
+SRC_URI[discard-1.0.4.sha256sum] = "212d0f5754cb6769937f4501cc0e67f4f4483c8d2c3e1e922ee9edbe4ab4c7c0"
+SRC_URI[either-1.16.0.sha256sum] = "91622ff5e7162018101f2fea40d6ebf4a78bbe5a49736a2020649edf9693679e"
+SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
+SRC_URI[ident_case-1.0.1.sha256sum] = "b9e0384b61958566e926dc50660321d12159025e767c18e043daf26b70104c39"
+SRC_URI[itoa-1.0.18.sha256sum] = "8f42a60cbdf9a97f5d2305f08a87dc4e09308d1276d28c869c684d7777685682"
+SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
+SRC_URI[libc-0.2.186.sha256sum] = "68ab91017fe16c622486840e4c83c9a37afeff978bd239b5293d61ece587de66"
+SRC_URI[memchr-2.8.2.sha256sum] = "88904434abc2901f197fe8cc55f0445e7ded921dba5911dad2e2b39b48e663c4"
+SRC_URI[once_cell-1.21.4.sha256sum] = "9f7c3e4beb33f85d45ae3e3a1792185706c8e16d043238c593331cc7cd313b50"
+SRC_URI[proc-macro-hack-0.5.20+deprecated.sha256sum] = "dc375e1527247fe1a97d8b7156678dfe7c1af2fc075c9a4db3690ecd2a148068"
+SRC_URI[proc-macro2-1.0.106.sha256sum] = "8fd00f0bb2e90d81d1044c2b32617f68fcb9fa3bb7640c23e9c748e53fb30934"
+SRC_URI[psl-types-2.0.11.sha256sum] = "33cb294fe86a74cbcf50d4445b37da762029549ebeea341421c7c70370f86cac"
+SRC_URI[quote-1.0.46.sha256sum] = "dfbc457d0c7a0759a614551b11a6409e5951f6c7537be1f1b7682b9ae9230368"
+SRC_URI[rayon-1.12.0.sha256sum] = "fb39b166781f92d482534ef4b4b1b2568f42613b53e5b6c160e24cfbfa30926d"
+SRC_URI[rayon-core-1.13.0.sha256sum] = "22e18b0f0062d30d4230b2e85ff77fdfe4326feb054b9783a3460d8435c8ab91"
+SRC_URI[rspec-1.0.0.sha256sum] = "89389e7c690310e855df3d9b507985ca0d323e2e766b2fedf369b02671e70e0a"
+SRC_URI[rustc_version-0.2.3.sha256sum] = "138e3e0acb6c9fb258b19b67cb8abd63c00679d2851805ea151465464fe9030a"
+SRC_URI[rustversion-1.0.22.sha256sum] = "b39cdef0fa800fc44525c84ccb54a029961a8215f9619753635a9c0d2538d46d"
+SRC_URI[semver-0.9.0.sha256sum] = "1d7eb9ef2c18661902cc47e535f9bc51b78acd254da71d375c2f6720d9a40403"
+SRC_URI[semver-parser-0.7.0.sha256sum] = "388a1df253eca08550bef6c72392cfe7c30914bf41df5269b68cbd6ff8f570a3"
+SRC_URI[serde-1.0.228.sha256sum] = "9a8e94ea7f378bd32cbbd37198a4a91436180c5bb472411e48b5ec2e2124ae9e"
+SRC_URI[serde_core-1.0.228.sha256sum] = "41d385c7d4ca58e59fc732af25c3983b67ac852c1a25000afe1175de458b67ad"
+SRC_URI[serde_derive-1.0.228.sha256sum] = "d540f220d3187173da220f885ab66608367b6574e925011a9353e4badda91d79"
+SRC_URI[serde_json-1.0.150.sha256sum] = "e8014e44b4736ed0538adeecded0fce2a272f22dc9578a7eb6b2d9993c74cfb9"
+SRC_URI[sha1-0.6.1.sha256sum] = "c1da05c97445caa12d05e848c4a4fcbbea29e748ac28f7e80e9b010392063770"
+SRC_URI[sha1_smol-1.0.1.sha256sum] = "bbfa15b3dddfee50a0fff136974b3e1bde555604ba463834a7eb7deb6417705d"
+SRC_URI[standback-0.2.17.sha256sum] = "e113fb6f3de07a243d434a56ec6f186dfd51cb08448239fe7bcae73f87ff28ff"
+SRC_URI[stdweb-0.4.20.sha256sum] = "d022496b16281348b52d0e30ae99e01a73d737b2f45d38fed4edf79f9325a1d5"
+SRC_URI[stdweb-derive-0.5.3.sha256sum] = "c87a60a40fccc84bef0652345bbbbbe20a605bf5d0ce81719fc476f5c03b50ef"
+SRC_URI[stdweb-internal-macros-0.2.9.sha256sum] = "58fa5ff6ad0d98d1ffa8cb115892b6e69d67799f6763e162a1c9db421dc22e11"
+SRC_URI[stdweb-internal-runtime-0.1.5.sha256sum] = "213701ba3370744dcd1a12960caa4843b3d68b4d1c0a5d575e0d65b2ee9d16c0"
+SRC_URI[strsim-0.9.3.sha256sum] = "6446ced80d6c486436db5c078dde11a9f73d42b57fb273121e160b84f63d894c"
+SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
+SRC_URI[syn-2.0.118.sha256sum] = "1b9ae57f904213ebb649ce6895b8a66c66f0203b9319718f69a5612a065b1422"
+SRC_URI[time-0.2.27.sha256sum] = "4752a97f8eebd6854ff91f1c1824cd6160626ac4bd44287f7f4ea2035a02a242"
+SRC_URI[time-macros-0.1.1.sha256sum] = "957e9c6e26f12cb6d0dd7fc776bb67a706312e7299aed74c8dd5b17ebb27e2f1"
+SRC_URI[time-macros-impl-0.1.2.sha256sum] = "fd3c141a1b43194f3f56a1411225df8646c55781d5f26db825b3d98507eb482f"
+SRC_URI[unicode-ident-1.0.24.sha256sum] = "e6e4313cd5fcd3dad5cafa179702e2b244f760991f45397d14d4ebf38247da75"
+SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
+SRC_URI[wasm-bindgen-0.2.126.sha256sum] = "4b067c0c11094aef6b7a801c1e34a26affafdf3d051dba08456b868789aaf9a4"
+SRC_URI[wasm-bindgen-macro-0.2.126.sha256sum] = "167ce5e579f6bcf889c4f7175a8a5a585de84e8ff93976ce393efa5f2837aab1"
+SRC_URI[wasm-bindgen-macro-support-0.2.126.sha256sum] = "f3997c7839262f4ef12cf90b818d6340c18e80f263f1a94bf157d0ec4420380e"
+SRC_URI[wasm-bindgen-shared-0.2.126.sha256sum] = "dc1b4cb0cc549fcf58d7dfc081778139b3d283a081644e833e84682ad71cea24"
+SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
+SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
+SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
+SRC_URI[windows-sys-0.59.0.sha256sum] = "1e38bc4d79ed67fd075bcc251a1c39b32a1776bbe92e5bef1f0bf1f8c531853b"
+SRC_URI[windows-targets-0.52.6.sha256sum] = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
+SRC_URI[windows_aarch64_gnullvm-0.52.6.sha256sum] = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
+SRC_URI[windows_aarch64_msvc-0.52.6.sha256sum] = "09ec2a7bb152e2252b53fa7803150007879548bc709c039df7627cabbd05d469"
+SRC_URI[windows_i686_gnu-0.52.6.sha256sum] = "8e9b5ad5ab802e97eb8e295ac6720e509ee4c243f69d781394014ebfe8bbfa0b"
+SRC_URI[windows_i686_gnullvm-0.52.6.sha256sum] = "0eee52d38c090b3caa76c563b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
+SRC_URI[windows_i686_msvc-0.52.6.sha256sum] = "240948bc05c5e7c6dabba28bf89d89ffce3e303022809e73deaefe4f6ec56c66"
+SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
+SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
+SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
+SRC_URI[zmij-1.0.21.sha256sum] = "b8848ee67ecc8aedbaf3e4122217aff892639231befc6a1b58d29fff4c2cabaa"
+# from rust/vendor/valuable/Cargo.lock
 SRC_URI += " \
-    crate://crates.io/arbitrary/1.4.1 \
-    crate://crates.io/bytemuck/1.23.0 \
-    crate://crates.io/bytemuck_derive/1.9.3 \
-    crate://crates.io/compiler_builtins/0.1.159 \
-    crate://crates.io/derive_arbitrary/1.4.1 \
-    crate://crates.io/equivalent/1.0.2 \
-    crate://crates.io/glob/0.3.2 \
-    crate://crates.io/hashbrown/0.15.3 \
-    crate://crates.io/indexmap/2.9.0 \
-    crate://crates.io/itoa/1.0.15 \
+    crate://crates.io/aho-corasick/1.1.3 \
+    crate://crates.io/atty/0.2.14 \
+    crate://crates.io/autocfg/1.4.0 \
+    crate://crates.io/bitflags/1.3.2 \
+    crate://crates.io/bumpalo/3.16.0 \
+    crate://crates.io/cast/0.3.0 \
+    crate://crates.io/cfg-if/1.0.0 \
+    crate://crates.io/clap/2.34.0 \
+    crate://crates.io/criterion/0.3.6 \
+    crate://crates.io/criterion-plot/0.4.5 \
+    crate://crates.io/crossbeam-deque/0.8.6 \
+    crate://crates.io/crossbeam-epoch/0.9.18 \
+    crate://crates.io/crossbeam-utils/0.8.21 \
+    crate://crates.io/csv/1.3.1 \
+    crate://crates.io/csv-core/0.1.11 \
+    crate://crates.io/either/1.13.0 \
+    crate://crates.io/half/1.8.3 \
+    crate://crates.io/hermit-abi/0.1.19 \
+    crate://crates.io/itertools/0.10.5 \
+    crate://crates.io/itoa/1.0.14 \
+    crate://crates.io/js-sys/0.3.76 \
+    crate://crates.io/lazy_static/1.5.0 \
+    crate://crates.io/libc/0.2.169 \
+    crate://crates.io/log/0.4.22 \
     crate://crates.io/memchr/2.7.4 \
-    crate://crates.io/proc-macro2/1.0.95 \
-    crate://crates.io/quote/1.0.40 \
-    crate://crates.io/rustc-std-workspace-core/1.0.1 \
-    crate://crates.io/rustversion/1.0.20 \
-    crate://crates.io/ryu/1.0.20 \
-    crate://crates.io/serde/1.0.219 \
-    crate://crates.io/serde_derive/1.0.219 \
-    crate://crates.io/serde_json/1.0.140 \
-    crate://crates.io/serde_spanned/0.6.8 \
-    crate://crates.io/serde_test/1.0.177 \
-    crate://crates.io/syn/2.0.101 \
-    crate://crates.io/target-triple/0.1.4 \
-    crate://crates.io/termcolor/1.4.1 \
-    crate://crates.io/toml/0.8.22 \
-    crate://crates.io/toml_datetime/0.6.9 \
-    crate://crates.io/toml_edit/0.22.26 \
-    crate://crates.io/toml_write/0.1.1 \
-    crate://crates.io/trybuild/1.0.105 \
-    crate://crates.io/unicode-ident/1.0.18 \
+    crate://crates.io/num-traits/0.2.19 \
+    crate://crates.io/once_cell/1.20.2 \
+    crate://crates.io/oorandom/11.1.4 \
+    crate://crates.io/plotters/0.3.7 \
+    crate://crates.io/plotters-backend/0.3.7 \
+    crate://crates.io/plotters-svg/0.3.7 \
+    crate://crates.io/proc-macro2/1.0.93 \
+    crate://crates.io/quote/1.0.38 \
+    crate://crates.io/rayon/1.10.0 \
+    crate://crates.io/rayon-core/1.12.1 \
+    crate://crates.io/regex/1.11.1 \
+    crate://crates.io/regex-automata/0.4.9 \
+    crate://crates.io/regex-syntax/0.8.5 \
+    crate://crates.io/ryu/1.0.18 \
+    crate://crates.io/same-file/1.0.6 \
+    crate://crates.io/serde/1.0.217 \
+    crate://crates.io/serde_cbor/0.11.2 \
+    crate://crates.io/serde_derive/1.0.217 \
+    crate://crates.io/serde_json/1.0.135 \
+    crate://crates.io/syn/2.0.96 \
+    crate://crates.io/textwrap/0.11.0 \
+    crate://crates.io/tinytemplate/1.2.1 \
+    crate://crates.io/unicode-ident/1.0.14 \
+    crate://crates.io/unicode-width/0.1.14 \
+    crate://crates.io/valuable-derive/0.1.1 \
+    crate://crates.io/walkdir/2.5.0 \
+    crate://crates.io/wasm-bindgen/0.2.99 \
+    crate://crates.io/wasm-bindgen-backend/0.2.99 \
+    crate://crates.io/wasm-bindgen-macro/0.2.99 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.99 \
+    crate://crates.io/wasm-bindgen-shared/0.2.99 \
+    crate://crates.io/web-sys/0.3.76 \
+    crate://crates.io/winapi/0.3.9 \
+    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
     crate://crates.io/winapi-util/0.1.9 \
+    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
     crate://crates.io/windows-sys/0.59.0 \
     crate://crates.io/windows-targets/0.52.6 \
     crate://crates.io/windows_aarch64_gnullvm/0.52.6 \
@@ -2012,42 +2288,69 @@ SRC_URI += " \
     crate://crates.io/windows_x86_64_gnu/0.52.6 \
     crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
     crate://crates.io/windows_x86_64_msvc/0.52.6 \
-    crate://crates.io/winnow/0.7.10 \
-    crate://crates.io/zerocopy/0.8.25 \
-    crate://crates.io/zerocopy-derive/0.8.25 \
 "
 
-SRC_URI[arbitrary-1.4.1.sha256sum] = "dde20b3d026af13f561bdd0f15edf01fc734f0dafcedbaf42bba506a9517f223"
-SRC_URI[bytemuck-1.23.0.sha256sum] = "9134a6ef01ce4b366b50689c94f82c14bc72bc5d0386829828a2e2752ef7958c"
-SRC_URI[bytemuck_derive-1.9.3.sha256sum] = "7ecc273b49b3205b83d648f0690daa588925572cc5063745bfe547fe7ec8e1a1"
-SRC_URI[compiler_builtins-0.1.159.sha256sum] = "448068da8f2326b2a0472353cb401dd8795a89c007ef30fff90f50706e862e72"
-SRC_URI[derive_arbitrary-1.4.1.sha256sum] = "30542c1ad912e0e3d22a1935c290e12e8a29d704a420177a31faad4a601a0800"
-SRC_URI[equivalent-1.0.2.sha256sum] = "877a4ace8713b0bcf2a4e7eec82529c029f1d0619886d18145fea96c3ffe5c0f"
-SRC_URI[glob-0.3.2.sha256sum] = "a8d1add55171497b4705a648c6b583acafb01d58050a51727785f0b2c8e0a2b2"
-SRC_URI[hashbrown-0.15.3.sha256sum] = "84b26c544d002229e640969970a2e74021aadf6e2f96372b9c58eff97de08eb3"
-SRC_URI[indexmap-2.9.0.sha256sum] = "cea70ddb795996207ad57735b50c5982d8844f38ba9ee5f1aedcfb708a2aa11e"
-SRC_URI[itoa-1.0.15.sha256sum] = "4a5f13b858c8d314ee3e8f639011f7ccefe71f97f96e50151fb991f267928e2c"
+SRC_URI[aho-corasick-1.1.3.sha256sum] = "8e60d3430d3a69478ad0993f19238d2df97c507009a52b3c10addcd7f6bcb916"
+SRC_URI[atty-0.2.14.sha256sum] = "d9b39be18770d11421cdb1b9947a45dd3f37e93092cbf377614828a319d5fee8"
+SRC_URI[autocfg-1.4.0.sha256sum] = "ace50bade8e6234aa140d9a2f552bbee1db4d353f69b8217bc503490fc1a9f26"
+SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
+SRC_URI[bumpalo-3.16.0.sha256sum] = "79296716171880943b8470b5f8d03aa55eb2e645a4874bdbb28adb49162e012c"
+SRC_URI[cast-0.3.0.sha256sum] = "37b2a672a2cb129a2e41c10b1224bb368f9f37a2b16b612598138befd7b37eb5"
+SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+SRC_URI[clap-2.34.0.sha256sum] = "a0610544180c38b88101fecf2dd634b174a62eef6946f84dfc6a7127512b381c"
+SRC_URI[criterion-0.3.6.sha256sum] = "b01d6de93b2b6c65e17c634a26653a29d107b3c98c607c765bf38d041531cd8f"
+SRC_URI[criterion-plot-0.4.5.sha256sum] = "2673cc8207403546f45f5fd319a974b1e6983ad1a3ee7e6041650013be041876"
+SRC_URI[crossbeam-deque-0.8.6.sha256sum] = "9dd111b7b7f7d55b72c0a6ae361660ee5853c9af73f70c3c2ef6858b950e2e51"
+SRC_URI[crossbeam-epoch-0.9.18.sha256sum] = "5b82ac4a3c2ca9c3460964f020e1402edd5753411d7737aa39c3714ad1b5420e"
+SRC_URI[crossbeam-utils-0.8.21.sha256sum] = "d0a5c400df2834b80a4c3327b3aad3a4c4cd4de0629063962b03235697506a28"
+SRC_URI[csv-1.3.1.sha256sum] = "acdc4883a9c96732e4733212c01447ebd805833b7275a73ca3ee080fd77afdaf"
+SRC_URI[csv-core-0.1.11.sha256sum] = "5efa2b3d7902f4b634a20cae3c9c4e6209dc4779feb6863329607560143efa70"
+SRC_URI[either-1.13.0.sha256sum] = "60b1af1c220855b6ceac025d3f6ecdd2b7c4894bfe9cd9bda4fbb4bc7c0d4cf0"
+SRC_URI[half-1.8.3.sha256sum] = "1b43ede17f21864e81be2fa654110bf1e793774238d86ef8555c37e6519c0403"
+SRC_URI[hermit-abi-0.1.19.sha256sum] = "62b467343b94ba476dcb2500d242dadbb39557df889310ac77c5d99100aaac33"
+SRC_URI[itertools-0.10.5.sha256sum] = "b0fd2260e829bddf4cb6ea802289de2f86d6a7a690192fbe91b3f46e0f2c8473"
+SRC_URI[itoa-1.0.14.sha256sum] = "d75a2a4b1b190afb6f5425f10f6a8f959d2ea0b9c2b1d79553551850539e4674"
+SRC_URI[js-sys-0.3.76.sha256sum] = "6717b6b5b077764fb5966237269cb3c64edddde4b14ce42647430a78ced9e7b7"
+SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
+SRC_URI[libc-0.2.169.sha256sum] = "b5aba8db14291edd000dfcc4d620c7ebfb122c613afb886ca8803fa4e128a20a"
+SRC_URI[log-0.4.22.sha256sum] = "a7a70ba024b9dc04c27ea2f0c0548feb474ec5c54bba33a7f72f873a39d07b24"
 SRC_URI[memchr-2.7.4.sha256sum] = "78ca9ab1a0babb1e7d5695e3530886289c18cf2f87ec19a575a0abdce112e3a3"
-SRC_URI[proc-macro2-1.0.95.sha256sum] = "02b3e5e68a3a1a02aad3ec490a98007cbc13c37cbe84a3cd7b8e406d76e7f778"
-SRC_URI[quote-1.0.40.sha256sum] = "1885c039570dc00dcb4ff087a89e185fd56bae234ddc7f056a945bf36467248d"
-SRC_URI[rustc-std-workspace-core-1.0.1.sha256sum] = "aa9c45b374136f52f2d6311062c7146bff20fec063c3f5d46a410bd937746955"
-SRC_URI[rustversion-1.0.20.sha256sum] = "eded382c5f5f786b989652c49544c4877d9f015cc22e145a5ea8ea66c2921cd2"
-SRC_URI[ryu-1.0.20.sha256sum] = "28d3b2b1366ec20994f1fd18c3c594f05c5dd4bc44d8bb0c1c632c8d6829481f"
-SRC_URI[serde-1.0.219.sha256sum] = "5f0e2c6ed6606019b4e29e69dbaba95b11854410e5347d525002456dbbb786b6"
-SRC_URI[serde_derive-1.0.219.sha256sum] = "5b0276cf7f2c73365f7157c8123c21cd9a50fbbd844757af28ca1f5925fc2a00"
-SRC_URI[serde_json-1.0.140.sha256sum] = "20068b6e96dc6c9bd23e01df8827e6c7e1f2fddd43c21810382803c136b99373"
-SRC_URI[serde_spanned-0.6.8.sha256sum] = "87607cb1398ed59d48732e575a4c28a7a8ebf2454b964fe3f224f2afc07909e1"
-SRC_URI[serde_test-1.0.177.sha256sum] = "7f901ee573cab6b3060453d2d5f0bae4e6d628c23c0a962ff9b5f1d7c8d4f1ed"
-SRC_URI[syn-2.0.101.sha256sum] = "8ce2b7fc941b3a24138a0a7cf8e858bfc6a992e7978a068a5c760deb0ed43caf"
-SRC_URI[target-triple-0.1.4.sha256sum] = "1ac9aa371f599d22256307c24a9d748c041e548cbf599f35d890f9d365361790"
-SRC_URI[termcolor-1.4.1.sha256sum] = "06794f8f6c5c898b3275aebefa6b8a1cb24cd2c6c79397ab15774837a0bc5755"
-SRC_URI[toml-0.8.22.sha256sum] = "05ae329d1f08c4d17a59bed7ff5b5a769d062e64a62d34a3261b219e62cd5aae"
-SRC_URI[toml_datetime-0.6.9.sha256sum] = "3da5db5a963e24bc68be8b17b6fa82814bb22ee8660f192bb182771d498f09a3"
-SRC_URI[toml_edit-0.22.26.sha256sum] = "310068873db2c5b3e7659d2cc35d21855dbafa50d1ce336397c666e3cb08137e"
-SRC_URI[toml_write-0.1.1.sha256sum] = "bfb942dfe1d8e29a7ee7fcbde5bd2b9a25fb89aa70caea2eba3bee836ff41076"
-SRC_URI[trybuild-1.0.105.sha256sum] = "1c9bf9513a2f4aeef5fdac8677d7d349c79fdbcc03b9c86da6e9d254f1e43be2"
-SRC_URI[unicode-ident-1.0.18.sha256sum] = "5a5f39404a5da50712a4c1eecf25e90dd62b613502b7e925fd4e4d19b5c96512"
+SRC_URI[num-traits-0.2.19.sha256sum] = "071dfc062690e90b734c0b2273ce72ad0ffa95f0c74596bc250dcfd960262841"
+SRC_URI[once_cell-1.20.2.sha256sum] = "1261fe7e33c73b354eab43b1273a57c8f967d0391e80353e51f764ac02cf6775"
+SRC_URI[oorandom-11.1.4.sha256sum] = "b410bbe7e14ab526a0e86877eb47c6996a2bd7746f027ba551028c925390e4e9"
+SRC_URI[plotters-0.3.7.sha256sum] = "5aeb6f403d7a4911efb1e33402027fc44f29b5bf6def3effcc22d7bb75f2b747"
+SRC_URI[plotters-backend-0.3.7.sha256sum] = "df42e13c12958a16b3f7f4386b9ab1f3e7933914ecea48da7139435263a4172a"
+SRC_URI[plotters-svg-0.3.7.sha256sum] = "51bae2ac328883f7acdfea3d66a7c35751187f870bc81f94563733a154d7a670"
+SRC_URI[proc-macro2-1.0.93.sha256sum] = "60946a68e5f9d28b0dc1c21bb8a97ee7d018a8b322fa57838ba31cc878e22d99"
+SRC_URI[quote-1.0.38.sha256sum] = "0e4dccaaaf89514f546c693ddc140f729f958c247918a13380cccc6078391acc"
+SRC_URI[rayon-1.10.0.sha256sum] = "b418a60154510ca1a002a752ca9714984e21e4241e804d32555251faf8b78ffa"
+SRC_URI[rayon-core-1.12.1.sha256sum] = "1465873a3dfdaa8ae7cb14b4383657caab0b3e8a0aa9ae8e04b044854c8dfce2"
+SRC_URI[regex-1.11.1.sha256sum] = "b544ef1b4eac5dc2db33ea63606ae9ffcfac26c1416a2806ae0bf5f56b201191"
+SRC_URI[regex-automata-0.4.9.sha256sum] = "809e8dc61f6de73b46c85f4c96486310fe304c434cfa43669d7b40f711150908"
+SRC_URI[regex-syntax-0.8.5.sha256sum] = "2b15c43186be67a4fd63bee50d0303afffcef381492ebe2c5d87f324e1b8815c"
+SRC_URI[ryu-1.0.18.sha256sum] = "f3cb5ba0dc43242ce17de99c180e96db90b235b8a9fdc9543c96d2209116bd9f"
+SRC_URI[same-file-1.0.6.sha256sum] = "93fc1dc3aaa9bfed95e02e6eadabb4baf7e3078b0bd1b4d7b6b0b68378900502"
+SRC_URI[serde-1.0.217.sha256sum] = "02fc4265df13d6fa1d00ecff087228cc0a2b5f3c0e87e258d8b94a156e984c70"
+SRC_URI[serde_cbor-0.11.2.sha256sum] = "2bef2ebfde456fb76bbcf9f59315333decc4fda0b2b44b420243c11e0f5ec1f5"
+SRC_URI[serde_derive-1.0.217.sha256sum] = "5a9bf7cf98d04a2b28aead066b7496853d4779c9cc183c440dbac457641e19a0"
+SRC_URI[serde_json-1.0.135.sha256sum] = "2b0d7ba2887406110130a978386c4e1befb98c674b4fba677954e4db976630d9"
+SRC_URI[syn-2.0.96.sha256sum] = "d5d0adab1ae378d7f53bdebc67a39f1f151407ef230f0ce2883572f5d8985c80"
+SRC_URI[textwrap-0.11.0.sha256sum] = "d326610f408c7a4eb6f51c37c330e496b08506c9457c9d34287ecc38809fb060"
+SRC_URI[tinytemplate-1.2.1.sha256sum] = "be4d6b5f19ff7664e8c98d03e2139cb510db9b0a60b55f8e8709b689d939b6bc"
+SRC_URI[unicode-ident-1.0.14.sha256sum] = "adb9e6ca4f869e1180728b7950e35922a7fc6397f7b641499e8f3ef06e50dc83"
+SRC_URI[unicode-width-0.1.14.sha256sum] = "7dd6e30e90baa6f72411720665d41d89b9a3d039dc45b8faea1ddd07f617f6af"
+SRC_URI[valuable-derive-0.1.1.sha256sum] = "4e3a32a9bcc0f6c6ccfd5b27bcf298c58e753bcc9eeff268157a303393183a6d"
+SRC_URI[walkdir-2.5.0.sha256sum] = "29790946404f91d9c5d06f9874efddea1dc06c5efe94541a7d6863108e3a5e4b"
+SRC_URI[wasm-bindgen-0.2.99.sha256sum] = "a474f6281d1d70c17ae7aa6a613c87fce69a127e2624002df63dcb39d6cf6396"
+SRC_URI[wasm-bindgen-backend-0.2.99.sha256sum] = "5f89bb38646b4f81674e8f5c3fb81b562be1fd936d84320f3264486418519c79"
+SRC_URI[wasm-bindgen-macro-0.2.99.sha256sum] = "2cc6181fd9a7492eef6fef1f33961e3695e4579b9872a6f7c83aee556666d4fe"
+SRC_URI[wasm-bindgen-macro-support-0.2.99.sha256sum] = "30d7a95b763d3c45903ed6c81f156801839e5ee968bb07e534c44df0fcd330c2"
+SRC_URI[wasm-bindgen-shared-0.2.99.sha256sum] = "943aab3fdaaa029a6e0271b35ea10b72b943135afe9bffca82384098ad0e06a6"
+SRC_URI[web-sys-0.3.76.sha256sum] = "04dd7223427d52553d3702c004d3b2fe07c148165faa56313cb00211e31c12bc"
+SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
+SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
 SRC_URI[winapi-util-0.1.9.sha256sum] = "cf221c93e13a30d793f7645a0e7762c55d169dbb0a49671918a2319d289b10bb"
+SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
 SRC_URI[windows-sys-0.59.0.sha256sum] = "1e38bc4d79ed67fd075bcc251a1c39b32a1776bbe92e5bef1f0bf1f8c531853b"
 SRC_URI[windows-targets-0.52.6.sha256sum] = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
 SRC_URI[windows_aarch64_gnullvm-0.52.6.sha256sum] = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
@@ -2058,9 +2361,6 @@ SRC_URI[windows_i686_msvc-0.52.6.sha256sum] = "240948bc05c5e7c6dabba28bf89d89ffc
 SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
 SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
 SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
-SRC_URI[winnow-0.7.10.sha256sum] = "c06928c8748d81b05c9be96aad92e1b6ff01833332f281e8cfca3be4b35fc9ec"
-SRC_URI[zerocopy-0.8.25.sha256sum] = "a1702d9583232ddb9174e01bb7c15a2ab8fb1bc6f227aa1233858c351a3ba0cb"
-SRC_URI[zerocopy-derive-0.8.25.sha256sum] = "28a6e20d751156648aa063f3800b706ee209a32c0b4d9f24be3d980b01be55ef"
 # from rust/vendor/phf_generator/Cargo.lock
 SRC_URI += " \
     crate://crates.io/atty/0.2.14 \
@@ -2213,230 +2513,137 @@ SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
 SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
-# from rust/vendor/anstyle/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/lexopt/0.3.0 \
-"
-
-SRC_URI[lexopt-0.3.0.sha256sum] = "baff4b617f7df3d896f97fe922b64817f6cd9a756bb81d40f8883f2f66dcb401"
-# from rust/vendor/alloc-stdlib/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/alloc-no-stdlib/2.0.4 \
-"
-
-SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
-# from rust/vendor/asn1-rs-0.6.2/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/asn1-rs-derive/0.5.1 \
-    crate://crates.io/asn1-rs-impl/0.2.0 \
-    crate://crates.io/autocfg/1.3.0 \
-    crate://crates.io/base64/0.22.1 \
-    crate://crates.io/bitvec/1.0.1 \
-    crate://crates.io/colored/2.1.0 \
-    crate://crates.io/cookie-factory/0.3.3 \
-    crate://crates.io/deranged/0.3.11 \
-    crate://crates.io/displaydoc/0.2.5 \
-    crate://crates.io/equivalent/1.0.1 \
-    crate://crates.io/funty/2.0.0 \
-    crate://crates.io/futures/0.3.30 \
-    crate://crates.io/futures-channel/0.3.30 \
-    crate://crates.io/futures-core/0.3.30 \
-    crate://crates.io/futures-executor/0.3.30 \
-    crate://crates.io/futures-io/0.3.30 \
-    crate://crates.io/futures-macro/0.3.30 \
-    crate://crates.io/futures-sink/0.3.30 \
-    crate://crates.io/futures-task/0.3.30 \
-    crate://crates.io/futures-util/0.3.30 \
-    crate://crates.io/glob/0.3.1 \
-    crate://crates.io/hashbrown/0.14.5 \
-    crate://crates.io/hex-literal/0.4.1 \
-    crate://crates.io/indexmap/2.2.6 \
-    crate://crates.io/itoa/1.0.11 \
-    crate://crates.io/lazy_static/1.5.0 \
-    crate://crates.io/memchr/2.7.4 \
-    crate://crates.io/minimal-lexical/0.2.1 \
-    crate://crates.io/nom/7.1.3 \
-    crate://crates.io/num-bigint/0.4.6 \
-    crate://crates.io/num-conv/0.1.0 \
-    crate://crates.io/num-integer/0.1.46 \
-    crate://crates.io/num-traits/0.2.19 \
-    crate://crates.io/pem/3.0.4 \
-    crate://crates.io/pin-project-lite/0.2.14 \
-    crate://crates.io/pin-utils/0.1.0 \
-    crate://crates.io/powerfmt/0.2.0 \
-    crate://crates.io/proc-macro2/1.0.86 \
-    crate://crates.io/quote/1.0.36 \
-    crate://crates.io/radium/0.7.0 \
-    crate://crates.io/rusticata-macros/4.1.0 \
-    crate://crates.io/ryu/1.0.18 \
-    crate://crates.io/serde/1.0.204 \
-    crate://crates.io/serde_derive/1.0.204 \
-    crate://crates.io/serde_json/1.0.121 \
-    crate://crates.io/serde_spanned/0.6.7 \
-    crate://crates.io/slab/0.4.9 \
-    crate://crates.io/syn/2.0.72 \
-    crate://crates.io/synstructure/0.13.1 \
-    crate://crates.io/tap/1.0.1 \
-    crate://crates.io/termcolor/1.4.1 \
-    crate://crates.io/thiserror/1.0.63 \
-    crate://crates.io/thiserror-impl/1.0.63 \
-    crate://crates.io/time/0.3.36 \
-    crate://crates.io/time-core/0.1.2 \
-    crate://crates.io/time-macros/0.2.18 \
-    crate://crates.io/toml/0.8.17 \
-    crate://crates.io/toml_datetime/0.6.8 \
-    crate://crates.io/toml_edit/0.22.18 \
-    crate://crates.io/trybuild/1.0.98 \
-    crate://crates.io/unicode-ident/1.0.12 \
-    crate://crates.io/winapi-util/0.1.8 \
-    crate://crates.io/windows-sys/0.48.0 \
-    crate://crates.io/windows-sys/0.52.0 \
-    crate://crates.io/windows-targets/0.48.5 \
-    crate://crates.io/windows-targets/0.52.6 \
-    crate://crates.io/windows_aarch64_gnullvm/0.48.5 \
-    crate://crates.io/windows_aarch64_gnullvm/0.52.6 \
-    crate://crates.io/windows_aarch64_msvc/0.48.5 \
-    crate://crates.io/windows_aarch64_msvc/0.52.6 \
-    crate://crates.io/windows_i686_gnu/0.48.5 \
-    crate://crates.io/windows_i686_gnu/0.52.6 \
-    crate://crates.io/windows_i686_gnullvm/0.52.6 \
-    crate://crates.io/windows_i686_msvc/0.48.5 \
-    crate://crates.io/windows_i686_msvc/0.52.6 \
-    crate://crates.io/windows_x86_64_gnu/0.48.5 \
-    crate://crates.io/windows_x86_64_gnu/0.52.6 \
-    crate://crates.io/windows_x86_64_gnullvm/0.48.5 \
-    crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
-    crate://crates.io/windows_x86_64_msvc/0.48.5 \
-    crate://crates.io/windows_x86_64_msvc/0.52.6 \
-    crate://crates.io/winnow/0.6.16 \
-    crate://crates.io/wyz/0.5.1 \
-"
-
-SRC_URI[asn1-rs-derive-0.5.1.sha256sum] = "965c2d33e53cb6b267e148a4cb0760bc01f4904c1cd4bb4002a085bb016d1490"
-SRC_URI[asn1-rs-impl-0.2.0.sha256sum] = "7b18050c2cd6fe86c3a76584ef5e0baf286d038cda203eb6223df2cc413565f7"
-SRC_URI[autocfg-1.3.0.sha256sum] = "0c4b4d0bd25bd0b74681c0ad21497610ce1b7c91b1022cd21c80c6fbdd9476b0"
-SRC_URI[base64-0.22.1.sha256sum] = "72b3254f16251a8381aa12e40e3c4d2f0199f8c6508fbecb9d91f575e0fbb8c6"
-SRC_URI[bitvec-1.0.1.sha256sum] = "1bc2832c24239b0141d5674bb9174f9d68a8b5b3f2753311927c172ca46f7e9c"
-SRC_URI[colored-2.1.0.sha256sum] = "cbf2150cce219b664a8a70df7a1f933836724b503f8a413af9365b4dcc4d90b8"
-SRC_URI[cookie-factory-0.3.3.sha256sum] = "9885fa71e26b8ab7855e2ec7cae6e9b380edff76cd052e07c683a0319d51b3a2"
-SRC_URI[deranged-0.3.11.sha256sum] = "b42b6fa04a440b495c8b04d0e71b707c585f83cb9cb28cf8cd0d976c315e31b4"
-SRC_URI[displaydoc-0.2.5.sha256sum] = "97369cbbc041bc366949bc74d34658d6cda5621039731c6310521892a3a20ae0"
-SRC_URI[equivalent-1.0.1.sha256sum] = "5443807d6dff69373d433ab9ef5378ad8df50ca6298caf15de6e52e24aaf54d5"
-SRC_URI[funty-2.0.0.sha256sum] = "e6d5a32815ae3f33302d95fdcb2ce17862f8c65363dcfd29360480ba1001fc9c"
-SRC_URI[futures-0.3.30.sha256sum] = "645c6916888f6cb6350d2550b80fb63e734897a8498abe35cfb732b6487804b0"
-SRC_URI[futures-channel-0.3.30.sha256sum] = "eac8f7d7865dcb88bd4373ab671c8cf4508703796caa2b1985a9ca867b3fcb78"
-SRC_URI[futures-core-0.3.30.sha256sum] = "dfc6580bb841c5a68e9ef15c77ccc837b40a7504914d52e47b8b0e9bbda25a1d"
-SRC_URI[futures-executor-0.3.30.sha256sum] = "a576fc72ae164fca6b9db127eaa9a9dda0d61316034f33a0a0d4eda41f02b01d"
-SRC_URI[futures-io-0.3.30.sha256sum] = "a44623e20b9681a318efdd71c299b6b222ed6f231972bfe2f224ebad6311f0c1"
-SRC_URI[futures-macro-0.3.30.sha256sum] = "87750cf4b7a4c0625b1529e4c543c2182106e4dedc60a2a6455e00d212c489ac"
-SRC_URI[futures-sink-0.3.30.sha256sum] = "9fb8e00e87438d937621c1c6269e53f536c14d3fbd6a042bb24879e57d474fb5"
-SRC_URI[futures-task-0.3.30.sha256sum] = "38d84fa142264698cdce1a9f9172cf383a0c82de1bddcf3092901442c4097004"
-SRC_URI[futures-util-0.3.30.sha256sum] = "3d6401deb83407ab3da39eba7e33987a73c3df0c82b4bb5813ee871c19c41d48"
-SRC_URI[glob-0.3.1.sha256sum] = "d2fabcfbdc87f4758337ca535fb41a6d701b65693ce38287d856d1674551ec9b"
-SRC_URI[hashbrown-0.14.5.sha256sum] = "e5274423e17b7c9fc20b6e7e208532f9b19825d82dfd615708b70edd83df41f1"
-SRC_URI[hex-literal-0.4.1.sha256sum] = "6fe2267d4ed49bc07b63801559be28c718ea06c4738b7a03c94df7386d2cde46"
-SRC_URI[indexmap-2.2.6.sha256sum] = "168fb715dda47215e360912c096649d23d58bf392ac62f73919e831745e40f26"
-SRC_URI[itoa-1.0.11.sha256sum] = "49f1f14873335454500d59611f1cf4a4b0f786f9ac11f4312a78e4cf2566695b"
-SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
-SRC_URI[memchr-2.7.4.sha256sum] = "78ca9ab1a0babb1e7d5695e3530886289c18cf2f87ec19a575a0abdce112e3a3"
-SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
-SRC_URI[nom-7.1.3.sha256sum] = "d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
-SRC_URI[num-bigint-0.4.6.sha256sum] = "a5e44f723f1133c9deac646763579fdb3ac745e418f2a7af9cd0c431da1f20b9"
-SRC_URI[num-conv-0.1.0.sha256sum] = "51d515d32fb182ee37cda2ccdcb92950d6a3c2893aa280e540671c2cd0f3b1d9"
-SRC_URI[num-integer-0.1.46.sha256sum] = "7969661fd2958a5cb096e56c8e1ad0444ac2bbcd0061bd28660485a44879858f"
-SRC_URI[num-traits-0.2.19.sha256sum] = "071dfc062690e90b734c0b2273ce72ad0ffa95f0c74596bc250dcfd960262841"
-SRC_URI[pem-3.0.4.sha256sum] = "8e459365e590736a54c3fa561947c84837534b8e9af6fc5bf781307e82658fae"
-SRC_URI[pin-project-lite-0.2.14.sha256sum] = "bda66fc9667c18cb2758a2ac84d1167245054bcf85d5d1aaa6923f45801bdd02"
-SRC_URI[pin-utils-0.1.0.sha256sum] = "8b870d8c151b6f2fb93e84a13146138f05d02ed11c7e7c54f8826aaaf7c9f184"
-SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
-SRC_URI[proc-macro2-1.0.86.sha256sum] = "5e719e8df665df0d1c8fbfd238015744736151d4445ec0836b8e628aae103b77"
-SRC_URI[quote-1.0.36.sha256sum] = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
-SRC_URI[radium-0.7.0.sha256sum] = "dc33ff2d4973d518d823d61aa239014831e521c75da58e3df4840d3f47749d09"
-SRC_URI[rusticata-macros-4.1.0.sha256sum] = "faf0c4a6ece9950b9abdb62b1cfcf2a68b3b67a10ba445b3bb85be2a293d0632"
-SRC_URI[ryu-1.0.18.sha256sum] = "f3cb5ba0dc43242ce17de99c180e96db90b235b8a9fdc9543c96d2209116bd9f"
-SRC_URI[serde-1.0.204.sha256sum] = "bc76f558e0cbb2a839d37354c575f1dc3fdc6546b5be373ba43d95f231bf7c12"
-SRC_URI[serde_derive-1.0.204.sha256sum] = "e0cd7e117be63d3c3678776753929474f3b04a43a080c744d6b0ae2a8c28e222"
-SRC_URI[serde_json-1.0.121.sha256sum] = "4ab380d7d9f22ef3f21ad3e6c1ebe8e4fc7a2000ccba2e4d71fc96f15b2cb609"
-SRC_URI[serde_spanned-0.6.7.sha256sum] = "eb5b1b31579f3811bf615c144393417496f152e12ac8b7663bf664f4a815306d"
-SRC_URI[slab-0.4.9.sha256sum] = "8f92a496fb766b417c996b9c5e57daf2f7ad3b0bebe1ccfca4856390e3d3bb67"
-SRC_URI[syn-2.0.72.sha256sum] = "dc4b9b9bf2add8093d3f2c0204471e951b2285580335de42f9d2534f3ae7a8af"
-SRC_URI[synstructure-0.13.1.sha256sum] = "c8af7666ab7b6390ab78131fb5b0fce11d6b7a6951602017c35fa82800708971"
-SRC_URI[tap-1.0.1.sha256sum] = "55937e1799185b12863d447f42597ed69d9928686b8d88a1df17376a097d8369"
-SRC_URI[termcolor-1.4.1.sha256sum] = "06794f8f6c5c898b3275aebefa6b8a1cb24cd2c6c79397ab15774837a0bc5755"
-SRC_URI[thiserror-1.0.63.sha256sum] = "c0342370b38b6a11b6cc11d6a805569958d54cfa061a29969c3b5ce2ea405724"
-SRC_URI[thiserror-impl-1.0.63.sha256sum] = "a4558b58466b9ad7ca0f102865eccc95938dca1a74a856f2b57b6629050da261"
-SRC_URI[time-0.3.36.sha256sum] = "5dfd88e563464686c916c7e46e623e520ddc6d79fa6641390f2e3fa86e83e885"
-SRC_URI[time-core-0.1.2.sha256sum] = "ef927ca75afb808a4d64dd374f00a2adf8d0fcff8e7b184af886c3c87ec4a3f3"
-SRC_URI[time-macros-0.2.18.sha256sum] = "3f252a68540fde3a3877aeea552b832b40ab9a69e318efd078774a01ddee1ccf"
-SRC_URI[toml-0.8.17.sha256sum] = "7a44eede9b727419af8095cb2d72fab15487a541f54647ad4414b34096ee4631"
-SRC_URI[toml_datetime-0.6.8.sha256sum] = "0dd7358ecb8fc2f8d014bf86f6f638ce72ba252a2c3a2572f2a795f1d23efb41"
-SRC_URI[toml_edit-0.22.18.sha256sum] = "1490595c74d930da779e944f5ba2ecdf538af67df1a9848cbd156af43c1b7cf0"
-SRC_URI[trybuild-1.0.98.sha256sum] = "b55265878356bdd85c9baa15859c87de93b2bf1f33acf752040a561e4a228f62"
-SRC_URI[unicode-ident-1.0.12.sha256sum] = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
-SRC_URI[winapi-util-0.1.8.sha256sum] = "4d4cc384e1e73b93bafa6fb4f1df8c41695c8a91cf9c4c64358067d15a7b6c6b"
-SRC_URI[windows-sys-0.48.0.sha256sum] = "677d2418bec65e3338edb076e806bc1ec15693c5d0104683f2efe857f61056a9"
-SRC_URI[windows-sys-0.52.0.sha256sum] = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
-SRC_URI[windows-targets-0.48.5.sha256sum] = "9a2fa6e2155d7247be68c096456083145c183cbbbc2764150dda45a87197940c"
-SRC_URI[windows-targets-0.52.6.sha256sum] = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
-SRC_URI[windows_aarch64_gnullvm-0.48.5.sha256sum] = "2b38e32f0abccf9987a4e3079dfb67dcd799fb61361e53e2882c3cbaf0d905d8"
-SRC_URI[windows_aarch64_gnullvm-0.52.6.sha256sum] = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
-SRC_URI[windows_aarch64_msvc-0.48.5.sha256sum] = "dc35310971f3b2dbbf3f0690a219f40e2d9afcf64f9ab7cc1be722937c26b4bc"
-SRC_URI[windows_aarch64_msvc-0.52.6.sha256sum] = "09ec2a7bb152e2252b53fa7803150007879548bc709c039df7627cabbd05d469"
-SRC_URI[windows_i686_gnu-0.48.5.sha256sum] = "a75915e7def60c94dcef72200b9a8e58e5091744960da64ec734a6c6e9b3743e"
-SRC_URI[windows_i686_gnu-0.52.6.sha256sum] = "8e9b5ad5ab802e97eb8e295ac6720e509ee4c243f69d781394014ebfe8bbfa0b"
-SRC_URI[windows_i686_gnullvm-0.52.6.sha256sum] = "0eee52d38c090b3caa76c563b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
-SRC_URI[windows_i686_msvc-0.48.5.sha256sum] = "8f55c233f70c4b27f66c523580f78f1004e8b5a8b659e05a4eb49d4166cca406"
-SRC_URI[windows_i686_msvc-0.52.6.sha256sum] = "240948bc05c5e7c6dabba28bf89d89ffce3e303022809e73deaefe4f6ec56c66"
-SRC_URI[windows_x86_64_gnu-0.48.5.sha256sum] = "53d40abd2583d23e4718fddf1ebec84dbff8381c07cae67ff7768bbf19c6718e"
-SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
-SRC_URI[windows_x86_64_gnullvm-0.48.5.sha256sum] = "0b7b52767868a23d5bab768e390dc5f5c55825b6d30b86c844ff2dc7414044cc"
-SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
-SRC_URI[windows_x86_64_msvc-0.48.5.sha256sum] = "ed94fce61571a4006852b7389a063ab983c02eb1bb37b47f8272ce92d06d9538"
-SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
-SRC_URI[winnow-0.6.16.sha256sum] = "b480ae9340fc261e6be3e95a1ba86d54ae3f9171132a73ce8d4bbaf68339507c"
-SRC_URI[wyz-0.5.1.sha256sum] = "05f360fc0b24296329c78fda852a1e9ae82de9cf7b27dae4b7f62f118f77b9ed"
-# from rust/vendor/x509-parser/Cargo.lock
+# from rust/vendor/rustyline/Cargo.lock
 SRC_URI += " \
-    crate://crates.io/asn1-rs/0.6.1 \
-    crate://crates.io/asn1-rs-derive/0.5.0 \
-    crate://crates.io/asn1-rs-impl/0.2.0 \
+    crate://crates.io/ahash/0.8.11 \
+    crate://crates.io/aho-corasick/1.1.2 \
+    crate://crates.io/allocator-api2/0.2.16 \
+    crate://crates.io/android-tzdata/0.1.1 \
+    crate://crates.io/android_system_properties/0.1.5 \
+    crate://crates.io/arrayvec/0.7.4 \
+    crate://crates.io/assert_matches/1.5.0 \
     crate://crates.io/autocfg/1.1.0 \
-    crate://crates.io/cc/1.0.88 \
+    crate://crates.io/beef/0.5.2 \
+    crate://crates.io/bitflags/1.3.2 \
+    crate://crates.io/bitflags/2.4.2 \
+    crate://crates.io/buffer-redux/1.0.1 \
+    crate://crates.io/bumpalo/3.15.3 \
+    crate://crates.io/cc/1.0.89 \
     crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/data-encoding/2.5.0 \
-    crate://crates.io/der-parser/9.0.0 \
+    crate://crates.io/cfg_aliases/0.1.1 \
+    crate://crates.io/chrono/0.4.35 \
+    crate://crates.io/clipboard-win/5.2.0 \
+    crate://crates.io/core-foundation-sys/0.8.6 \
+    crate://crates.io/crossbeam/0.8.4 \
+    crate://crates.io/crossbeam-channel/0.5.12 \
+    crate://crates.io/crossbeam-deque/0.8.5 \
+    crate://crates.io/crossbeam-epoch/0.9.18 \
+    crate://crates.io/crossbeam-queue/0.3.11 \
+    crate://crates.io/crossbeam-utils/0.8.19 \
+    crate://crates.io/darling/0.14.4 \
+    crate://crates.io/darling_core/0.14.4 \
+    crate://crates.io/darling_macro/0.14.4 \
+    crate://crates.io/defer-drop/1.3.0 \
     crate://crates.io/deranged/0.3.11 \
-    crate://crates.io/displaydoc/0.2.4 \
+    crate://crates.io/derive_builder/0.11.2 \
+    crate://crates.io/derive_builder_core/0.11.2 \
+    crate://crates.io/derive_builder_macro/0.11.2 \
+    crate://crates.io/dirs-next/2.0.0 \
+    crate://crates.io/dirs-sys-next/0.1.2 \
+    crate://crates.io/doc-comment/0.3.3 \
+    crate://crates.io/either/1.10.0 \
+    crate://crates.io/endian-type/0.1.2 \
+    crate://crates.io/env_filter/0.1.0 \
+    crate://crates.io/env_logger/0.11.3 \
+    crate://crates.io/errno/0.3.8 \
+    crate://crates.io/error-code/3.2.0 \
+    crate://crates.io/fallible-iterator/0.3.0 \
+    crate://crates.io/fallible-streaming-iterator/0.1.9 \
+    crate://crates.io/fastrand/2.0.1 \
+    crate://crates.io/fd-lock/4.0.2 \
+    crate://crates.io/fnv/1.0.7 \
+    crate://crates.io/fuzzy-matcher/0.3.7 \
     crate://crates.io/getrandom/0.2.12 \
-    crate://crates.io/itoa/1.0.10 \
+    crate://crates.io/hashbrown/0.14.3 \
+    crate://crates.io/hashlink/0.9.0 \
+    crate://crates.io/home/0.5.9 \
+    crate://crates.io/iana-time-zone/0.1.60 \
+    crate://crates.io/iana-time-zone-haiku/0.1.2 \
+    crate://crates.io/ident_case/1.0.1 \
+    crate://crates.io/js-sys/0.3.69 \
     crate://crates.io/lazy_static/1.4.0 \
     crate://crates.io/libc/0.2.153 \
+    crate://crates.io/libredox/0.0.1 \
+    crate://crates.io/libsqlite3-sys/0.28.0 \
+    crate://crates.io/linux-raw-sys/0.4.13 \
+    crate://crates.io/log/0.4.21 \
     crate://crates.io/memchr/2.7.1 \
-    crate://crates.io/minimal-lexical/0.2.1 \
-    crate://crates.io/nom/7.1.3 \
-    crate://crates.io/num-bigint/0.4.4 \
+    crate://crates.io/memoffset/0.6.5 \
+    crate://crates.io/nibble_vec/0.1.0 \
+    crate://crates.io/nix/0.24.3 \
+    crate://crates.io/nix/0.25.1 \
+    crate://crates.io/nix/0.28.0 \
     crate://crates.io/num-conv/0.1.0 \
-    crate://crates.io/num-integer/0.1.46 \
     crate://crates.io/num-traits/0.2.18 \
-    crate://crates.io/oid-registry/0.7.0 \
+    crate://crates.io/once_cell/1.19.0 \
+    crate://crates.io/pin-utils/0.1.0 \
+    crate://crates.io/pkg-config/0.3.30 \
     crate://crates.io/powerfmt/0.2.0 \
+    crate://crates.io/ppv-lite86/0.2.17 \
     crate://crates.io/proc-macro2/1.0.78 \
     crate://crates.io/quote/1.0.35 \
-    crate://crates.io/ring/0.17.8 \
-    crate://crates.io/rusticata-macros/4.1.0 \
+    crate://crates.io/radix_trie/0.2.1 \
+    crate://crates.io/rand/0.8.5 \
+    crate://crates.io/rand_chacha/0.3.1 \
+    crate://crates.io/rand_core/0.6.4 \
+    crate://crates.io/rayon/1.9.0 \
+    crate://crates.io/rayon-core/1.12.1 \
+    crate://crates.io/redox_syscall/0.4.1 \
+    crate://crates.io/redox_users/0.4.4 \
+    crate://crates.io/regex/1.10.3 \
+    crate://crates.io/regex-automata/0.4.6 \
+    crate://crates.io/regex-syntax/0.8.2 \
+    crate://crates.io/rusqlite/0.31.0 \
+    crate://crates.io/rustix/0.38.31 \
+    crate://crates.io/rustversion/1.0.14 \
+    crate://crates.io/rustyline-derive/0.10.0 \
     crate://crates.io/serde/1.0.197 \
     crate://crates.io/serde_derive/1.0.197 \
-    crate://crates.io/spin/0.9.8 \
+    crate://crates.io/signal-hook/0.3.17 \
+    crate://crates.io/signal-hook-registry/1.4.1 \
+    crate://crates.io/skim/0.10.4 \
+    crate://crates.io/smallvec/1.13.1 \
+    crate://crates.io/strsim/0.10.0 \
+    crate://crates.io/syn/1.0.109 \
     crate://crates.io/syn/2.0.52 \
-    crate://crates.io/synstructure/0.13.1 \
+    crate://crates.io/tempfile/3.10.1 \
+    crate://crates.io/term/0.7.0 \
+    crate://crates.io/termios/0.3.3 \
     crate://crates.io/thiserror/1.0.57 \
     crate://crates.io/thiserror-impl/1.0.57 \
+    crate://crates.io/thread_local/1.1.8 \
     crate://crates.io/time/0.3.34 \
     crate://crates.io/time-core/0.1.2 \
-    crate://crates.io/time-macros/0.2.17 \
+    crate://crates.io/timer/0.2.0 \
+    crate://crates.io/tuikit/0.5.0 \
     crate://crates.io/unicode-ident/1.0.12 \
-    crate://crates.io/untrusted/0.9.0 \
+    crate://crates.io/unicode-segmentation/1.11.0 \
+    crate://crates.io/unicode-width/0.1.11 \
+    crate://crates.io/utf8parse/0.2.1 \
+    crate://crates.io/vcpkg/0.2.15 \
+    crate://crates.io/version_check/0.9.4 \
+    crate://crates.io/vte/0.11.1 \
+    crate://crates.io/vte_generate_state_changes/0.1.1 \
     crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
+    crate://crates.io/wasm-bindgen/0.2.92 \
+    crate://crates.io/wasm-bindgen-backend/0.2.92 \
+    crate://crates.io/wasm-bindgen-macro/0.2.92 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.92 \
+    crate://crates.io/wasm-bindgen-shared/0.2.92 \
+    crate://crates.io/winapi/0.3.9 \
+    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
+    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+    crate://crates.io/windows-core/0.52.0 \
     crate://crates.io/windows-sys/0.52.0 \
     crate://crates.io/windows-targets/0.52.4 \
     crate://crates.io/windows_aarch64_gnullvm/0.52.4 \
@@ -2446,48 +2653,139 @@ SRC_URI += " \
     crate://crates.io/windows_x86_64_gnu/0.52.4 \
     crate://crates.io/windows_x86_64_gnullvm/0.52.4 \
     crate://crates.io/windows_x86_64_msvc/0.52.4 \
+    crate://crates.io/zerocopy/0.7.32 \
+    crate://crates.io/zerocopy-derive/0.7.32 \
 "
 
-SRC_URI[asn1-rs-0.6.1.sha256sum] = "22ad1373757efa0f70ec53939aabc7152e1591cb485208052993070ac8d2429d"
-SRC_URI[asn1-rs-derive-0.5.0.sha256sum] = "7378575ff571966e99a744addeff0bff98b8ada0dedf1956d59e634db95eaac1"
-SRC_URI[asn1-rs-impl-0.2.0.sha256sum] = "7b18050c2cd6fe86c3a76584ef5e0baf286d038cda203eb6223df2cc413565f7"
+SRC_URI[ahash-0.8.11.sha256sum] = "e89da841a80418a9b391ebaea17f5c112ffaaa96f621d2c285b5174da76b9011"
+SRC_URI[aho-corasick-1.1.2.sha256sum] = "b2969dcb958b36655471fc61f7e416fa76033bdd4bfed0678d8fee1e2d07a1f0"
+SRC_URI[allocator-api2-0.2.16.sha256sum] = "0942ffc6dcaadf03badf6e6a2d0228460359d5e34b57ccdc720b7382dfbd5ec5"
+SRC_URI[android-tzdata-0.1.1.sha256sum] = "e999941b234f3131b00bc13c22d06e8c5ff726d1b6318ac7eb276997bbb4fef0"
+SRC_URI[android_system_properties-0.1.5.sha256sum] = "819e7219dbd41043ac279b19830f2efc897156490d7fd6ea916720117ee66311"
+SRC_URI[arrayvec-0.7.4.sha256sum] = "96d30a06541fbafbc7f82ed10c06164cfbd2c401138f6addd8404629c4b16711"
+SRC_URI[assert_matches-1.5.0.sha256sum] = "9b34d609dfbaf33d6889b2b7106d3ca345eacad44200913df5ba02bfd31d2ba9"
 SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
-SRC_URI[cc-1.0.88.sha256sum] = "02f341c093d19155a6e41631ce5971aac4e9a868262212153124c15fa22d1cdc"
+SRC_URI[beef-0.5.2.sha256sum] = "3a8241f3ebb85c056b509d4327ad0358fbbba6ffb340bf388f26350aeda225b1"
+SRC_URI[bitflags-1.3.2.sha256sum] = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"
+SRC_URI[bitflags-2.4.2.sha256sum] = "ed570934406eb16438a4e976b1b4500774099c13b8cb96eec99f620f05090ddf"
+SRC_URI[buffer-redux-1.0.1.sha256sum] = "4c9f8ddd22e0a12391d1e7ada69ec3b0da1914f1cec39c5cf977143c5b2854f5"
+SRC_URI[bumpalo-3.15.3.sha256sum] = "8ea184aa71bb362a1157c896979544cc23974e08fd265f29ea96b59f0b4a555b"
+SRC_URI[cc-1.0.89.sha256sum] = "a0ba8f7aaa012f30d5b2861462f6708eccd49c3c39863fe083a308035f63d723"
 SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[data-encoding-2.5.0.sha256sum] = "7e962a19be5cfc3f3bf6dd8f61eb50107f356ad6270fbb3ed41476571db78be5"
-SRC_URI[der-parser-9.0.0.sha256sum] = "5cd0a5c643689626bec213c4d8bd4d96acc8ffdb4ad4bb6bc16abf27d5f4b553"
+SRC_URI[cfg_aliases-0.1.1.sha256sum] = "fd16c4719339c4530435d38e511904438d07cce7950afa3718a84ac36c10e89e"
+SRC_URI[chrono-0.4.35.sha256sum] = "8eaf5903dcbc0a39312feb77df2ff4c76387d591b9fc7b04a238dcf8bb62639a"
+SRC_URI[clipboard-win-5.2.0.sha256sum] = "12f9a0700e0127ba15d1d52dd742097f821cd9c65939303a44d970465040a297"
+SRC_URI[core-foundation-sys-0.8.6.sha256sum] = "06ea2b9bc92be3c2baa9334a323ebca2d6f074ff852cd1d7b11064035cd3868f"
+SRC_URI[crossbeam-0.8.4.sha256sum] = "1137cd7e7fc0fb5d3c5a8678be38ec56e819125d8d7907411fe24ccb943faca8"
+SRC_URI[crossbeam-channel-0.5.12.sha256sum] = "ab3db02a9c5b5121e1e42fbdb1aeb65f5e02624cc58c43f2884c6ccac0b82f95"
+SRC_URI[crossbeam-deque-0.8.5.sha256sum] = "613f8cc01fe9cf1a3eb3d7f488fd2fa8388403e97039e2f73692932e291a770d"
+SRC_URI[crossbeam-epoch-0.9.18.sha256sum] = "5b82ac4a3c2ca9c3460964f020e1402edd5753411d7737aa39c3714ad1b5420e"
+SRC_URI[crossbeam-queue-0.3.11.sha256sum] = "df0346b5d5e76ac2fe4e327c5fd1118d6be7c51dfb18f9b7922923f287471e35"
+SRC_URI[crossbeam-utils-0.8.19.sha256sum] = "248e3bacc7dc6baa3b21e405ee045c3047101a49145e7e9eca583ab4c2ca5345"
+SRC_URI[darling-0.14.4.sha256sum] = "7b750cb3417fd1b327431a470f388520309479ab0bf5e323505daf0290cd3850"
+SRC_URI[darling_core-0.14.4.sha256sum] = "109c1ca6e6b7f82cc233a97004ea8ed7ca123a9af07a8230878fcfda9b158bf0"
+SRC_URI[darling_macro-0.14.4.sha256sum] = "a4aab4dbc9f7611d8b55048a3a16d2d010c2c8334e46304b40ac1cc14bf3b48e"
+SRC_URI[defer-drop-1.3.0.sha256sum] = "f613ec9fa66a6b28cdb1842b27f9adf24f39f9afc4dcdd9fdecee4aca7945c57"
 SRC_URI[deranged-0.3.11.sha256sum] = "b42b6fa04a440b495c8b04d0e71b707c585f83cb9cb28cf8cd0d976c315e31b4"
-SRC_URI[displaydoc-0.2.4.sha256sum] = "487585f4d0c6655fe74905e2504d8ad6908e4db67f744eb140876906c2f3175d"
+SRC_URI[derive_builder-0.11.2.sha256sum] = "d07adf7be193b71cc36b193d0f5fe60b918a3a9db4dad0449f57bcfd519704a3"
+SRC_URI[derive_builder_core-0.11.2.sha256sum] = "1f91d4cfa921f1c05904dc3c57b4a32c38aed3340cce209f3a6fd1478babafc4"
+SRC_URI[derive_builder_macro-0.11.2.sha256sum] = "8f0314b72bed045f3a68671b3c86328386762c93f82d98c65c3cb5e5f573dd68"
+SRC_URI[dirs-next-2.0.0.sha256sum] = "b98cf8ebf19c3d1b223e151f99a4f9f0690dca41414773390fc824184ac833e1"
+SRC_URI[dirs-sys-next-0.1.2.sha256sum] = "4ebda144c4fe02d1f7ea1a7d9641b6fc6b580adcfa024ae48797ecdeb6825b4d"
+SRC_URI[doc-comment-0.3.3.sha256sum] = "fea41bba32d969b513997752735605054bc0dfa92b4c56bf1189f2e174be7a10"
+SRC_URI[either-1.10.0.sha256sum] = "11157ac094ffbdde99aa67b23417ebdd801842852b500e395a45a9c0aac03e4a"
+SRC_URI[endian-type-0.1.2.sha256sum] = "c34f04666d835ff5d62e058c3995147c06f42fe86ff053337632bca83e42702d"
+SRC_URI[env_filter-0.1.0.sha256sum] = "a009aa4810eb158359dda09d0c87378e4bbb89b5a801f016885a4707ba24f7ea"
+SRC_URI[env_logger-0.11.3.sha256sum] = "38b35839ba51819680ba087cd351788c9a3c476841207e0b8cee0b04722343b9"
+SRC_URI[errno-0.3.8.sha256sum] = "a258e46cdc063eb8519c00b9fc845fc47bcfca4130e2f08e88665ceda8474245"
+SRC_URI[error-code-3.2.0.sha256sum] = "a0474425d51df81997e2f90a21591180b38eccf27292d755f3e30750225c175b"
+SRC_URI[fallible-iterator-0.3.0.sha256sum] = "2acce4a10f12dc2fb14a218589d4f1f62ef011b2d0cc4b3cb1bba8e94da14649"
+SRC_URI[fallible-streaming-iterator-0.1.9.sha256sum] = "7360491ce676a36bf9bb3c56c1aa791658183a54d2744120f27285738d90465a"
+SRC_URI[fastrand-2.0.1.sha256sum] = "25cbce373ec4653f1a01a31e8a5e5ec0c622dc27ff9c4e6606eefef5cbbed4a5"
+SRC_URI[fd-lock-4.0.2.sha256sum] = "7e5768da2206272c81ef0b5e951a41862938a6070da63bcea197899942d3b947"
+SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
+SRC_URI[fuzzy-matcher-0.3.7.sha256sum] = "54614a3312934d066701a80f20f15fa3b56d67ac7722b39eea5b4c9dd1d66c94"
 SRC_URI[getrandom-0.2.12.sha256sum] = "190092ea657667030ac6a35e305e62fc4dd69fd98ac98631e5d3a2b1575a12b5"
-SRC_URI[itoa-1.0.10.sha256sum] = "b1a46d1a171d865aa5f83f92695765caa047a9b4cbae2cbf37dbd613a793fd4c"
+SRC_URI[hashbrown-0.14.3.sha256sum] = "290f1a1d9242c78d09ce40a5e87e7554ee637af1351968159f4952f028f75604"
+SRC_URI[hashlink-0.9.0.sha256sum] = "692eaaf7f7607518dd3cef090f1474b61edc5301d8012f09579920df68b725ee"
+SRC_URI[home-0.5.9.sha256sum] = "e3d1354bf6b7235cb4a0576c2619fd4ed18183f689b12b006a0ee7329eeff9a5"
+SRC_URI[iana-time-zone-0.1.60.sha256sum] = "e7ffbb5a1b541ea2561f8c41c087286cc091e21e556a4f09a8f6cbf17b69b141"
+SRC_URI[iana-time-zone-haiku-0.1.2.sha256sum] = "f31827a206f56af32e590ba56d5d2d085f558508192593743f16b2306495269f"
+SRC_URI[ident_case-1.0.1.sha256sum] = "b9e0384b61958566e926dc50660321d12159025e767c18e043daf26b70104c39"
+SRC_URI[js-sys-0.3.69.sha256sum] = "29c15563dc2726973df627357ce0c9ddddbea194836909d655df6a75d2cf296d"
 SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
 SRC_URI[libc-0.2.153.sha256sum] = "9c198f91728a82281a64e1f4f9eeb25d82cb32a5de251c6bd1b5154d63a8e7bd"
+SRC_URI[libredox-0.0.1.sha256sum] = "85c833ca1e66078851dba29046874e38f08b2c883700aa29a03ddd3b23814ee8"
+SRC_URI[libsqlite3-sys-0.28.0.sha256sum] = "0c10584274047cb335c23d3e61bcef8e323adae7c5c8c760540f73610177fc3f"
+SRC_URI[linux-raw-sys-0.4.13.sha256sum] = "01cda141df6706de531b6c46c3a33ecca755538219bd484262fa09410c13539c"
+SRC_URI[log-0.4.21.sha256sum] = "90ed8c1e510134f979dbc4f070f87d4313098b704861a105fe34231c70a3901c"
 SRC_URI[memchr-2.7.1.sha256sum] = "523dc4f511e55ab87b694dc30d0f820d60906ef06413f93d4d7a1385599cc149"
-SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
-SRC_URI[nom-7.1.3.sha256sum] = "d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
-SRC_URI[num-bigint-0.4.4.sha256sum] = "608e7659b5c3d7cba262d894801b9ec9d00de989e8a82bd4bef91d08da45cdc0"
+SRC_URI[memoffset-0.6.5.sha256sum] = "5aa361d4faea93603064a027415f07bd8e1d5c88c9fbf68bf56a285428fd79ce"
+SRC_URI[nibble_vec-0.1.0.sha256sum] = "77a5d83df9f36fe23f0c3648c6bbb8b0298bb5f1939c8f2704431371f4b84d43"
+SRC_URI[nix-0.24.3.sha256sum] = "fa52e972a9a719cecb6864fb88568781eb706bac2cd1d4f04a648542dbf78069"
+SRC_URI[nix-0.25.1.sha256sum] = "f346ff70e7dbfd675fe90590b92d59ef2de15a8779ae305ebcbfd3f0caf59be4"
+SRC_URI[nix-0.28.0.sha256sum] = "ab2156c4fce2f8df6c499cc1c763e4394b7482525bf2a9701c9d79d215f519e4"
 SRC_URI[num-conv-0.1.0.sha256sum] = "51d515d32fb182ee37cda2ccdcb92950d6a3c2893aa280e540671c2cd0f3b1d9"
-SRC_URI[num-integer-0.1.46.sha256sum] = "7969661fd2958a5cb096e56c8e1ad0444ac2bbcd0061bd28660485a44879858f"
 SRC_URI[num-traits-0.2.18.sha256sum] = "da0df0e5185db44f69b44f26786fe401b6c293d1907744beaa7fa62b2e5a517a"
-SRC_URI[oid-registry-0.7.0.sha256sum] = "1c958dd45046245b9c3c2547369bb634eb461670b2e7e0de552905801a648d1d"
+SRC_URI[once_cell-1.19.0.sha256sum] = "3fdb12b2476b595f9358c5161aa467c2438859caa136dec86c26fdd2efe17b92"
+SRC_URI[pin-utils-0.1.0.sha256sum] = "8b870d8c151b6f2fb93e84a13146138f05d02ed11c7e7c54f8826aaaf7c9f184"
+SRC_URI[pkg-config-0.3.30.sha256sum] = "d231b230927b5e4ad203db57bbcbee2802f6bce620b1e4a9024a07d94e2907ec"
 SRC_URI[powerfmt-0.2.0.sha256sum] = "439ee305def115ba05938db6eb1644ff94165c5ab5e9420d1c1bcedbba909391"
+SRC_URI[ppv-lite86-0.2.17.sha256sum] = "5b40af805b3121feab8a3c29f04d8ad262fa8e0561883e7653e024ae4479e6de"
 SRC_URI[proc-macro2-1.0.78.sha256sum] = "e2422ad645d89c99f8f3e6b88a9fdeca7fabeac836b1002371c4367c8f984aae"
 SRC_URI[quote-1.0.35.sha256sum] = "291ec9ab5efd934aaf503a6466c5d5251535d108ee747472c3977cc5acc868ef"
-SRC_URI[ring-0.17.8.sha256sum] = "c17fa4cb658e3583423e915b9f3acc01cceaee1860e33d59ebae66adc3a2dc0d"
-SRC_URI[rusticata-macros-4.1.0.sha256sum] = "faf0c4a6ece9950b9abdb62b1cfcf2a68b3b67a10ba445b3bb85be2a293d0632"
+SRC_URI[radix_trie-0.2.1.sha256sum] = "c069c179fcdc6a2fe24d8d18305cf085fdbd4f922c041943e203685d6a1c58fd"
+SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
+SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
+SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
+SRC_URI[rayon-1.9.0.sha256sum] = "e4963ed1bc86e4f3ee217022bd855b297cef07fb9eac5dfa1f788b220b49b3bd"
+SRC_URI[rayon-core-1.12.1.sha256sum] = "1465873a3dfdaa8ae7cb14b4383657caab0b3e8a0aa9ae8e04b044854c8dfce2"
+SRC_URI[redox_syscall-0.4.1.sha256sum] = "4722d768eff46b75989dd134e5c353f0d6296e5aaa3132e776cbdb56be7731aa"
+SRC_URI[redox_users-0.4.4.sha256sum] = "a18479200779601e498ada4e8c1e1f50e3ee19deb0259c25825a98b5603b2cb4"
+SRC_URI[regex-1.10.3.sha256sum] = "b62dbe01f0b06f9d8dc7d49e05a0785f153b00b2c227856282f671e0318c9b15"
+SRC_URI[regex-automata-0.4.6.sha256sum] = "86b83b8b9847f9bf95ef68afb0b8e6cdb80f498442f5179a29fad448fcc1eaea"
+SRC_URI[regex-syntax-0.8.2.sha256sum] = "c08c74e62047bb2de4ff487b251e4a92e24f48745648451635cec7d591162d9f"
+SRC_URI[rusqlite-0.31.0.sha256sum] = "b838eba278d213a8beaf485bd313fd580ca4505a00d5871caeb1457c55322cae"
+SRC_URI[rustix-0.38.31.sha256sum] = "6ea3e1a662af26cd7a3ba09c0297a31af215563ecf42817c98df621387f4e949"
+SRC_URI[rustversion-1.0.14.sha256sum] = "7ffc183a10b4478d04cbbbfc96d0873219d962dd5accaff2ffbd4ceb7df837f4"
+SRC_URI[rustyline-derive-0.10.0.sha256sum] = "e5af959c8bf6af1aff6d2b463a57f71aae53d1332da58419e30ad8dc7011d951"
 SRC_URI[serde-1.0.197.sha256sum] = "3fb1c873e1b9b056a4dc4c0c198b24c3ffa059243875552b2bd0933b1aee4ce2"
 SRC_URI[serde_derive-1.0.197.sha256sum] = "7eb0b34b42edc17f6b7cac84a52a1c5f0e1bb2227e997ca9011ea3dd34e8610b"
-SRC_URI[spin-0.9.8.sha256sum] = "6980e8d7511241f8acf4aebddbb1ff938df5eebe98691418c4468d0b72a96a67"
+SRC_URI[signal-hook-0.3.17.sha256sum] = "8621587d4798caf8eb44879d42e56b9a93ea5dcd315a6487c357130095b62801"
+SRC_URI[signal-hook-registry-1.4.1.sha256sum] = "d8229b473baa5980ac72ef434c4415e70c4b5e71b423043adb4ba059f89c99a1"
+SRC_URI[skim-0.10.4.sha256sum] = "e5d28de0a6cb2cdd83a076f1de9d965b973ae08b244df1aa70b432946dda0f32"
+SRC_URI[smallvec-1.13.1.sha256sum] = "e6ecd384b10a64542d77071bd64bd7b231f4ed5940fba55e98c3de13824cf3d7"
+SRC_URI[strsim-0.10.0.sha256sum] = "73473c0e59e6d5812c5dfe2a064a6444949f089e20eec9a2e5506596494e4623"
+SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
 SRC_URI[syn-2.0.52.sha256sum] = "b699d15b36d1f02c3e7c69f8ffef53de37aefae075d8488d4ba1a7788d574a07"
-SRC_URI[synstructure-0.13.1.sha256sum] = "c8af7666ab7b6390ab78131fb5b0fce11d6b7a6951602017c35fa82800708971"
+SRC_URI[tempfile-3.10.1.sha256sum] = "85b77fafb263dd9d05cbeac119526425676db3784113aa9295c88498cbf8bff1"
+SRC_URI[term-0.7.0.sha256sum] = "c59df8ac95d96ff9bede18eb7300b0fda5e5d8d90960e76f8e14ae765eedbf1f"
+SRC_URI[termios-0.3.3.sha256sum] = "411c5bf740737c7918b8b1fe232dca4dc9f8e754b8ad5e20966814001ed0ac6b"
 SRC_URI[thiserror-1.0.57.sha256sum] = "1e45bcbe8ed29775f228095caf2cd67af7a4ccf756ebff23a306bf3e8b47b24b"
 SRC_URI[thiserror-impl-1.0.57.sha256sum] = "a953cb265bef375dae3de6663da4d3804eee9682ea80d8e2542529b73c531c81"
+SRC_URI[thread_local-1.1.8.sha256sum] = "8b9ef9bad013ada3808854ceac7b46812a6465ba368859a37e2100283d2d719c"
 SRC_URI[time-0.3.34.sha256sum] = "c8248b6521bb14bc45b4067159b9b6ad792e2d6d754d6c41fb50e29fefe38749"
 SRC_URI[time-core-0.1.2.sha256sum] = "ef927ca75afb808a4d64dd374f00a2adf8d0fcff8e7b184af886c3c87ec4a3f3"
-SRC_URI[time-macros-0.2.17.sha256sum] = "7ba3a3ef41e6672a2f0f001392bb5dcd3ff0a9992d618ca761a11c3121547774"
+SRC_URI[timer-0.2.0.sha256sum] = "31d42176308937165701f50638db1c31586f183f1aab416268216577aec7306b"
+SRC_URI[tuikit-0.5.0.sha256sum] = "5e19c6ab038babee3d50c8c12ff8b910bdb2196f62278776422f50390d8e53d8"
 SRC_URI[unicode-ident-1.0.12.sha256sum] = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
-SRC_URI[untrusted-0.9.0.sha256sum] = "8ecb6da28b8a351d773b68d5825ac39017e680750f980f3a1a85cd8dd28a47c1"
+SRC_URI[unicode-segmentation-1.11.0.sha256sum] = "d4c87d22b6e3f4a18d4d40ef354e97c90fcb14dd91d7dc0aa9d8a1172ebf7202"
+SRC_URI[unicode-width-0.1.11.sha256sum] = "e51733f11c9c4f72aa0c160008246859e340b00807569a0da0e7a1079b27ba85"
+SRC_URI[utf8parse-0.2.1.sha256sum] = "711b9620af191e0cdc7468a8d14e709c3dcdb115b36f838e601583af800a370a"
+SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
+SRC_URI[version_check-0.9.4.sha256sum] = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
+SRC_URI[vte-0.11.1.sha256sum] = "f5022b5fbf9407086c180e9557be968742d839e68346af7792b8592489732197"
+SRC_URI[vte_generate_state_changes-0.1.1.sha256sum] = "d257817081c7dffcdbab24b9e62d2def62e2ff7d00b1c20062551e6cccc145ff"
 SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
+SRC_URI[wasm-bindgen-0.2.92.sha256sum] = "4be2531df63900aeb2bca0daaaddec08491ee64ceecbee5076636a3b026795a8"
+SRC_URI[wasm-bindgen-backend-0.2.92.sha256sum] = "614d787b966d3989fa7bb98a654e369c762374fd3213d212cfc0251257e747da"
+SRC_URI[wasm-bindgen-macro-0.2.92.sha256sum] = "a1f8823de937b71b9460c0c34e25f3da88250760bec0ebac694b49997550d726"
+SRC_URI[wasm-bindgen-macro-support-0.2.92.sha256sum] = "e94f17b526d0a461a191c78ea52bbce64071ed5c04c9ffe424dcb38f74171bb7"
+SRC_URI[wasm-bindgen-shared-0.2.92.sha256sum] = "af190c94f2773fdb3729c55b007a722abb5384da03bc0986df4c289bf5567e96"
+SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
+SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
+SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
+SRC_URI[windows-core-0.52.0.sha256sum] = "33ab640c8d7e35bf8ba19b884ba838ceb4fba93a4e8c65a9059d08afcfc683d9"
 SRC_URI[windows-sys-0.52.0.sha256sum] = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
 SRC_URI[windows-targets-0.52.4.sha256sum] = "7dd37b7e5ab9018759f893a1952c9420d060016fc19a472b4bb20d1bdd694d1b"
 SRC_URI[windows_aarch64_gnullvm-0.52.4.sha256sum] = "bcf46cf4c365c6f2d1cc93ce535f2c8b244591df96ceee75d8e83deb70a9cac9"
@@ -2497,26 +2795,21 @@ SRC_URI[windows_i686_msvc-0.52.4.sha256sum] = "1515e9a29e5bed743cb4415a9ecf5dfca
 SRC_URI[windows_x86_64_gnu-0.52.4.sha256sum] = "5eee091590e89cc02ad514ffe3ead9eb6b660aedca2183455434b93546371a03"
 SRC_URI[windows_x86_64_gnullvm-0.52.4.sha256sum] = "77ca79f2451b49fa9e2af39f0747fe999fcda4f5e241b2898624dca97a1f2177"
 SRC_URI[windows_x86_64_msvc-0.52.4.sha256sum] = "32b752e52a2da0ddfbdbcc6fceadfeede4c939ed16d13e648833a61dfb611ed8"
-# from rust/vendor/ryu/Cargo.lock
+SRC_URI[zerocopy-0.7.32.sha256sum] = "74d4d3961e53fa4c9a25a8637fc2bfaf2595b3d3ae34875568a5cf64787716be"
+SRC_URI[zerocopy-derive-0.7.32.sha256sum] = "9ce1b18ccd8e73a9321186f97e46f9f04b778851177567b1975109d26a08d2a6"
+# from rust/vendor/nu-ansi-term/Cargo.lock
 SRC_URI += " \
-    crate://crates.io/bitflags/2.9.0 \
-    crate://crates.io/byteorder/1.5.0 \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/getrandom/0.3.1 \
-    crate://crates.io/hermit-abi/0.3.9 \
-    crate://crates.io/libc/0.2.170 \
-    crate://crates.io/no-panic/0.1.34 \
-    crate://crates.io/num_cpus/1.16.0 \
-    crate://crates.io/ppv-lite86/0.2.20 \
-    crate://crates.io/proc-macro2/1.0.94 \
-    crate://crates.io/quote/1.0.39 \
-    crate://crates.io/rand/0.9.0 \
-    crate://crates.io/rand_chacha/0.9.0 \
-    crate://crates.io/rand_core/0.9.3 \
-    crate://crates.io/rand_xorshift/0.4.0 \
-    crate://crates.io/syn/2.0.99 \
-    crate://crates.io/unicode-ident/1.0.17 \
-    crate://crates.io/wasi/0.13.3+wasi-0.2.2 \
+    crate://crates.io/doc-comment/0.3.3 \
+    crate://crates.io/itoa/1.0.11 \
+    crate://crates.io/proc-macro2/1.0.86 \
+    crate://crates.io/quote/1.0.36 \
+    crate://crates.io/ryu/1.0.18 \
+    crate://crates.io/serde/1.0.204 \
+    crate://crates.io/serde_derive/1.0.204 \
+    crate://crates.io/serde_json/1.0.120 \
+    crate://crates.io/syn/2.0.72 \
+    crate://crates.io/unicode-ident/1.0.12 \
+    crate://crates.io/windows-sys/0.52.0 \
     crate://crates.io/windows-targets/0.52.6 \
     crate://crates.io/windows_aarch64_gnullvm/0.52.6 \
     crate://crates.io/windows_aarch64_msvc/0.52.6 \
@@ -2526,31 +2819,19 @@ SRC_URI += " \
     crate://crates.io/windows_x86_64_gnu/0.52.6 \
     crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
     crate://crates.io/windows_x86_64_msvc/0.52.6 \
-    crate://crates.io/wit-bindgen-rt/0.33.0 \
-    crate://crates.io/zerocopy/0.7.35 \
-    crate://crates.io/zerocopy/0.8.21 \
-    crate://crates.io/zerocopy-derive/0.7.35 \
-    crate://crates.io/zerocopy-derive/0.8.21 \
 "
 
-SRC_URI[bitflags-2.9.0.sha256sum] = "5c8214115b7bf84099f1309324e63141d4c5d7cc26862f97a0a857dbefe165bd"
-SRC_URI[byteorder-1.5.0.sha256sum] = "1fd0f2584146f6f2ef48085050886acf353beff7305ebd1ae69500e27c67f64b"
-SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[getrandom-0.3.1.sha256sum] = "43a49c392881ce6d5c3b8cb70f98717b7c07aabbdff06687b9030dbfbe2725f8"
-SRC_URI[hermit-abi-0.3.9.sha256sum] = "d231dfb89cfffdbc30e7fc41579ed6066ad03abda9e567ccafae602b97ec5024"
-SRC_URI[libc-0.2.170.sha256sum] = "875b3680cb2f8f71bdcf9a30f38d48282f5d3c95cbf9b3fa57269bb5d5c06828"
-SRC_URI[no-panic-0.1.34.sha256sum] = "e5b926eaa50591fb2d593d569431833cf8fb4457754a576f47f0d0afe1be73a3"
-SRC_URI[num_cpus-1.16.0.sha256sum] = "4161fcb6d602d4d2081af7c3a45852d875a03dd337a6bfdd6e06407b61342a43"
-SRC_URI[ppv-lite86-0.2.20.sha256sum] = "77957b295656769bb8ad2b6a6b09d897d94f05c41b069aede1fcdaa675eaea04"
-SRC_URI[proc-macro2-1.0.94.sha256sum] = "a31971752e70b8b2686d7e46ec17fb38dad4051d94024c88df49b667caea9c84"
-SRC_URI[quote-1.0.39.sha256sum] = "c1f1914ce909e1658d9907913b4b91947430c7d9be598b15a1912935b8c04801"
-SRC_URI[rand-0.9.0.sha256sum] = "3779b94aeb87e8bd4e834cee3650289ee9e0d5677f976ecdb6d219e5f4f6cd94"
-SRC_URI[rand_chacha-0.9.0.sha256sum] = "d3022b5f1df60f26e1ffddd6c66e8aa15de382ae63b3a0c1bfc0e4d3e3f325cb"
-SRC_URI[rand_core-0.9.3.sha256sum] = "99d9a13982dcf210057a8a78572b2217b667c3beacbf3a0d8b454f6f82837d38"
-SRC_URI[rand_xorshift-0.4.0.sha256sum] = "513962919efc330f829edb2535844d1b912b0fbe2ca165d613e4e8788bb05a5a"
-SRC_URI[syn-2.0.99.sha256sum] = "e02e925281e18ffd9d640e234264753c43edc62d64b2d4cf898f1bc5e75f3fc2"
-SRC_URI[unicode-ident-1.0.17.sha256sum] = "00e2473a93778eb0bad35909dff6a10d28e63f792f16ed15e404fca9d5eeedbe"
-SRC_URI[wasi-0.13.3+wasi-0.2.2.sha256sum] = "26816d2e1a4a36a2940b96c5296ce403917633dff8f3440e9b236ed6f6bacad2"
+SRC_URI[doc-comment-0.3.3.sha256sum] = "fea41bba32d969b513997752735605054bc0dfa92b4c56bf1189f2e174be7a10"
+SRC_URI[itoa-1.0.11.sha256sum] = "49f1f14873335454500d59611f1cf4a4b0f786f9ac11f4312a78e4cf2566695b"
+SRC_URI[proc-macro2-1.0.86.sha256sum] = "5e719e8df665df0d1c8fbfd238015744736151d4445ec0836b8e628aae103b77"
+SRC_URI[quote-1.0.36.sha256sum] = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
+SRC_URI[ryu-1.0.18.sha256sum] = "f3cb5ba0dc43242ce17de99c180e96db90b235b8a9fdc9543c96d2209116bd9f"
+SRC_URI[serde-1.0.204.sha256sum] = "bc76f558e0cbb2a839d37354c575f1dc3fdc6546b5be373ba43d95f231bf7c12"
+SRC_URI[serde_derive-1.0.204.sha256sum] = "e0cd7e117be63d3c3678776753929474f3b04a43a080c744d6b0ae2a8c28e222"
+SRC_URI[serde_json-1.0.120.sha256sum] = "4e0d21c9a8cae1235ad58a00c11cb40d4b1e5c784f1ef2c537876ed6ffd8b7c5"
+SRC_URI[syn-2.0.72.sha256sum] = "dc4b9b9bf2add8093d3f2c0204471e951b2285580335de42f9d2534f3ae7a8af"
+SRC_URI[unicode-ident-1.0.12.sha256sum] = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
+SRC_URI[windows-sys-0.52.0.sha256sum] = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
 SRC_URI[windows-targets-0.52.6.sha256sum] = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
 SRC_URI[windows_aarch64_gnullvm-0.52.6.sha256sum] = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
 SRC_URI[windows_aarch64_msvc-0.52.6.sha256sum] = "09ec2a7bb152e2252b53fa7803150007879548bc709c039df7627cabbd05d469"
@@ -2560,93 +2841,6 @@ SRC_URI[windows_i686_msvc-0.52.6.sha256sum] = "240948bc05c5e7c6dabba28bf89d89ffc
 SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
 SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
 SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
-SRC_URI[wit-bindgen-rt-0.33.0.sha256sum] = "3268f3d866458b787f390cf61f4bbb563b922d091359f9608842999eaee3943c"
-SRC_URI[zerocopy-0.7.35.sha256sum] = "1b9b4fd18abc82b8136838da5d50bae7bdea537c574d8dc1a34ed098d6c166f0"
-SRC_URI[zerocopy-0.8.21.sha256sum] = "dcf01143b2dd5d134f11f545cf9f1431b13b749695cb33bcce051e7568f99478"
-SRC_URI[zerocopy-derive-0.7.35.sha256sum] = "fa4f8080344d4671fb4e831a13ad1e68092748387dfc4f55e356242fae12ce3e"
-SRC_URI[zerocopy-derive-0.8.21.sha256sum] = "712c8386f4f4299382c9abee219bee7084f78fb939d88b6840fcc1320d5f6da2"
-# from rust/vendor/regex/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/aho-corasick/0.7.18 \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/getrandom/0.2.6 \
-    crate://crates.io/lazy_static/1.4.0 \
-    crate://crates.io/libc/0.2.125 \
-    crate://crates.io/memchr/2.5.0 \
-    crate://crates.io/quickcheck/1.0.3 \
-    crate://crates.io/rand/0.8.5 \
-    crate://crates.io/rand_core/0.6.3 \
-    crate://crates.io/regex-syntax/0.6.26 \
-    crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
-"
-
-SRC_URI[aho-corasick-0.7.18.sha256sum] = "1e37cfd5e7657ada45f742d6e99ca5788580b5c529dc78faf11ece6dc702656f"
-SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[getrandom-0.2.6.sha256sum] = "9be70c98951c83b8d2f8f60d7065fa6d5146873094452a1008da8c2f1e4205ad"
-SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
-SRC_URI[libc-0.2.125.sha256sum] = "5916d2ae698f6de9bfb891ad7a8d65c09d232dc58cc4ac433c7da3b2fd84bc2b"
-SRC_URI[memchr-2.5.0.sha256sum] = "2dffe52ecf27772e601905b7522cb4ef790d2cc203488bbd0e2fe85fcb74566d"
-SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
-SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
-SRC_URI[rand_core-0.6.3.sha256sum] = "d34f1408f55294453790c48b2f1ebbb1c5b4b7563eb1f418bcfcfdbb06ebb4e7"
-SRC_URI[regex-syntax-0.6.26.sha256sum] = "49b3de9ec5dc0a3417da371aab17d729997c15010e7fd24ff707773a33bddb64"
-SRC_URI[wasi-0.10.2+wasi-snapshot-preview1.sha256sum] = "fd6fbd9a79829dd1ad0cc20627bf1ed606756a7f77edff7b66b7064f9cb327c6"
-# from rust/vendor/bendy/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/addr2line/0.14.0 \
-    crate://crates.io/adler/0.2.3 \
-    crate://crates.io/aho-corasick/0.7.15 \
-    crate://crates.io/autocfg/1.0.1 \
-    crate://crates.io/backtrace/0.3.54 \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/failure/0.1.8 \
-    crate://crates.io/failure_derive/0.1.8 \
-    crate://crates.io/gimli/0.23.0 \
-    crate://crates.io/lazy_static/1.4.0 \
-    crate://crates.io/libc/0.2.80 \
-    crate://crates.io/memchr/2.3.4 \
-    crate://crates.io/miniz_oxide/0.4.3 \
-    crate://crates.io/object/0.22.0 \
-    crate://crates.io/proc-macro2/1.0.24 \
-    crate://crates.io/quote/1.0.7 \
-    crate://crates.io/regex/1.4.2 \
-    crate://crates.io/regex-syntax/0.6.21 \
-    crate://crates.io/rustc-demangle/0.1.18 \
-    crate://crates.io/serde/1.0.117 \
-    crate://crates.io/serde_bytes/0.11.5 \
-    crate://crates.io/serde_derive/1.0.117 \
-    crate://crates.io/syn/1.0.48 \
-    crate://crates.io/synstructure/0.12.4 \
-    crate://crates.io/thread_local/1.0.1 \
-    crate://crates.io/unicode-xid/0.2.1 \
-"
-
-SRC_URI[addr2line-0.14.0.sha256sum] = "7c0929d69e78dd9bf5408269919fcbcaeb2e35e5d43e5815517cdc6a8e11a423"
-SRC_URI[adler-0.2.3.sha256sum] = "ee2a4ec343196209d6594e19543ae87a39f96d5534d7174822a3ad825dd6ed7e"
-SRC_URI[aho-corasick-0.7.15.sha256sum] = "7404febffaa47dac81aa44dba71523c9d069b1bdc50a77db41195149e17f68e5"
-SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a"
-SRC_URI[backtrace-0.3.54.sha256sum] = "2baad346b2d4e94a24347adeee9c7a93f412ee94b9cc26e5b59dea23848e9f28"
-SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[failure-0.1.8.sha256sum] = "d32e9bd16cc02eae7db7ef620b392808b89f6a5e16bb3497d159c6b92a0f4f86"
-SRC_URI[failure_derive-0.1.8.sha256sum] = "aa4da3c766cd7a0db8242e326e9e4e081edd567072893ed320008189715366a4"
-SRC_URI[gimli-0.23.0.sha256sum] = "f6503fe142514ca4799d4c26297c4248239fe8838d827db6bd6065c6ed29a6ce"
-SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
-SRC_URI[libc-0.2.80.sha256sum] = "4d58d1b70b004888f764dfbf6a26a3b0342a1632d33968e4a179d8011c760614"
-SRC_URI[memchr-2.3.4.sha256sum] = "0ee1c47aaa256ecabcaea351eae4a9b01ef39ed810004e298d2511ed284b1525"
-SRC_URI[miniz_oxide-0.4.3.sha256sum] = "0f2d26ec3309788e423cfbf68ad1800f061638098d76a83681af979dc4eda19d"
-SRC_URI[object-0.22.0.sha256sum] = "8d3b63360ec3cb337817c2dbd47ab4a0f170d285d8e5a2064600f3def1402397"
-SRC_URI[proc-macro2-1.0.24.sha256sum] = "1e0704ee1a7e00d7bb417d0770ea303c1bccbabf0ef1667dae92b5967f5f8a71"
-SRC_URI[quote-1.0.7.sha256sum] = "aa563d17ecb180e500da1cfd2b028310ac758de548efdd203e18f283af693f37"
-SRC_URI[regex-1.4.2.sha256sum] = "38cf2c13ed4745de91a5eb834e11c00bcc3709e773173b2ce4c56c9fbde04b9c"
-SRC_URI[regex-syntax-0.6.21.sha256sum] = "3b181ba2dcf07aaccad5448e8ead58db5b742cf85dfe035e2227f137a539a189"
-SRC_URI[rustc-demangle-0.1.18.sha256sum] = "6e3bad0ee36814ca07d7968269dd4b7ec89ec2da10c4bb613928d3077083c232"
-SRC_URI[serde-1.0.117.sha256sum] = "b88fa983de7720629c9387e9f517353ed404164b1e482c970a90c1a4aaf7dc1a"
-SRC_URI[serde_bytes-0.11.5.sha256sum] = "16ae07dd2f88a366f15bd0632ba725227018c69a1c8550a927324f8eb8368bb9"
-SRC_URI[serde_derive-1.0.117.sha256sum] = "cbd1ae72adb44aab48f325a02444a5fc079349a8d804c1fc922aed3f7454c74e"
-SRC_URI[syn-1.0.48.sha256sum] = "cc371affeffc477f42a221a1e4297aedcea33d47d19b61455588bd9d8f6b19ac"
-SRC_URI[synstructure-0.12.4.sha256sum] = "b834f2d66f734cb897113e34aaff2f1ab4719ca946f9a7358dba8f8064148701"
-SRC_URI[thread_local-1.0.1.sha256sum] = "d40c6d1b69745a6ec6fb1ca717914848da4b44ae29d9b3080cbee91d72a69b14"
-SRC_URI[unicode-xid-0.2.1.sha256sum] = "f7fe0bb3479651439c9112f72b6c505038574c9fbb575ed1bf3b797fa39dd564"
 # from rust/vendor/clap/Cargo.lock
 SRC_URI += " \
     crate://crates.io/addr2line/0.22.0 \
@@ -2847,200 +3041,6 @@ SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] = "147a5c80aabfbf0c7d901cb5895d1de3
 SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
 SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
 SRC_URI[winnow-0.6.13.sha256sum] = "59b5e5f6c299a3c7890b876a2a587f3115162487e704907d9b6cd29473052ba1"
-# from rust/vendor/psl/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/base-x/0.2.11 \
-    crate://crates.io/bumpalo/3.20.2 \
-    crate://crates.io/cfg-if/1.0.4 \
-    crate://crates.io/colored/2.2.0 \
-    crate://crates.io/const_fn/0.4.12 \
-    crate://crates.io/crossbeam-deque/0.8.6 \
-    crate://crates.io/crossbeam-epoch/0.9.18 \
-    crate://crates.io/crossbeam-utils/0.8.21 \
-    crate://crates.io/darling/0.10.2 \
-    crate://crates.io/darling_core/0.10.2 \
-    crate://crates.io/darling_macro/0.10.2 \
-    crate://crates.io/derive-new/0.5.9 \
-    crate://crates.io/derive_builder/0.9.0 \
-    crate://crates.io/derive_builder_core/0.9.0 \
-    crate://crates.io/discard/1.0.4 \
-    crate://crates.io/either/1.15.0 \
-    crate://crates.io/fnv/1.0.7 \
-    crate://crates.io/ident_case/1.0.1 \
-    crate://crates.io/itoa/1.0.17 \
-    crate://crates.io/lazy_static/1.5.0 \
-    crate://crates.io/libc/0.2.182 \
-    crate://crates.io/memchr/2.8.0 \
-    crate://crates.io/once_cell/1.21.3 \
-    crate://crates.io/proc-macro-hack/0.5.20+deprecated \
-    crate://crates.io/proc-macro2/1.0.106 \
-    crate://crates.io/psl-types/2.0.11 \
-    crate://crates.io/quote/1.0.45 \
-    crate://crates.io/rayon/1.11.0 \
-    crate://crates.io/rayon-core/1.13.0 \
-    crate://crates.io/rspec/1.0.0 \
-    crate://crates.io/rustc_version/0.2.3 \
-    crate://crates.io/rustversion/1.0.22 \
-    crate://crates.io/semver/0.9.0 \
-    crate://crates.io/semver-parser/0.7.0 \
-    crate://crates.io/serde/1.0.228 \
-    crate://crates.io/serde_core/1.0.228 \
-    crate://crates.io/serde_derive/1.0.228 \
-    crate://crates.io/serde_json/1.0.149 \
-    crate://crates.io/sha1/0.6.1 \
-    crate://crates.io/sha1_smol/1.0.1 \
-    crate://crates.io/standback/0.2.17 \
-    crate://crates.io/stdweb/0.4.20 \
-    crate://crates.io/stdweb-derive/0.5.3 \
-    crate://crates.io/stdweb-internal-macros/0.2.9 \
-    crate://crates.io/stdweb-internal-runtime/0.1.5 \
-    crate://crates.io/strsim/0.9.3 \
-    crate://crates.io/syn/1.0.109 \
-    crate://crates.io/syn/2.0.117 \
-    crate://crates.io/time/0.2.27 \
-    crate://crates.io/time-macros/0.1.1 \
-    crate://crates.io/time-macros-impl/0.1.2 \
-    crate://crates.io/unicode-ident/1.0.24 \
-    crate://crates.io/version_check/0.9.5 \
-    crate://crates.io/wasm-bindgen/0.2.114 \
-    crate://crates.io/wasm-bindgen-macro/0.2.114 \
-    crate://crates.io/wasm-bindgen-macro-support/0.2.114 \
-    crate://crates.io/wasm-bindgen-shared/0.2.114 \
-    crate://crates.io/winapi/0.3.9 \
-    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
-    crate://crates.io/windows-sys/0.59.0 \
-    crate://crates.io/windows-targets/0.52.6 \
-    crate://crates.io/windows_aarch64_gnullvm/0.52.6 \
-    crate://crates.io/windows_aarch64_msvc/0.52.6 \
-    crate://crates.io/windows_i686_gnu/0.52.6 \
-    crate://crates.io/windows_i686_gnullvm/0.52.6 \
-    crate://crates.io/windows_i686_msvc/0.52.6 \
-    crate://crates.io/windows_x86_64_gnu/0.52.6 \
-    crate://crates.io/windows_x86_64_gnullvm/0.52.6 \
-    crate://crates.io/windows_x86_64_msvc/0.52.6 \
-    crate://crates.io/zmij/1.0.21 \
-"
-
-SRC_URI[base-x-0.2.11.sha256sum] = "4cbbc9d0964165b47557570cce6c952866c2678457aca742aafc9fb771d30270"
-SRC_URI[bumpalo-3.20.2.sha256sum] = "5d20789868f4b01b2f2caec9f5c4e0213b41e3e5702a50157d699ae31ced2fcb"
-SRC_URI[cfg-if-1.0.4.sha256sum] = "9330f8b2ff13f34540b44e946ef35111825727b38d33286ef986142615121801"
-SRC_URI[colored-2.2.0.sha256sum] = "117725a109d387c937a1533ce01b450cbde6b88abceea8473c4d7a85853cda3c"
-SRC_URI[const_fn-0.4.12.sha256sum] = "413d67b29ef1021b4d60f4aa1e925ca031751e213832b4b1d588fae623c05c60"
-SRC_URI[crossbeam-deque-0.8.6.sha256sum] = "9dd111b7b7f7d55b72c0a6ae361660ee5853c9af73f70c3c2ef6858b950e2e51"
-SRC_URI[crossbeam-epoch-0.9.18.sha256sum] = "5b82ac4a3c2ca9c3460964f020e1402edd5753411d7737aa39c3714ad1b5420e"
-SRC_URI[crossbeam-utils-0.8.21.sha256sum] = "d0a5c400df2834b80a4c3327b3aad3a4c4cd4de0629063962b03235697506a28"
-SRC_URI[darling-0.10.2.sha256sum] = "0d706e75d87e35569db781a9b5e2416cff1236a47ed380831f959382ccd5f858"
-SRC_URI[darling_core-0.10.2.sha256sum] = "f0c960ae2da4de88a91b2d920c2a7233b400bc33cb28453a2987822d8392519b"
-SRC_URI[darling_macro-0.10.2.sha256sum] = "d9b5a2f4ac4969822c62224815d069952656cadc7084fdca9751e6d959189b72"
-SRC_URI[derive-new-0.5.9.sha256sum] = "3418329ca0ad70234b9735dc4ceed10af4df60eff9c8e7b06cb5e520d92c3535"
-SRC_URI[derive_builder-0.9.0.sha256sum] = "a2658621297f2cf68762a6f7dc0bb7e1ff2cfd6583daef8ee0fed6f7ec468ec0"
-SRC_URI[derive_builder_core-0.9.0.sha256sum] = "2791ea3e372c8495c0bc2033991d76b512cd799d07491fbd6890124db9458bef"
-SRC_URI[discard-1.0.4.sha256sum] = "212d0f5754cb6769937f4501cc0e67f4f4483c8d2c3e1e922ee9edbe4ab4c7c0"
-SRC_URI[either-1.15.0.sha256sum] = "48c757948c5ede0e46177b7add2e67155f70e33c07fea8284df6576da70b3719"
-SRC_URI[fnv-1.0.7.sha256sum] = "3f9eec918d3f24069decb9af1554cad7c880e2da24a9afd88aca000531ab82c1"
-SRC_URI[ident_case-1.0.1.sha256sum] = "b9e0384b61958566e926dc50660321d12159025e767c18e043daf26b70104c39"
-SRC_URI[itoa-1.0.17.sha256sum] = "92ecc6618181def0457392ccd0ee51198e065e016d1d527a7ac1b6dc7c1f09d2"
-SRC_URI[lazy_static-1.5.0.sha256sum] = "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe"
-SRC_URI[libc-0.2.182.sha256sum] = "6800badb6cb2082ffd7b6a67e6125bb39f18782f793520caee8cb8846be06112"
-SRC_URI[memchr-2.8.0.sha256sum] = "f8ca58f447f06ed17d5fc4043ce1b10dd205e060fb3ce5b979b8ed8e59ff3f79"
-SRC_URI[once_cell-1.21.3.sha256sum] = "42f5e15c9953c5e4ccceeb2e7382a716482c34515315f7b03532b8b4e8393d2d"
-SRC_URI[proc-macro-hack-0.5.20+deprecated.sha256sum] = "dc375e1527247fe1a97d8b7156678dfe7c1af2fc075c9a4db3690ecd2a148068"
-SRC_URI[proc-macro2-1.0.106.sha256sum] = "8fd00f0bb2e90d81d1044c2b32617f68fcb9fa3bb7640c23e9c748e53fb30934"
-SRC_URI[psl-types-2.0.11.sha256sum] = "33cb294fe86a74cbcf50d4445b37da762029549ebeea341421c7c70370f86cac"
-SRC_URI[quote-1.0.45.sha256sum] = "41f2619966050689382d2b44f664f4bc593e129785a36d6ee376ddf37259b924"
-SRC_URI[rayon-1.11.0.sha256sum] = "368f01d005bf8fd9b1206fb6fa653e6c4a81ceb1466406b81792d87c5677a58f"
-SRC_URI[rayon-core-1.13.0.sha256sum] = "22e18b0f0062d30d4230b2e85ff77fdfe4326feb054b9783a3460d8435c8ab91"
-SRC_URI[rspec-1.0.0.sha256sum] = "89389e7c690310e855df3d9b507985ca0d323e2e766b2fedf369b02671e70e0a"
-SRC_URI[rustc_version-0.2.3.sha256sum] = "138e3e0acb6c9fb258b19b67cb8abd63c00679d2851805ea151465464fe9030a"
-SRC_URI[rustversion-1.0.22.sha256sum] = "b39cdef0fa800fc44525c84ccb54a029961a8215f9619753635a9c0d2538d46d"
-SRC_URI[semver-0.9.0.sha256sum] = "1d7eb9ef2c18661902cc47e535f9bc51b78acd254da71d375c2f6720d9a40403"
-SRC_URI[semver-parser-0.7.0.sha256sum] = "388a1df253eca08550bef6c72392cfe7c30914bf41df5269b68cbd6ff8f570a3"
-SRC_URI[serde-1.0.228.sha256sum] = "9a8e94ea7f378bd32cbbd37198a4a91436180c5bb472411e48b5ec2e2124ae9e"
-SRC_URI[serde_core-1.0.228.sha256sum] = "41d385c7d4ca58e59fc732af25c3983b67ac852c1a25000afe1175de458b67ad"
-SRC_URI[serde_derive-1.0.228.sha256sum] = "d540f220d3187173da220f885ab66608367b6574e925011a9353e4badda91d79"
-SRC_URI[serde_json-1.0.149.sha256sum] = "83fc039473c5595ace860d8c4fafa220ff474b3fc6bfdb4293327f1a37e94d86"
-SRC_URI[sha1-0.6.1.sha256sum] = "c1da05c97445caa12d05e848c4a4fcbbea29e748ac28f7e80e9b010392063770"
-SRC_URI[sha1_smol-1.0.1.sha256sum] = "bbfa15b3dddfee50a0fff136974b3e1bde555604ba463834a7eb7deb6417705d"
-SRC_URI[standback-0.2.17.sha256sum] = "e113fb6f3de07a243d434a56ec6f186dfd51cb08448239fe7bcae73f87ff28ff"
-SRC_URI[stdweb-0.4.20.sha256sum] = "d022496b16281348b52d0e30ae99e01a73d737b2f45d38fed4edf79f9325a1d5"
-SRC_URI[stdweb-derive-0.5.3.sha256sum] = "c87a60a40fccc84bef0652345bbbbbe20a605bf5d0ce81719fc476f5c03b50ef"
-SRC_URI[stdweb-internal-macros-0.2.9.sha256sum] = "58fa5ff6ad0d98d1ffa8cb115892b6e69d67799f6763e162a1c9db421dc22e11"
-SRC_URI[stdweb-internal-runtime-0.1.5.sha256sum] = "213701ba3370744dcd1a12960caa4843b3d68b4d1c0a5d575e0d65b2ee9d16c0"
-SRC_URI[strsim-0.9.3.sha256sum] = "6446ced80d6c486436db5c078dde11a9f73d42b57fb273121e160b84f63d894c"
-SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
-SRC_URI[syn-2.0.117.sha256sum] = "e665b8803e7b1d2a727f4023456bbbbe74da67099c585258af0ad9c5013b9b99"
-SRC_URI[time-0.2.27.sha256sum] = "4752a97f8eebd6854ff91f1c1824cd6160626ac4bd44287f7f4ea2035a02a242"
-SRC_URI[time-macros-0.1.1.sha256sum] = "957e9c6e26f12cb6d0dd7fc776bb67a706312e7299aed74c8dd5b17ebb27e2f1"
-SRC_URI[time-macros-impl-0.1.2.sha256sum] = "fd3c141a1b43194f3f56a1411225df8646c55781d5f26db825b3d98507eb482f"
-SRC_URI[unicode-ident-1.0.24.sha256sum] = "e6e4313cd5fcd3dad5cafa179702e2b244f760991f45397d14d4ebf38247da75"
-SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
-SRC_URI[wasm-bindgen-0.2.114.sha256sum] = "6532f9a5c1ece3798cb1c2cfdba640b9b3ba884f5db45973a6f442510a87d38e"
-SRC_URI[wasm-bindgen-macro-0.2.114.sha256sum] = "18a2d50fcf105fb33bb15f00e7a77b772945a2ee45dcf454961fd843e74c18e6"
-SRC_URI[wasm-bindgen-macro-support-0.2.114.sha256sum] = "03ce4caeaac547cdf713d280eda22a730824dd11e6b8c3ca9e42247b25c631e3"
-SRC_URI[wasm-bindgen-shared-0.2.114.sha256sum] = "75a326b8c223ee17883a4251907455a2431acc2791c98c26279376490c378c16"
-SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
-SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
-SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
-SRC_URI[windows-sys-0.59.0.sha256sum] = "1e38bc4d79ed67fd075bcc251a1c39b32a1776bbe92e5bef1f0bf1f8c531853b"
-SRC_URI[windows-targets-0.52.6.sha256sum] = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
-SRC_URI[windows_aarch64_gnullvm-0.52.6.sha256sum] = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
-SRC_URI[windows_aarch64_msvc-0.52.6.sha256sum] = "09ec2a7bb152e2252b53fa7803150007879548bc709c039df7627cabbd05d469"
-SRC_URI[windows_i686_gnu-0.52.6.sha256sum] = "8e9b5ad5ab802e97eb8e295ac6720e509ee4c243f69d781394014ebfe8bbfa0b"
-SRC_URI[windows_i686_gnullvm-0.52.6.sha256sum] = "0eee52d38c090b3caa76c563b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
-SRC_URI[windows_i686_msvc-0.52.6.sha256sum] = "240948bc05c5e7c6dabba28bf89d89ffce3e303022809e73deaefe4f6ec56c66"
-SRC_URI[windows_x86_64_gnu-0.52.6.sha256sum] = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
-SRC_URI[windows_x86_64_gnullvm-0.52.6.sha256sum] = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
-SRC_URI[windows_x86_64_msvc-0.52.6.sha256sum] = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
-SRC_URI[zmij-1.0.21.sha256sum] = "b8848ee67ecc8aedbaf3e4122217aff892639231befc6a1b58d29fff4c2cabaa"
-# from rust/vendor/flate2/Cargo.lock
-SRC_URI += " \
-    crate://crates.io/adler2/2.0.0 \
-    crate://crates.io/cc/1.1.14 \
-    crate://crates.io/cfg-if/1.0.0 \
-    crate://crates.io/cloudflare-zlib-sys/0.3.3 \
-    crate://crates.io/cmake/0.1.50 \
-    crate://crates.io/crc32fast/1.4.0 \
-    crate://crates.io/getrandom/0.2.12 \
-    crate://crates.io/libc/0.2.153 \
-    crate://crates.io/libz-ng-sys/1.1.16 \
-    crate://crates.io/libz-rs-sys/0.4.0 \
-    crate://crates.io/libz-sys/1.1.20 \
-    crate://crates.io/miniz_oxide/0.8.0 \
-    crate://crates.io/pkg-config/0.3.30 \
-    crate://crates.io/ppv-lite86/0.2.17 \
-    crate://crates.io/quickcheck/1.0.3 \
-    crate://crates.io/rand/0.8.5 \
-    crate://crates.io/rand_chacha/0.3.1 \
-    crate://crates.io/rand_core/0.6.4 \
-    crate://crates.io/shlex/1.3.0 \
-    crate://crates.io/vcpkg/0.2.15 \
-    crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
-    crate://crates.io/zlib-rs/0.4.0 \
-"
-
-SRC_URI[adler2-2.0.0.sha256sum] = "512761e0bb2578dd7380c6baaa0f4ce03e84f95e960231d1dec8bf4d7d6e2627"
-SRC_URI[cc-1.1.14.sha256sum] = "50d2eb3cd3d1bf4529e31c215ee6f93ec5a3d536d9f578f93d9d33ee19562932"
-SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[cloudflare-zlib-sys-0.3.3.sha256sum] = "c3185ff8c69c53ab346d5ac89f418e194b997d48393cae321cb611dd05f83c90"
-SRC_URI[cmake-0.1.50.sha256sum] = "a31c789563b815f77f4250caee12365734369f942439b7defd71e18a48197130"
-SRC_URI[crc32fast-1.4.0.sha256sum] = "b3855a8a784b474f333699ef2bbca9db2c4a1f6d9088a90a2d25b1eb53111eaa"
-SRC_URI[getrandom-0.2.12.sha256sum] = "190092ea657667030ac6a35e305e62fc4dd69fd98ac98631e5d3a2b1575a12b5"
-SRC_URI[libc-0.2.153.sha256sum] = "9c198f91728a82281a64e1f4f9eeb25d82cb32a5de251c6bd1b5154d63a8e7bd"
-SRC_URI[libz-ng-sys-1.1.16.sha256sum] = "4436751a01da56f1277f323c80d584ffad94a3d14aecd959dd0dff75aa73a438"
-SRC_URI[libz-rs-sys-0.4.0.sha256sum] = "39cc71ac688c22a9f5730a38171ac94795c071ac81d1a0ab5537f6ef164fff30"
-SRC_URI[libz-sys-1.1.20.sha256sum] = "d2d16453e800a8cf6dd2fc3eb4bc99b786a9b90c663b8559a5b1a041bf89e472"
-SRC_URI[miniz_oxide-0.8.0.sha256sum] = "e2d80299ef12ff69b16a84bb182e3b9df68b5a91574d3d4fa6e41b65deec4df1"
-SRC_URI[pkg-config-0.3.30.sha256sum] = "d231b230927b5e4ad203db57bbcbee2802f6bce620b1e4a9024a07d94e2907ec"
-SRC_URI[ppv-lite86-0.2.17.sha256sum] = "5b40af805b3121feab8a3c29f04d8ad262fa8e0561883e7653e024ae4479e6de"
-SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
-SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
-SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
-SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
-SRC_URI[shlex-1.3.0.sha256sum] = "0fda2ff0d084019ba4d7c6f371c95d8fd75ce3524c3cb8fb653a3023f6323e64"
-SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
-SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
-SRC_URI[zlib-rs-0.4.0.sha256sum] = "2ca4a9dc6566c9224cc161dedc5577bd81f4a9ee0f9fbe80592756d096b07ee5"
 
 SRC_URI[autocfg-1.0.0.sha256sum] = "f8aac770f1885fd7e387acedd76065302551364496e46b3dd00860b2f8359b9d"
 SRC_URI[bstr-0.2.13.sha256sum] = "31accafdb70df7871592c058eca3985b71104e15ac32f64706022c58867da931"
@@ -3148,3 +3148,4 @@ SRC_URI[wasm-bindgen-shared-0.2.68.sha256sum] = "1d649a3145108d7d3fbcde896a468d1
 SRC_URI[web-sys-0.3.45.sha256sum] = "4bf6ef87ad7ae8008e15a355ce696bed26012b7caa21605188cfd8214ab51e2d"
 SRC_URI[winapi-0.2.8.sha256sum] = "167dc9d6949a9b857f3451275e911c3f44255842c1f7a76f33c55103a909087a"
 SRC_URI[winapi-build-0.1.1.sha256sum] = "2d315eee3b34aca4797b2da6b13ed88266e6d612562a0c46390af8299fc699bc"
+
diff --git a/recipes-ids/suricata/suricata_8.0.4.bb b/recipes-ids/suricata/suricata_8.0.6.bb
similarity index 98%
rename from recipes-ids/suricata/suricata_8.0.4.bb
rename to recipes-ids/suricata/suricata_8.0.6.bb
index 5ae0d97..29f259b 100644
--- a/recipes-ids/suricata/suricata_8.0.4.bb
+++ b/recipes-ids/suricata/suricata_8.0.6.bb
@@ -5,7 +5,7 @@ require suricata.inc
 LIC_FILES_CHKSUM = "file://LICENSE;beginline=1;endline=2;md5=c70d8d3310941dcdfcd1e02800a1f548"
 
 SRC_URI = "http://www.openinfosecfoundation.org/download/suricata-${PV}.tar.gz"
-SRC_URI[sha256sum] = "81cee7bae69848a9751b2ce0867620eefa52b192e79c20b5eac897600b28b191"
+SRC_URI[sha256sum] = "b264584edda4a3b2b462050099c7c54f4f35ac0c7164e41084be9b216c090f8c"
 
 DEPENDS = "jansson lz4"
 DEPENDS:append:libc-musl = " libunwind"
-- 
2.55.0


