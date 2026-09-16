Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9403AC982C1
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:31:03 +0000 (UTC)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27129.1789597854684390678
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=p4DloOgQ;
 spf=pass (domain: konsulko.com, ip: 74.125.230.205, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910a0cb7aso15221685a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597854; x=1790202654; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hszUt/DVlclh2KPOqFXHNnGL7bF2bwV2ABKNyTxbDPc=;
        b=p4DloOgQSIm5TRdKjtRxQhR/mFgDSnQALSTzSp40+fvFvBEJkjo1/DNeTUBsCXlz+G
         Rh9cPoH99FkMuLhKEqGbCncvCOp+0Z1SDDp7bB6elHUggEkLNFwYYzz3GgPiVIy/m4YR
         Y1enf6Jzgc/SfPouG8zS1Lq5iX6mc9Xsg8rsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597854; x=1790202654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hszUt/DVlclh2KPOqFXHNnGL7bF2bwV2ABKNyTxbDPc=;
        b=JEtbbcW/Q6xaCW4jcQw/eLKmjQkk5WGPOecAf6Y8irbqAKGRsv5cc4plQlDKONmxnx
         qN86u0Tcd5XsZe0G6zyCnvOm8EdmXNf+drSl3d8/XejIQOmIE6AyM40YIuEpLyc0Tkxt
         ctK+vVUc/JtAg7+pB2tH/RcTIFh0UGdILpi7slZWJD7BeUC16obxzE/ifiUz8R6HOdjV
         T4pBq79hEIDn2leHUO+D3x0dhQGDG2+R9B5I/VeICKHo9KFjzeaZIAPMP8RQiI9pNhjz
         I4d7cjachLO86ugPAz/mntbG1aSY80JcuoiWWmvlSJbx3OrawP/X30pYFuZbgvjOUolD
         YdLw==
X-Gm-Message-State: AFuF++mOsQReab3LJr85aO/J1J78PH/3JZ6ccTBV0V100IjVJMOxXfcn
	1PQEvsPqJz1RvegG2OZzk33jeiX4uVl9znDdowW3WP9+Aqn7EmUIoj6Nx9wCKkHFDEhEE4BPlh2
	Oorar
X-Gm-Gg: AYBFou3mrrFb3yQN0rVBBpvBDwSzeCNkD2bm9G4uvJUJ+8SUQoC1s7+de46BKPqmyW9
	E9fzVXTe6ruj5qY0lEs6h2ZUTNBge7h7bLxMoMW1BHEe5Q5RrX2F4IcpOxoM5jmV/2jRDFVshVE
	TE8yuPPgrtynXrBfBzFHK8pnnHb8RuD2riQF4J8YuXC7tGhranf+hhmdHkkzck7CIOWMDLYGMmp
	0/P8qYASs9L+Ib9DevwE6FfueUcoXoW1LCCJZ224exeH5/3wgqFk1jZGrwcyY5GpKrI/U8i9e82
	8zFGLoWAhoQg2nnvw3xFBFOp+CUQ++pCG1e8NleICiYdBYH0aevqDEkH+xDBosKnf9AWKGldI6R
	a30lBGboicTmVISPban1+VqmRJfjm4lQlaBhMq40pI0N8YqeMlDY8GVq9W4al3U7DH+0O+5eA7B
	FRG6hretjW1MCrm/fMphUKqRix9hrFVnfBY8QJfp9b6QdyAeMRHtgue6KyQIc3CVYuNlhJr6fjX
	740RUMQuiuNG1IvgXbg3Md1uLtMKkpmWUeYpa/zCHluVY5Q3Wjq092znMIDX7cTtcsYbo2mzStT
	Tzox37nZt6yrz2Tk5e+P+cJDIhyW5FF+PLk=
X-Received: by 2002:a05:620a:1792:b0:937:6de8:b40 with SMTP id af79cd13be357-93bb7774487mr723953985a.15.1789597852339;
        Wed, 16 Sep 2026 15:30:52 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:51 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 22/24] crowdsec: upgrade 1.7.7 -> 1.8.1
Date: Wed, 16 Sep 2026 18:30:16 -0400
Message-ID: <81e1c3721655bf0eccb8204713a474f9bb88fa1d.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:31:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4898

Release notes:
https://github.com/crowdsecurity/crowdsec/releases/tag/v1.7.8
https://github.com/crowdsecurity/crowdsec/releases/tag/v1.8.0
https://github.com/crowdsecurity/crowdsec/releases/tag/v1.8.1

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/crowdsec/crowdsec-go-mods.inc     | 408 +++++++++---------
 recipes-ids/crowdsec/crowdsec-licenses.inc    | 321 +++++++-------
 .../{crowdsec_1.7.7.bb => crowdsec_1.8.1.bb}  |   2 +-
 3 files changed, 374 insertions(+), 357 deletions(-)
 rename recipes-ids/crowdsec/{crowdsec_1.7.7.bb => crowdsec_1.8.1.bb} (96%)

diff --git a/recipes-ids/crowdsec/crowdsec-go-mods.inc b/recipes-ids/crowdsec/crowdsec-go-mods.inc
index efdc7f3..31428e8 100644
--- a/recipes-ids/crowdsec/crowdsec-go-mods.inc
+++ b/recipes-ids/crowdsec/crowdsec-go-mods.inc
@@ -5,71 +5,70 @@
 # running the update-modules task.
 
 SRC_URI += "\
-    gomod://ariga.io/atlas;version=v0.31.1-0.20250212144724-069be8033e83;sha256sum=28fe83c0a57bd41a859cf9284fba1061893d1c415e511b882ee41027fb52277d \
-    gomod://entgo.io/ent;version=v0.14.2;sha256sum=c21e4f67b52453a8a3a37326fa5a208cca1f989f5f37533877f097be197476e1 \
-    gomod://filippo.io/edwards25519;version=v1.1.1;sha256sum=7e620dc84053ca8bf68180bbeada20ff586b1b9ebd8398039a5f7d5da17d3bb3 \
+    gomod://ariga.io/atlas;version=v1.1.0;sha256sum=1e8161d91f8f07204edb35fe4048cf75605e378df5bfdc60b6a9174d7a57e833 \
+    gomod://dario.cat/mergo;version=v1.0.2;sha256sum=67d2e9d83ca57d3a8ce1a0e0e626a7c03753b3966b58b41b95e97ca4e7b2c640 \
+    gomod://entgo.io/ent;version=v0.14.6;sha256sum=cf316ab8814166ec8870f2ebc89f7ea1d0ab6ca14abc8ab653c60f6cf2a49752 \
+    gomod://filippo.io/edwards25519;version=v1.2.0;sha256sum=98f2d3ca9b88daa031b0fb2fb521b7ea386af1fed61b6f445a20bef7fa381c17 \
     gomod://github.com/AlecAivazis/survey/v2;version=v2.3.7;sha256sum=613a49c86cab69b67fbc8fb0f0b183c23bfdc2700122330c6b53020e01ebad60 \
     gomod://github.com/BurntSushi/toml;version=v0.3.1;mod=1;sha256sum=28021b4180a59c3993607a95b18e230dd0bc6bea5242ffe8ea8bbfb4f4f7b4d7 \
     gomod://github.com/Masterminds/goutils;version=v1.1.1;sha256sum=ef8778a20c37e98a92e3b1db5ab027cc201743a2f5bfb26ba228bf0515e20b48 \
     gomod://github.com/Masterminds/semver/v3;version=v3.1.1;mod=1;sha256sum=0c22bf64508de083dc1e895935cffd9188ca546af08244e2f0b7a21e9ea023e4 \
-    gomod://github.com/Masterminds/semver/v3;version=v3.2.0;mod=1;sha256sum=dcfed332546566ccebdfb44841c8d7b7c865f54eabfe1984a6cc44acb5d6ed84 \
-    gomod://github.com/Masterminds/semver/v3;version=v3.2.1;sha256sum=d3e3b1dae669d44d9f92a314e02c3b2bbff2c5b2463f650cdbb7340f413e854b \
-    gomod://github.com/Masterminds/sprig/v3;version=v3.2.3;sha256sum=2c533a1f9e700498bff05b051656e1024ffade38fe9a3e8bdfc439ee51d4821b \
+    gomod://github.com/Masterminds/semver/v3;version=v3.5.0;sha256sum=2cda916821eedb0e1d7ac45d80b6cb78320b035f0f77272ff18d082b7cd90713 \
+    gomod://github.com/Masterminds/sprig/v3;version=v3.3.0;sha256sum=c731370f7601711d1df9b4b0c9bb8488fc381b32fd3e7de97a03673e8287b719 \
     gomod://github.com/Microsoft/go-winio;version=v0.6.2;mod=1;sha256sum=47fb19990ebb31954f3aa784ff45f4c93a9e86ac3e1297d7ca87c614aeffe2cb \
     gomod://github.com/Netflix/go-expect;version=v0.0.0-20220104043353-73e0943537d2;mod=1;sha256sum=7e6a4e2dcf2df58a58cb81042f0d0ed99506f8c87667a89b11445116e6100b90 \
     gomod://github.com/agext/levenshtein;version=v1.2.3;sha256sum=f24dcae174b3418f6340fb8f54797788a71130b960da4f07d3e08206cbcbdc02 \
     gomod://github.com/alexliesenfeld/health;version=v0.8.1;sha256sum=687dc6b0928b4ca68e9ce580f5197cc55f9e9e798873915accb64f198d4c3b58 \
-    gomod://github.com/apparentlymart/go-textseg/v13;version=v13.0.0;sha256sum=f3035ffd839b39f39c1802cde4f9a261eec50350c47e8edf1720bf8ef2d0d9fa \
     gomod://github.com/apparentlymart/go-textseg/v15;version=v15.0.0;sha256sum=4886c2e43b8cd2f6ffbd3a78ef436bd7bc8da7825ab7426257969f346e7bb7eb \
     gomod://github.com/appleboy/gin-jwt/v2;version=v2.10.3;sha256sum=9c7359efc2d016bae0e976f9654a3ec56a875042b220857f635760b1c59b3688 \
-    gomod://github.com/asaskevich/govalidator;version=v0.0.0-20230301143203-a9d515a09cc2;sha256sum=0f8ec67bbc585d29ec115c0885cef6f2431a422cc1cc10008e466ebe8be5dc37 \
-    gomod://github.com/aws/aws-lambda-go;version=v1.47.0;sha256sum=8c376e0fc949b13d0ee3a7faea6e42e78446d1b8837dd70cd5039c161bcdc472 \
-    gomod://github.com/aws/aws-sdk-go-v2;version=v1.38.3;sha256sum=75ae4efcd06297afff7cec080ed7e1dfa9227f64fc7e9a3c5a54a8d53491d244 \
-    gomod://github.com/aws/aws-sdk-go-v2/aws/protocol/eventstream;version=v1.7.1;sha256sum=353f2cfb65dc2cfab4edb7c0734e9efeffaa17028f9310a16f584a31554af6b1 \
-    gomod://github.com/aws/aws-sdk-go-v2/config;version=v1.31.6;sha256sum=f1ea171a198d9d28c677d770e569e185d8595eefb5d23026cc7dfc483afe26f1 \
-    gomod://github.com/aws/aws-sdk-go-v2/credentials;version=v1.18.10;sha256sum=b0d7ab8c94bdcdb6b4b852253b99f40e9781786eca6cea803bc067316e871f37 \
-    gomod://github.com/aws/aws-sdk-go-v2/feature/ec2/imds;version=v1.18.6;sha256sum=289cc88b4845db6da2e47552baf919acaf9ce9988628a5bae37db8defe064d02 \
-    gomod://github.com/aws/aws-sdk-go-v2/feature/s3/manager;version=v1.19.4;sha256sum=e5a87121aeeb60e836ced35aef2914bdec380050761ae6a81275d9c53bc4a7c7 \
-    gomod://github.com/aws/aws-sdk-go-v2/internal/configsources;version=v1.4.6;sha256sum=836183db8a8a13303444c9c43731f05f076e66c2edfe9b76958bf351e197bcfc \
-    gomod://github.com/aws/aws-sdk-go-v2/internal/endpoints/v2;version=v2.7.6;sha256sum=df22fff8b677924c88c179109ce95d34f53c76e2a4b83e6a8366a2a73eb8fc8e \
-    gomod://github.com/aws/aws-sdk-go-v2/internal/ini;version=v1.8.3;sha256sum=7c134d09366b976ea1362c3dca8a394e130182af739a792d7b16089eefa8a514 \
-    gomod://github.com/aws/aws-sdk-go-v2/internal/v4a;version=v1.4.6;sha256sum=ec2323e472854758865d8bbd54d529418719a46f628073a0ad589ba30a4c4a56 \
-    gomod://github.com/aws/aws-sdk-go-v2/service/cloudwatchlogs;version=v1.57.2;sha256sum=3435598cd204de80dd9463ba40b9d4d75ed313cb30cdf25f0fbabb6eb1d604e0 \
-    gomod://github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding;version=v1.13.1;sha256sum=ae96d9155ddc1b4981ec4ef3957b3fd446a760aea9292f6e180fdfa2506bef43 \
-    gomod://github.com/aws/aws-sdk-go-v2/service/internal/checksum;version=v1.8.6;sha256sum=a51af1acad71f770f6a0c1557c828bb43ae9d07a808825bc7c813ba6ecc6218d \
-    gomod://github.com/aws/aws-sdk-go-v2/service/internal/presigned-url;version=v1.13.6;sha256sum=dc1f26ffea71e7e5a1e96a279de3bec58ccfe6f1c482af8eb7804e249e459b86 \
-    gomod://github.com/aws/aws-sdk-go-v2/service/internal/s3shared;version=v1.19.6;sha256sum=8945055471496857f9c051d05f31e0ef8cc8e31452d5bbded2244ef52a68fc98 \
-    gomod://github.com/aws/aws-sdk-go-v2/service/kinesis;version=v1.40.1;sha256sum=e5c5fd7799b4d5f6807068af2f25d113661836ae99ff9cd4bb6c09025fdd2e6b \
-    gomod://github.com/aws/aws-sdk-go-v2/service/s3;version=v1.87.3;sha256sum=0647d8e741acbb3997b580ae09e85e6d85dee2c62b3bc02f4ff14407197cbe89 \
-    gomod://github.com/aws/aws-sdk-go-v2/service/sqs;version=v1.42.3;sha256sum=4720fa7e83a3e823dadd1d952628bd760b9cf4b7994b4571e5ad027d1bbc1905 \
-    gomod://github.com/aws/aws-sdk-go-v2/service/sso;version=v1.29.1;sha256sum=198f413c0864daec704b1069e50efb3d0c78f494525b09c27c4edae5016e4150 \
-    gomod://github.com/aws/aws-sdk-go-v2/service/ssooidc;version=v1.34.2;sha256sum=90cbec71c105f184dc08d7996bda517bc1d7c85e49da517a6ed8630034a5ca5f \
-    gomod://github.com/aws/aws-sdk-go-v2/service/sts;version=v1.38.2;sha256sum=9a25104836efda5369d5377790463df2a8832a68fa593a208ebb5b9a85d492e1 \
-    gomod://github.com/aws/smithy-go;version=v1.23.0;sha256sum=637116dbe7e99c3146f5c9043703a7f2317784d748e208655111bfb4e5cf8095 \
-    gomod://github.com/beevik/etree;version=v1.4.1;sha256sum=5a0cfc145267ee9d8199affbe4f93700219ed479bc053f8b260f650c00eef7b5 \
+    gomod://github.com/aws/aws-lambda-go;version=v1.54.0;sha256sum=4dc4a889cf28e306149e4845a29355163e561e58d3b44ccca8af2fe4a9ebf40c \
+    gomod://github.com/aws/aws-sdk-go-v2;version=v1.43.6;sha256sum=d07b16918a5d088d78bcbc800f9b4cfb3280a6c509df7ca7dbc46e723b70c9eb \
+    gomod://github.com/aws/aws-sdk-go-v2/aws/protocol/eventstream;version=v1.7.18;sha256sum=df6b679e2d32e966cdd363be28264f226e25e1ad35030e793add3816c11cc517 \
+    gomod://github.com/aws/aws-sdk-go-v2/config;version=v1.32.37;sha256sum=c77e4d9abf5526331107dcd02ebf4f8a467cc2ece2da028f97017c08efbf6f3d \
+    gomod://github.com/aws/aws-sdk-go-v2/credentials;version=v1.19.36;sha256sum=b6da89b27832da6aadb9df0f1e30a20371dca3c349f5544ea267c2ff5040438d \
+    gomod://github.com/aws/aws-sdk-go-v2/feature/ec2/imds;version=v1.18.37;sha256sum=4c4bfc37500b8c94ea8029f5db25c70cb53418e7b6af43655b56657b3815f8df \
+    gomod://github.com/aws/aws-sdk-go-v2/feature/s3/manager;version=v1.22.43;sha256sum=3d3046f7dce9fbe961b9c7faecba25cde3d68c9b16ef99216f1da33224860b89 \
+    gomod://github.com/aws/aws-sdk-go-v2/internal/configsources;version=v1.4.37;sha256sum=c95bda31df03689a4516b1be7a92b6bf5fb8933f1feb818633b4f4fc45a91a26 \
+    gomod://github.com/aws/aws-sdk-go-v2/internal/endpoints/v2;version=v2.7.37;sha256sum=19c76b91b117034d899864f5787bec2dd74640a29ebd5f2027beb81f3a053399 \
+    gomod://github.com/aws/aws-sdk-go-v2/internal/v4a;version=v1.4.38;sha256sum=49d13292e116e8ea0d49cd96bb5524b52bc019823cfce36f5fa1fa48f4a739a8 \
+    gomod://github.com/aws/aws-sdk-go-v2/service/cloudwatchlogs;version=v1.82.2;sha256sum=115867a776c83e11b0316c0f204d11137889ea5a37360d0546ab1edce20ef487 \
+    gomod://github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding;version=v1.13.17;sha256sum=5da6d06e605d71ee3202d46bf2b11c20512210a9c641cb34541690995dcbb6d9 \
+    gomod://github.com/aws/aws-sdk-go-v2/service/internal/checksum;version=v1.9.30;sha256sum=9cf039ac3e98217e34c6d6078a9d4088cc74ccb2bd1b232196fcfe6112f86d1a \
+    gomod://github.com/aws/aws-sdk-go-v2/service/internal/presigned-url;version=v1.13.37;sha256sum=1f0f45888b51a524e091c8c3534aeaaca1a6e5d5aaede79f8249169615b222af \
+    gomod://github.com/aws/aws-sdk-go-v2/service/internal/s3shared;version=v1.19.38;sha256sum=207a5e12107653ad9c2b883ce0af9a3e025ca1b84c7d71e57e29b7f697a6da44 \
+    gomod://github.com/aws/aws-sdk-go-v2/service/kinesis;version=v1.46.6;sha256sum=e2a0c30bed2e361ae1b7868639039230f697e2c2c4c6ce24e5b0e5a3c0d7d2dc \
+    gomod://github.com/aws/aws-sdk-go-v2/service/s3;version=v1.107.2;sha256sum=173d0a705649cea5d63c95e18acda146e99ff6bff3427a9014769807cdf12c5f \
+    gomod://github.com/aws/aws-sdk-go-v2/service/signin;version=v1.5.6;sha256sum=6720b3e00de03856b23d4fdde8f8fd1f67135d104f5bdcafe2fe99975111252b \
+    gomod://github.com/aws/aws-sdk-go-v2/service/sqs;version=v1.46.6;sha256sum=5fcf9709577b18c9dac9f8f68ffee9dea4125418ffb02a4553a7f08843ebc375 \
+    gomod://github.com/aws/aws-sdk-go-v2/service/sso;version=v1.33.6;sha256sum=f2ea291a6e939f3c144291d0dc01e81762061a2157de6df24fe96b0f848bc4bc \
+    gomod://github.com/aws/aws-sdk-go-v2/service/ssooidc;version=v1.38.6;sha256sum=688a033c71b9ecc71c0ee414a2be6adf19b7a679fa851604b7edada850e9aff1 \
+    gomod://github.com/aws/aws-sdk-go-v2/service/sts;version=v1.45.6;sha256sum=6bea363338e61ca9049f3102c20fda348df3c3d12bee2bb46568d3ab63af8333 \
+    gomod://github.com/aws/smithy-go;version=v1.27.8;sha256sum=831b02e1447db3c2d47cefb15b184bd522f26db41cfd28e2635da87e030fdf69 \
+    gomod://github.com/beevik/etree;version=v1.7.1;sha256sum=b4885ad91fd1f277ae10a067b927443443b08539a11ea46e7ddf61839f698ea8 \
     gomod://github.com/beorn7/perks;version=v1.0.1;sha256sum=25bd9e2d94aca770e6dbc1f53725f84f6af4432f631d35dd2c46f96ef0512f1a \
     gomod://github.com/bluele/gcache;version=v0.0.2;sha256sum=6b74bf6b1a6c2d961e2cb6bd01f42d37f6f70bc340394a0b052a65486e26df7f \
     gomod://github.com/bmatcuk/doublestar;version=v1.3.4;sha256sum=6da867cec2e9e748762e9c8d84b01e220a0fe4d917425be7825f9152c262a402 \
-    gomod://github.com/buger/jsonparser;version=v1.1.2;sha256sum=07495b55fbdae886bcc970b6f5d5073435b5980291dc92674c53ab31d1ad298f \
-    gomod://github.com/bytedance/sonic;version=v1.13.2;mod=1;sha256sum=48b374e6376605f71430279429e7a3aa12f7291138a799e6af817fac2f4daf80 \
-    gomod://github.com/bytedance/sonic/loader;version=v0.1.1;mod=1;sha256sum=bb556f6ca29deaa276165a425c8f54fc15c204b048acd5fe9f702122c11a9163 \
-    gomod://github.com/bytedance/sonic/loader;version=v0.2.4;mod=1;sha256sum=1235cd86fbdaf29fa9f2b6050f907b90be31688208f5d7199dcba9d6aecec31f \
+    gomod://github.com/buger/jsonparser;version=v1.6.1;sha256sum=672b5eafb3cfaf6d9df425332e440b8dcb692d3b0f2c3addb550d022730e761d \
+    gomod://github.com/bytedance/gopkg;version=v0.1.4;mod=1;sha256sum=2696b4470b22849ec7f594e9f3c438371e7dd2e89fcbcbf305bde4c691f80fb1 \
+    gomod://github.com/bytedance/sonic;version=v1.15.0;mod=1;sha256sum=4f7430bec0c45be62275926dff5d5fa20decdf54222ef44124ebcf9fb3389bc9 \
+    gomod://github.com/bytedance/sonic/loader;version=v0.5.1;mod=1;sha256sum=c5b463f674a8ce937d7c88d4bfaf9b65044818392acd86eb176e543bc30c5c7a \
     gomod://github.com/cenkalti/backoff/v5;version=v5.0.3;sha256sum=58e4d9014277bc1c5c7ab64539137923964cc3920303a4f771d02a532939bedb \
     gomod://github.com/cespare/xxhash/v2;version=v2.3.0;sha256sum=145a26cdc7c49db566017b807c4989ee7f7ddeb569423e9cb99f995fac3621d3 \
-    gomod://github.com/cloudwego/base64x;version=v0.1.5;mod=1;sha256sum=bcc4065e9bd9d1bc09c7853d20b725e9412d94b44b200548c14f263437b916fb \
-    gomod://github.com/cloudwego/iasm;version=v0.2.0;mod=1;sha256sum=f5acaceec1bd6e113747f772710d7a057560812a7366978123ef2800a6b102ae \
+    gomod://github.com/clipperhouse/uax29/v2;version=v2.7.0;sha256sum=67b1278f1ffb4e4d783a390e48fe7396864650138e785d4b4bfca5914333f761 \
+    gomod://github.com/cloudwego/base64x;version=v0.1.6;mod=1;sha256sum=8b494d199b3660a3320b502e73d59e20ef7da2ee802d643d3a5dfb33ef132121 \
     gomod://github.com/cockroachdb/apd;version=v1.1.0;mod=1;sha256sum=46ec9e27ae0d6eb416eb02e219eb609747461362358fc17cf32d1bc3f929a0da \
     gomod://github.com/containerd/errdefs;version=v1.0.0;sha256sum=b4ef42c38d00f2c81cf3e69646549b7f5dc8fb72de9402d7b391963dc0ac9162 \
     gomod://github.com/containerd/errdefs/pkg;version=v0.3.0;sha256sum=593bf56f1991517e493510815d8fc6d344b8550fbfb3de56812f015096aab24f \
-    gomod://github.com/corazawaf/libinjection-go;version=v0.2.2;sha256sum=eca55f2ee6ca8d235823090dd3c11a1124f35118cd16d4dd67cb3955df9e9587 \
+    gomod://github.com/corazawaf/libinjection-go;version=v0.3.2;sha256sum=034e123baa084430b11ec601ae6310e5508c558245de2cf0ea831a5cbc160ca2 \
     gomod://github.com/coreos/go-systemd;version=v0.0.0-20190321100706-95778dfbb74e;mod=1;sha256sum=dceb172eab082cca6a93107d9fbdde58e1d213fcab1bb81277c58da738177dcd \
     gomod://github.com/coreos/go-systemd;version=v0.0.0-20190719114852-fd7a80b32e1f;mod=1;sha256sum=dceb172eab082cca6a93107d9fbdde58e1d213fcab1bb81277c58da738177dcd \
-    gomod://github.com/coreos/go-systemd/v22;version=v22.5.0;sha256sum=4c44e3a6b84de4db393e341537c7124031fa98d5f98860ad31b32b4890f2234c \
+    gomod://github.com/coreos/go-systemd/v22;version=v22.7.0;sha256sum=25c78b5dae5afa61291a8559328007cc77e60dd6747454af5c83423c26cfdfba \
     gomod://github.com/cpuguy83/go-md2man/v2;version=v2.0.1;mod=1;sha256sum=14c3afa2ef623555c1b4834d1f88b14df77549afee85e5750c19102465b78aba \
-    gomod://github.com/cpuguy83/go-md2man/v2;version=v2.0.6;sha256sum=b8059316e38bcfd28b69d2c2b32d34b9e800ccaa1ff4b5a61022cbe98fa7c710 \
+    gomod://github.com/cpuguy83/go-md2man/v2;version=v2.0.6;mod=1;sha256sum=bb81a9e2d14d9a586f0591853bdaad230d8cdf0d8d6ffa71dddae249ad573cc9 \
+    gomod://github.com/cpuguy83/go-md2man/v2;version=v2.0.7;sha256sum=9ad5f2cbc644c0bb648a9b182d6b70f92e7ac4dfab5cf0ef746bbeef944fda59 \
     gomod://github.com/creack/pty;version=v1.1.17;mod=1;sha256sum=0413a4191dccd6c75b0cc74cb71af1564070f2ecbfce3ab4ba3ccc9d701fd82c \
     gomod://github.com/creack/pty;version=v1.1.7;mod=1;sha256sum=5ec31d31b68c8b9854e121e09d579444eb7708b2b815a078bfa452c2e25b7b14 \
-    gomod://github.com/crowdsecurity/coraza/v3;version=v3.3.3-crowdsec.20251113;sha256sum=6843c723c3eeb464a9f9c56feba3af79811d347f3363b0f42566ec1a2124a9b5 \
+    gomod://github.com/crowdsecurity/coraza/v3;version=v3.7.0-crowdsec.20260730;sha256sum=1848c256583056af990a73fe814f401627eeefa3d6d4c8c1a0bd39f0b99b5b30 \
     gomod://github.com/crowdsecurity/dlog;version=v0.0.2;sha256sum=9769acaa57ea316b541bc68f19d5ed16050ca02146db16e7a579447c01b21645 \
     gomod://github.com/crowdsecurity/go-cs-lib;version=v0.0.25;sha256sum=117acf585de553fcbf1df5bf65f0646b3f952cb5db252d1da0d8a49f78707d6e \
     gomod://github.com/crowdsecurity/grokky;version=v0.2.2;sha256sum=71ff3370e344569c085b147c086512dc321f9b98834e9997759d5c97dcef947d \
@@ -80,82 +79,88 @@ SRC_URI += "\
     gomod://github.com/davecgh/go-spew;version=v1.1.1;mod=1;sha256sum=bcb29393251237b79a17b6c19bf29134f43e8f438c3198988fcd461a1cdf05cc \
     gomod://github.com/davecgh/go-spew;version=v1.1.2-0.20180830191138-d8f796af33cc;sha256sum=b4d0923b169b194f0016ec46f3df1ab0c68e27999743e43fe2de59ecb2484128 \
     gomod://github.com/distribution/reference;version=v0.6.0;sha256sum=08232852a7a908263599777daab50e4306bd877e2467df036206367496122bcc \
-    gomod://github.com/docker/go-connections;version=v0.6.0;sha256sum=c9847dae346c572e5e35cbd910ab3cb8ba7bf2bf2bb63a733e53031dd6d17127 \
+    gomod://github.com/docker/go-connections;version=v0.7.0;sha256sum=44c583ae40f15bd8abfe95a8b243d121ffef79b4605e8c737e24d5853188746e \
     gomod://github.com/docker/go-units;version=v0.5.0;sha256sum=039d53ebe64af1aefa0be94ce42c621a17a3052c58ad15e5b3f357529beeaff6 \
     gomod://github.com/dustin/go-humanize;version=v1.0.1;mod=1;sha256sum=4325999d0a6841031258a2561c22879d9fbdf77abc6b32a17b1cb6edf0810fb2 \
-    gomod://github.com/ebitengine/purego;version=v0.8.4;mod=1;sha256sum=4920ecc5239d79446d9b61542c3749c7389d2178d3a142e557e0379051866514 \
-    gomod://github.com/expr-lang/expr;version=v1.17.7;sha256sum=9b0cbf9e267d26edde2e5b50a2b33fbfe5c0db5b70a528915e46fe2cae27abcd \
+    gomod://github.com/ebitengine/purego;version=v0.10.2;mod=1;sha256sum=4920ecc5239d79446d9b61542c3749c7389d2178d3a142e557e0379051866514 \
+    gomod://github.com/emicklei/go-restful/v3;version=v3.13.0;sha256sum=06bd60484b324de0b8e4366d4ed326db2e1dc730459b46e19a5306a108439c77 \
+    gomod://github.com/evanw/esbuild;version=v0.28.2;sha256sum=db0fc2918ef7d1769b1746ed123d40db4f92636e2536dda4e40f5d080ae30de2 \
+    gomod://github.com/expr-lang/expr;version=v1.17.8;sha256sum=82210321f9078349af5dbf774e2a2d9f4aabe79db23a3124034722cdc632cd80 \
     gomod://github.com/fatih/color;version=v1.13.0;mod=1;sha256sum=f0ac49fdf878d4b36897025bfb18639e2fe67d884cea8e324e5c1915697f8b1c \
-    gomod://github.com/fatih/color;version=v1.18.0;sha256sum=4dc6907b7f6807b37c21ad527d966437d398f03472115f471eaa8fe5875363d3 \
+    gomod://github.com/fatih/color;version=v1.19.0;sha256sum=694b4265dc678e2a65b196371d5a6ec4eed3739f12a16021dcd2f0c1355d0ec6 \
     gomod://github.com/felixge/httpsnoop;version=v1.0.4;sha256sum=75aa471311265e9860df0e523400b4650ed0c1a33262786a421f07226792e494 \
+    gomod://github.com/fsnotify/fsnotify;version=v1.10.1;sha256sum=b2c6a334e0d518da2e046066bdd9da34cb26bad6df9f17701802d3de522ab016 \
     gomod://github.com/fsnotify/fsnotify;version=v1.6.0;mod=1;sha256sum=83bf51fd60c28a81139f84189c7ba3e9d88fdbcd20fafd58392cb76501a61a64 \
-    gomod://github.com/fsnotify/fsnotify;version=v1.9.0;sha256sum=94e64824b23591b7aa504e3321d5ec3f57de88f4d49882eaefbbf6820dab746e \
-    gomod://github.com/gabriel-vasile/mimetype;version=v1.4.8;sha256sum=46ae70748c5e9444869682b3ceee50ffd58d7886db2ee5cf21e05c6aa3a9b070 \
+    gomod://github.com/fxamacker/cbor/v2;version=v2.9.1;sha256sum=e1e319f75e5565aab662a6afd7ddc1565ab415bd46ee82ff4958fde909da20eb \
+    gomod://github.com/gabriel-vasile/mimetype;version=v1.4.13;sha256sum=03b46aaa7bd4403d65dc23fb9d7e9b61214bb429491c864ee638490a42d55013 \
+    gomod://github.com/getkin/kin-openapi;version=v0.147.0;sha256sum=42d8f415d2a3e66d503eecaef9cfc104e36607c99ab8c33ec14d9b0f0d2dfd2a \
     gomod://github.com/gin-contrib/gzip;version=v1.2.3;sha256sum=9df2eb0490af0b4dd1e2170268824ea5e35a0c60aff35710c3d3f4a619c8d228 \
-    gomod://github.com/gin-contrib/sse;version=v1.0.0;sha256sum=fd804b0464cbf3658ad0799d3c070ee000533ae698d83dda01f58e90aaa637dd \
-    gomod://github.com/gin-gonic/gin;version=v1.10.0;sha256sum=c983efe780ee7c250a287eb26f228e0f7b77667c5ff9f4448cd54f05d28f5e70 \
-    gomod://github.com/go-co-op/gocron/v2;version=v2.19.1;sha256sum=f079bef66ea5bb6a293b3c8f789a96828da6db38fffb4904021cf38acb79c149 \
+    gomod://github.com/gin-contrib/sse;version=v1.1.1;sha256sum=6c129866d1d3cbb1556f2ae84d474f6b22871417aa6420a3be383a3c305049b9 \
+    gomod://github.com/gin-gonic/gin;version=v1.11.0;sha256sum=ef27dd16d3edd311b60b920d44a57b52b1c208b5bb8a3a6c712945e0f5562cdf \
+    gomod://github.com/go-co-op/gocron/v2;version=v2.22.0;sha256sum=25b29a1b6d28d990730022d8fd3b9ca8c8ca17a962b075de48a75ba4f24a8f83 \
+    gomod://github.com/go-json-experiment/json;version=v0.0.0-20260214004413-d219187c3433;sha256sum=4cd402f765c9dca0c492942b0c98da26a922905372e0bbb0364fcad3bcba0965 \
     gomod://github.com/go-kit/log;version=v0.1.0;mod=1;sha256sum=310e49d7adae88ab632999a4b225be3360a64ac12b6a976914b542e64256a41a \
     gomod://github.com/go-logfmt/logfmt;version=v0.5.0;mod=1;sha256sum=e23d20d0d9d1e72e042c6e234195b9f8ef5621da7f8b9860d6a318d799c960d1 \
-    gomod://github.com/go-logr/logr;version=v1.2.0;mod=1;sha256sum=519b1d6da5eeef675b4a1857d628f05f110a2b8cb3c423b715fea80d0975a518 \
     gomod://github.com/go-logr/logr;version=v1.2.2;mod=1;sha256sum=519b1d6da5eeef675b4a1857d628f05f110a2b8cb3c423b715fea80d0975a518 \
     gomod://github.com/go-logr/logr;version=v1.4.3;sha256sum=523d7a3587fe73f61ef41c8bc627f7d7f38de8104d46278154b307e60770ad70 \
     gomod://github.com/go-logr/stdr;version=v1.2.2;sha256sum=9dd6893bf700198485ae699640b49bc1efbc6c73b37cb5792a0476e1fd8f7fef \
     gomod://github.com/go-ole/go-ole;version=v1.2.6;mod=1;sha256sum=de7da59858d6121956da002ded711242cc14ecf597e932a8625246418fd3bbaa \
-    gomod://github.com/go-openapi/analysis;version=v0.23.0;sha256sum=075e696af39c9cfeed9fb6a9f6f8075a21d3bd163d87542857a2b1e5cf20a7a5 \
-    gomod://github.com/go-openapi/errors;version=v0.22.2;sha256sum=32347ccf8bc672268f2da48a3364bf6076aa21b9f22dcd59c3d5a73d4305b9c5 \
-    gomod://github.com/go-openapi/inflect;version=v0.19.0;sha256sum=fbcca36e347a2f560f50ac1c9c63f7d6cd97c8dff9800f08f370b5ce09b77c57 \
-    gomod://github.com/go-openapi/jsonpointer;version=v0.21.0;sha256sum=8a36ba84f6f6148834875fff96da79fcc2b383ace69cc34d71756b3fa84b9952 \
-    gomod://github.com/go-openapi/jsonreference;version=v0.21.0;sha256sum=53b9b8491e1791f5c561a5325e0e167bed2ae421b18bb798524c11cad5afe5c4 \
-    gomod://github.com/go-openapi/loads;version=v0.22.0;sha256sum=04bde40647c4ea75ea89999bcd2cf160294913b89d073a71bb762652c6ec9e12 \
-    gomod://github.com/go-openapi/spec;version=v0.21.0;sha256sum=14c938ac62955b4354762fbdf45148d3847c427af0f6fe662ee280ca43b6518c \
-    gomod://github.com/go-openapi/strfmt;version=v0.23.0;sha256sum=d262deb01c8148b98c777fcddfc3908ea3232bd9bf593ab926f3ca3d19933c0e \
-    gomod://github.com/go-openapi/swag;version=v0.23.1;sha256sum=788093d8d1045e55064b513b13f3a40e4b4c9944584c8df8cacd9db3c3beb44d \
-    gomod://github.com/go-openapi/validate;version=v0.24.0;sha256sum=71931ab10633f86ca3dd5f16a1bf16ae531b09c600d659f8adf1ac591b41b07d \
+    gomod://github.com/go-ole/go-ole;version=v1.3.0;mod=1;sha256sum=fcf0840f2ff50fbc3b5a54b9d4cb240c64d47003ab03e420aeff0057015a8953 \
+    gomod://github.com/go-openapi/analysis;version=v0.26.0;sha256sum=302fefa87c709aadcf9540702f9669468514ec83936a044d9731f14c7266b34b \
+    gomod://github.com/go-openapi/errors;version=v0.22.8;sha256sum=29105371e583abec5440063d20b77c67f67bf6b017c959c88934a5da6e65ae92 \
+    gomod://github.com/go-openapi/inflect;version=v0.21.5;sha256sum=f04b7f703151f59d058b7941977b187c170cdd6b2837df7b6abd64526aabf920 \
+    gomod://github.com/go-openapi/jsonpointer;version=v1.0.0;sha256sum=403cc887595921a24880a173862ea95b7c46f0747725d7b75c31165e0647e157 \
+    gomod://github.com/go-openapi/jsonreference;version=v1.0.0;sha256sum=381714f9c672c76e573155e6e6fb38ab1ccceafba6163d672a52d4460a999f5b \
+    gomod://github.com/go-openapi/loads;version=v0.25.0;sha256sum=309d12a74ca10eacfe6d73a3b1f91a7fd4c5d30609bddb48afb05e101c3ac361 \
+    gomod://github.com/go-openapi/spec;version=v0.22.9;sha256sum=e99c84955b8268d1552d5a77ccaec6a9c92c5c397aeaa52ee693636b6be5cafd \
+    gomod://github.com/go-openapi/strfmt;version=v0.27.0;sha256sum=6e830c668d22047156cd9d1e991e9e2603a55fd2fbd7331ee2e4691e9646797e \
+    gomod://github.com/go-openapi/swag;version=v0.28.0;sha256sum=3d8ca6e12ec2e0ca5e14be6f2688cfb3005878b799d42fbe3828e293d375dd5b \
+    gomod://github.com/go-openapi/swag/cmdutils;version=v0.28.0;sha256sum=ec8d7c8093e697ab5aa09eb1c7644bc02f9bb48d2cd00278a1c851001c6f82c4 \
+    gomod://github.com/go-openapi/swag/conv;version=v0.28.0;sha256sum=0869a899afe4cdc64843f06a45cc9fe4feddb47be187e223730ffe4b57de854b \
+    gomod://github.com/go-openapi/swag/fileutils;version=v0.28.0;sha256sum=282c501d0d2f2539c5ea0ae18fcd0b3b544d958b91b483404426717610ffcacb \
+    gomod://github.com/go-openapi/swag/jsonutils;version=v0.28.0;sha256sum=9ec1021cfa869bcf862ec8a36b166c46ebbb47f736e2bb8fa2a6685b83170e34 \
+    gomod://github.com/go-openapi/swag/loading;version=v0.28.0;sha256sum=63c459ca5289190b2a231c05aff1d22710bab0f50c33a49fe5f0c6cb218612a0 \
+    gomod://github.com/go-openapi/swag/mangling;version=v0.28.0;sha256sum=2d16f070918e2fd8714aaf356dfb9984e84daf7643689a8e25cc58d5ded54b70 \
+    gomod://github.com/go-openapi/swag/netutils;version=v0.28.0;sha256sum=d7363cce443a04264c352c76d34d89d0993e7e299319b25c00854d7ab865672a \
+    gomod://github.com/go-openapi/swag/pools;version=v0.28.0;sha256sum=623705ee11fe884b4a998ca0e8305c4da03ada2f43c3b4c41e1f84486e627049 \
+    gomod://github.com/go-openapi/swag/stringutils;version=v0.28.0;sha256sum=e15348c48de427f551dc69583eb088a72510c257cf976f6ab382601ec602ab6c \
+    gomod://github.com/go-openapi/swag/typeutils;version=v0.28.0;sha256sum=9256dec49a60a1efca39e0486107c7d86d15f7c52c962cfb9a04a720023e3e0d \
+    gomod://github.com/go-openapi/swag/yamlutils;version=v0.28.0;sha256sum=66bffa6d57cfc00135695b8d873f08d11c6017f472aa00b777dd168b3ecec2c3 \
+    gomod://github.com/go-openapi/validate;version=v0.26.3;sha256sum=b630b6260bb14fc1fe45ce748057ebff07fa86affbe744ebaec0a4bbfb66ad4d \
     gomod://github.com/go-playground/locales;version=v0.14.1;sha256sum=f33b53f2eef290d8b43b1011285f1f9cfcb1295c690defcb452598773baace7b \
     gomod://github.com/go-playground/universal-translator;version=v0.18.1;sha256sum=77fc966f2d045c208ddeaa8343924f83688841b6f4c2ae005dc9ea5550c7d171 \
-    gomod://github.com/go-playground/validator/v10;version=v10.26.0;sha256sum=ae8c142c473f0b58d2784f4e1411799c9b5e35e1c025f6137d41f5fc8db0777f \
-    gomod://github.com/go-sql-driver/mysql;version=v1.9.3;sha256sum=fa0066aaca3f8932270d62c75dfdb291a0a1a38505464910de6c83a1332e161e \
+    gomod://github.com/go-playground/validator/v10;version=v10.30.2;sha256sum=19b740a35f29483539a143ff5226266e4fe5f39b339d30599a85cfc258a8b8c6 \
+    gomod://github.com/go-sql-driver/mysql;version=v1.10.0;sha256sum=dc93f5770556406e82bf750a980d2316f882a19d883a3689eadb820708c2b651 \
     gomod://github.com/go-stack/stack;version=v1.8.0;mod=1;sha256sum=591552a7ca5f4351d9bef6b868f2d85a61ea028271442581f5f487dced196129 \
-    gomod://github.com/go-test/deep;version=v1.0.4;mod=1;sha256sum=d1879e1f0d4d967bad2f1da3782b6094f3697935615575be97d171695c1d4aae \
-    gomod://github.com/goccy/go-json;version=v0.10.5;sha256sum=96e417d4493705f470f7f29858a09cdbe68330f2d7e74cd024fbace4745c0615 \
-    gomod://github.com/goccy/go-yaml;version=v1.18.0;sha256sum=51bf59a85a7e3e2b8e83e5f376a3229b01b673a39601c99e3a2c05931cc3e339 \
-    gomod://github.com/godbus/dbus/v5;version=v5.0.4;mod=1;sha256sum=8743ea72fed21cc143c4a067408e21f7787610e662fdbe8d5943312ea8ae8816 \
+    gomod://github.com/go-viper/mapstructure/v2;version=v2.5.0;sha256sum=326f8e00f648af4ae8e6e18c606325e4206a92d6ed42f486dc2f4da8e1897547 \
+    gomod://github.com/goccy/go-json;version=v0.10.6;mod=1;sha256sum=9027c83efc1eb1e1f4dfdc0ecd03d6de89dcb68ecae41d442485028f366fa98b \
+    gomod://github.com/goccy/go-yaml;version=v1.19.2;sha256sum=9ea8b466385c1ecf61fa55b68e409ea048b3d7fb1178eba66c1e24a7a30dfffb \
     gomod://github.com/gofrs/uuid;version=v4.0.0+incompatible;mod=1;sha256sum=f7b67ead741e2d9645740d1c7ef7b26de46f670ed24fdc399096ef011dc07d57 \
-    gomod://github.com/gogo/protobuf;version=v1.3.2;sha256sum=dd2b73f163c8183941626360196c8f844addd95423d341a0412e1b22d0104ff7 \
     gomod://github.com/golang/glog;version=v1.2.5;mod=1;sha256sum=6e86cbe37163d5e14017888a82c32bbe29e732e9bd66bbe9da8e42e08f6bfdcc \
     gomod://github.com/golang/protobuf;version=v1.3.1;mod=1;sha256sum=c0a2031bf277087749d8ccc432449f6b1375787eac8641dd2f930074231aafb4 \
     gomod://github.com/golang/protobuf;version=v1.5.0;mod=1;sha256sum=738cbb1de96b67a6238ac3b8081cd8b1bfb0daebcf6c9bbe8cbdb6d73baecd19 \
     gomod://github.com/golang/protobuf;version=v1.5.2;mod=1;sha256sum=7c8e7610527afd7724c7e8b7e843f132b0db61e8c9dd49dc589d430e8929bcc4 \
     gomod://github.com/golang/protobuf;version=v1.5.4;sha256sum=9a2f43d3eac8ceda506ebbeb4f229254b87235ce90346692a0e233614182190b \
     gomod://github.com/golang-jwt/jwt/v4;version=v4.5.2;sha256sum=ec5ee69a31fd478fc197fddce7c06dad1abe7543095a55c4ee6546ae79d99a0f \
-    gomod://github.com/google/go-cmp;version=v0.5.2;mod=1;sha256sum=4036ab5636aa42bd313296cd3bfcb4c88912760c56a9e6655ae422d8767c80da \
+    gomod://github.com/google/gnostic-models;version=v0.7.0;sha256sum=797a05cd73a30624ece79633c4db4631676adc1f30f07a0a7051ab39beca96c8 \
     gomod://github.com/google/go-cmp;version=v0.5.5;mod=1;sha256sum=4036ab5636aa42bd313296cd3bfcb4c88912760c56a9e6655ae422d8767c80da \
-    gomod://github.com/google/go-cmp;version=v0.5.6;mod=1;sha256sum=4036ab5636aa42bd313296cd3bfcb4c88912760c56a9e6655ae422d8767c80da \
-    gomod://github.com/google/go-cmp;version=v0.5.7;mod=1;sha256sum=7b51bed534f39f6cdf63c9e8160aac20e7fa494979d8f5a9ade974347f89be36 \
+    gomod://github.com/google/go-cmp;version=v0.6.0;mod=1;sha256sum=e7c7669d4a1dd589ba3e024ba27f43f293db611fe075ce20d7b884370d63febd \
     gomod://github.com/google/go-cmp;version=v0.7.0;sha256sum=64a9ce046f2c320e3783fba0d1f4a15f8a18f0b009b67bf27f7630919db3f539 \
-    gomod://github.com/google/go-querystring;version=v1.1.0;sha256sum=a6aafc01f5602e6177928751074e325792a654e1d92f0e238b8e8739656dd72b \
+    gomod://github.com/google/go-querystring;version=v1.2.0;sha256sum=57b7ce2b82b33c68f59a224c6dd1305753e5ee3eecbefd09d43423a14f541e31 \
     gomod://github.com/google/gofuzz;version=v1.0.0;mod=1;sha256sum=fb009c01ee165bbaa85c85e8a3a794ea8e83f80714d4183465dc81d811b54427 \
-    gomod://github.com/google/gofuzz;version=v1.2.0;sha256sum=5948f40af1923d8f98dc1d4191311030e40e0057fb255df19ebc0360f2faac16 \
     gomod://github.com/google/renameio;version=v0.1.0;mod=1;sha256sum=ba9b5eb0878008a891e16b08c17922b03f92c76a03e7bfe1832635eada1c1a35 \
-    gomod://github.com/google/uuid;version=v1.1.1;mod=1;sha256sum=73da47b6338b00a082fd451aa35a3273d3adc09b8e9bba98dab01091e402af6e \
     gomod://github.com/google/uuid;version=v1.6.0;sha256sum=d0f02f377217f42702e259684e06441edbf5140dddcc34ba9bea56038b38a6ed \
-    gomod://github.com/google/winops;version=v0.0.0-20230712152054-af9b550d0601;mod=1;sha256sum=1591cec0bbca7f58da77ef4d372f7c61865b6d8ea440dda54573f2913fdb6238 \
+    gomod://github.com/google/winops;version=v0.0.0-20260218212338-878c3f651658;mod=1;sha256sum=6603a6b91c84d3d388b13876e5404039d4bfacebe963a3bf2b949c1c22949b02 \
     gomod://github.com/goombaio/namegenerator;version=v0.0.0-20181006234301-989e774b106e;sha256sum=4fe2d8f6e7f0fd072be4c386550f5491f47ac6c634d95e728be497b780538a3c \
-    gomod://github.com/gorilla/websocket;version=v1.4.2;mod=1;sha256sum=09dc8a9227a54c1069ea065d610a5f2ca195f1f5fba6e7dbb2d7eb0fd6e01df6 \
-    gomod://github.com/gorilla/websocket;version=v1.5.0;sha256sum=690ea4d1ffe00ab5fcb6d63e2ec3783fc5a58e9d0f1789ea5dc9b6663deee6d5 \
-    gomod://github.com/gotnospirit/makeplural;version=v0.0.0-20180622080156-a5f48d94d976;sha256sum=5750c916115b851f4881b76d90128802d090558958aa821c691d4fa378018093 \
-    gomod://github.com/gotnospirit/messageformat;version=v0.0.0-20221001023931-dfe49f1eb092;sha256sum=8aa77e56fba5d816f9c01c9731b1fcdec01c7118d38d57710edffc4894287ca1 \
-    gomod://github.com/hashicorp/go-hclog;version=v1.5.0;sha256sum=37eae99309c542b32aa7e28bcd0236e1ded8acce4aadc25d8e5a8ab03066482d \
-    gomod://github.com/hashicorp/go-plugin;version=v1.6.3;sha256sum=4f55ff48a99e9a7c725285dd83d7df64e1476f47250aada3fc29e6ce2b74822c \
-    gomod://github.com/hashicorp/go-version;version=v1.7.0;sha256sum=341bd10080b7f7e0754bab07afb09f9a37e997b5fdb1a528266972a890309053 \
-    gomod://github.com/hashicorp/hcl/v2;version=v2.13.0;sha256sum=6e44472b272d578b63817a93aa498d0d13e5f1dcc13a67abceb3aeec836341bc \
-    gomod://github.com/hashicorp/yamux;version=v0.1.1;sha256sum=8cd954cfc5cdc51cca9bb2dc2fe117bedcc5b0f7cd7f79fb5793d1c1f7538065 \
+    gomod://github.com/gorilla/websocket;version=v1.5.4-0.20250319132907-e064f32e3674;sha256sum=81809e9741b37f386c8d28c9c6a23511f4a2465fd024a690a4c44a439e32e832 \
+    gomod://github.com/hashicorp/go-hclog;version=v1.6.3;sha256sum=ebab3136e5327ad17606485f633c2d033c61eadb843b2f3629b6d65d6fbb1400 \
+    gomod://github.com/hashicorp/go-plugin;version=v1.8.0;sha256sum=4d2ec76dfd4266342eadebb3b12e198983684e9a9208d0e257fa2b8f65717aa9 \
+    gomod://github.com/hashicorp/go-version;version=v1.9.0;sha256sum=b6c05489bf11a28c81cf38119782284c859d6c2d193b811d3f0117592eb31fcb \
+    gomod://github.com/hashicorp/hcl/v2;version=v2.24.0;sha256sum=53fd4e96ac9c190e192759daf49b63397865214d337ab5f6dbf6e68c1b0f4810 \
+    gomod://github.com/hashicorp/yamux;version=v0.1.2;sha256sum=8ba2b4b2d37260d4aeabf85ac9c26841a287a264c02bc629f40f19d2bd977df4 \
     gomod://github.com/hexops/gotextdiff;version=v1.0.3;sha256sum=a10c3942f09bc5132268d22d4bb9d0c1849122d533fe8cdf65ea69da05cebbaf \
     gomod://github.com/hinshun/vt10x;version=v0.0.0-20220119200601-820417d04eec;mod=1;sha256sum=5791a0eeb9d7793b7d4c4c8429c889f2dea3196a2f5e8ac401173471bfb8ca36 \
-    gomod://github.com/huandu/xstrings;version=v1.3.3;mod=1;sha256sum=33c7a6cfa483a6d2c3da52bf870469c716fe5948bbc3177868c726e7d73bba00 \
     gomod://github.com/huandu/xstrings;version=v1.5.0;sha256sum=74bd0e897e5c35b1fd0e598cb8d9dfcebcb820b6edf3abf850d5404bfaaca6a2 \
-    gomod://github.com/imdario/mergo;version=v0.3.11;sha256sum=47332eb559e993749cc31292807b3a639a470032ec603fd3c15fbe46f82192f6 \
     gomod://github.com/inconshreveable/mousetrap;version=v1.0.0;mod=1;sha256sum=391daebc93b0df9bb89a89b14bfa60268d9eb9e27623ec415041abababdd005c \
     gomod://github.com/inconshreveable/mousetrap;version=v1.1.0;mod=1;sha256sum=1c1b15911aa8a0bd5cd0f6670ec23d1086496f3615fdf53306aff2b476ce9be1 \
     gomod://github.com/ivanpirog/coloredcobra;version=v1.0.1;sha256sum=417b2b8f75ea20cbfd6b0ddd339a16642a389247b4ad2884e0445753468f443b \
@@ -183,106 +188,106 @@ SRC_URI += "\
     gomod://github.com/jackc/pgproto3/v2;version=v2.1.1;mod=1;sha256sum=a3b244b626d4c9b628066e8d2bdd591395dc9863ea594c5e45c40867e3a0f9f5 \
     gomod://github.com/jackc/pgproto3/v2;version=v2.3.3;sha256sum=53ea236cbfe241693b439092e2d51b404c2a635ee3fe64ea7aad1527cb715189 \
     gomod://github.com/jackc/pgservicefile;version=v0.0.0-20200714003250-2b9c44734f2b;mod=1;sha256sum=a8f467defefd4d7655a8bbce0ff93c67408e9e14cc8a95d9015338770ecd51e1 \
-    gomod://github.com/jackc/pgservicefile;version=v0.0.0-20221227161230-091c0ba34f0a;sha256sum=1f8bdf75b2a0d750e56c2a94b1d1b0b5be4b29d6df056aebd997162c29bfd8ab \
+    gomod://github.com/jackc/pgservicefile;version=v0.0.0-20221227161230-091c0ba34f0a;mod=1;sha256sum=5f70111b892c17eecec6f97e0cd961cc3922b5daece59c099c855e1062ed0277 \
+    gomod://github.com/jackc/pgservicefile;version=v0.0.0-20240606120523-5a60cdf6a761;sha256sum=c9e31c91aebf96eb246bd410d1849cc7666d955a1e20ca2eba1c30b4eb89335f \
     gomod://github.com/jackc/pgtype;version=v0.0.0-20190421001408-4ed0de4755e0;mod=1;sha256sum=f49bb6b9634307e5aaa49c0dbd08ac5a11feb1e4e4598f703711fd3a16fc4c05 \
     gomod://github.com/jackc/pgtype;version=v0.0.0-20190824184912-ab885b375b90;mod=1;sha256sum=d6051ef14c271dd83e7b3d9df6ff71af80be4c0edaf470da28bac6f461bff5e9 \
     gomod://github.com/jackc/pgtype;version=v0.0.0-20190828014616-a8802b16cc59;mod=1;sha256sum=46ab0c8749c2e33d0bfe21cba0840aa4734853cd717c04bc529796d54c484e5d \
-    gomod://github.com/jackc/pgtype;version=v1.14.0;sha256sum=7e67f5b944cbd401025c6473e624ef61ed196e3ed0f77ed437b0621cf820c0c9 \
+    gomod://github.com/jackc/pgtype;version=v1.14.0;mod=1;sha256sum=f21568dcee07beb4b6f49e86d9171ddd2884a999728fb548db2abf59036faea6 \
+    gomod://github.com/jackc/pgtype;version=v1.14.4;sha256sum=278546f16518069acadb957a00e9d7019911e5f36c079cb47a57e074ccc7a1b3 \
     gomod://github.com/jackc/pgtype;version=v1.8.1-0.20210724151600-32e20a603178;mod=1;sha256sum=ecd06114685e63dace8ab017acd0cbdac6eb46801d41374ca00c5600f109603e \
     gomod://github.com/jackc/pgx/v4;version=v4.0.0-20190420224344-cc3461e65d96;mod=1;sha256sum=80bb4f71b8995003c37ce96d4aa1ae8080150f8419eea800e9bfadb1f3a07b5d \
     gomod://github.com/jackc/pgx/v4;version=v4.0.0-20190421002000-1b8f0016e912;mod=1;sha256sum=842f17766f4390d2a5842257643bb8dd0b558e2c818fdf71a05ab441332eeab4 \
     gomod://github.com/jackc/pgx/v4;version=v4.0.0-pre1.0.20190824185557-6972a5742186;mod=1;sha256sum=806922680a7a4b89182d91264fbb8e634ef56c0d739fb5c9d284d08a85e3b948 \
     gomod://github.com/jackc/pgx/v4;version=v4.12.1-0.20210724153913-640aa07df17c;mod=1;sha256sum=5dfb5d594b761c270502ba0942f71165105211cface4f36a5c70cb91669a8cfc \
-    gomod://github.com/jackc/pgx/v4;version=v4.18.2;sha256sum=38693e9a8527ef49be7d753862ff1958a94d76d37ae91c55c8a5806269954e2f \
+    gomod://github.com/jackc/pgx/v4;version=v4.18.2;mod=1;sha256sum=2566b78179f5e3397897b74adfa60f9bff18abc12672f1526deee56f7c9bf43a \
+    gomod://github.com/jackc/pgx/v4;version=v4.18.3;sha256sum=1d5955dc65b8de8f72f9856865b33dcd9a2238f7cf9b1f2a00f1558e7d4965da \
     gomod://github.com/jackc/puddle;version=v0.0.0-20190413234325-e4ced69a3a2b;mod=1;sha256sum=5fc99fa273fc5cac83f4a57d73b690769edc41b5a3423e30c51f8d2838b6cea2 \
     gomod://github.com/jackc/puddle;version=v0.0.0-20190608224051-11cab39313c9;mod=1;sha256sum=5fc99fa273fc5cac83f4a57d73b690769edc41b5a3423e30c51f8d2838b6cea2 \
     gomod://github.com/jackc/puddle;version=v1.1.3;mod=1;sha256sum=5fc99fa273fc5cac83f4a57d73b690769edc41b5a3423e30c51f8d2838b6cea2 \
-    gomod://github.com/jarcoal/httpmock;version=v1.1.0;mod=1;sha256sum=10db6883b827724b94058d912e5b5b2847ec4eb847cdd27fb8f9425f870c24e0 \
-    gomod://github.com/jedib0t/go-pretty/v6;version=v6.6.7;sha256sum=ceef0f6390e20c6d793cc3983f78972b7b717ba2b92fa621021a2e8b75a3f0b9 \
+    gomod://github.com/jackc/puddle;version=v1.3.0;mod=1;sha256sum=5fc99fa273fc5cac83f4a57d73b690769edc41b5a3423e30c51f8d2838b6cea2 \
+    gomod://github.com/jarcoal/httpmock;version=v1.4.2;mod=1;sha256sum=9a7442f7e093bdbc9f99735621c52a2f34bc8849de66b99ed45b46dbc8e06fda \
+    gomod://github.com/jedib0t/go-pretty/v6;version=v6.8.3;sha256sum=f6dfe2ff3f738dd91ba406aaffebdeb81a1b85edb240aec33f64306551373358 \
     gomod://github.com/jonboulle/clockwork;version=v0.5.0;sha256sum=f6b22626f17e5d4be7c755f83f97b575764da4c9ea4deccd5c5794912ce508aa \
-    gomod://github.com/josharian/intern;version=v1.0.0;sha256sum=5679bfd11c14adccdb45bd1a0f9cf4b445b95caeed6fb507ba96ecced11c248d \
     gomod://github.com/json-iterator/go;version=v1.1.12;sha256sum=d001ea57081afd0e378467c8f4a9b6a51259996bb8bb763f78107eaf12f99501 \
-    gomod://github.com/jszwec/csvutil;version=v1.5.1;sha256sum=c8db7ee7569f5ba63856716cef525ab2a96f1dbcad58d8cb851fa8f0df5d7309 \
-    gomod://github.com/kaptinlin/go-i18n;version=v0.1.4;sha256sum=c54b28f4f7f4d11e58555d544869f7175665a35951235d1d253257fda98341ba \
-    gomod://github.com/kaptinlin/jsonschema;version=v0.4.6;sha256sum=d5958c64818357a1c3534446fd6cd3b0b8082bf2326367a88754bd1644abf585 \
+    gomod://github.com/jszwec/csvutil;version=v1.10.0;sha256sum=041c812ed4bb4f6475195b3228c881756b69e45dc0a1116ece0ec8699a459952 \
+    gomod://github.com/kaptinlin/go-i18n;version=v0.3.1;sha256sum=282f491cdf38d1ccd8c36a038401587d2723e6824940eacfbd996efd577a7307 \
+    gomod://github.com/kaptinlin/jsonpointer;version=v0.4.17;sha256sum=e356905c58d7c931e9a7df2bc423af3e09eee9ba31dc4a111016bac8df78d78d \
+    gomod://github.com/kaptinlin/jsonschema;version=v0.7.7;sha256sum=69cdc4d592d82cd1224fc3400915658cfe19d09a041d5734d9fa12b0487e7050 \
+    gomod://github.com/kaptinlin/messageformat-go;version=v0.4.19;sha256sum=e11931a8d89d5a4e598345ac73f79e6afb1e3b969e6d62dbd6313c29243d6733 \
     gomod://github.com/kballard/go-shellquote;version=v0.0.0-20180428030007-95032a82bc51;sha256sum=ae4cb7b097dc4eb0c248dff00ed3bbf0f36984c4162ad1d615266084e58bd6cc \
-    gomod://github.com/kisielk/errcheck;version=v1.5.0;mod=1;sha256sum=107d26460d41b5322b6911c9b5eb233117421943b3a1453ba99f01c4fdf2f8e8 \
     gomod://github.com/kisielk/gotool;version=v1.0.0;mod=1;sha256sum=77aca7bffc0ec29fc9f088d5962ab3128f405d7b10c7ceb9693ff7a08958955d \
-    gomod://github.com/klauspost/compress;version=v1.15.9;mod=1;sha256sum=1c3aa9eb7f46201571df2ca0c1bd9c095d81b2c91c1ed9393808c2e654c3fc64 \
-    gomod://github.com/klauspost/compress;version=v1.18.0;sha256sum=c4679e4cbc820a21758199d985be754abf5eb2a38e6f1de95cd70b2e7ef06905 \
-    gomod://github.com/klauspost/cpuid/v2;version=v2.0.9;mod=1;sha256sum=66180bc563c8890e28b69ba64fbe6e1d2879a8574a3ffce7e597f1915f78bc6c \
-    gomod://github.com/klauspost/cpuid/v2;version=v2.2.10;mod=1;sha256sum=ff61d47f254f2333bf44a8ff4187a2f2e973693807c10025033bb37143577237 \
-    gomod://github.com/knz/go-libedit;version=v1.10.1;mod=1;sha256sum=68b2c910e9bd5de076a9f5d9be180ac3f2fef5f4a904ba61fa98af79c5645b9f \
+    gomod://github.com/klauspost/compress;version=v1.19.1;sha256sum=a77e019f60dff8bdf00ad137985c808957cc657381daa4281824843bc6b46910 \
+    gomod://github.com/klauspost/cpuid/v2;version=v2.3.0;mod=1;sha256sum=ff61d47f254f2333bf44a8ff4187a2f2e973693807c10025033bb37143577237 \
     gomod://github.com/konsorten/go-windows-terminal-sequences;version=v1.0.1;mod=1;sha256sum=6b69dafd3cf64d7b57e978848a7e271a2be0a04d9a2564dd2556491d27d0a034 \
     gomod://github.com/konsorten/go-windows-terminal-sequences;version=v1.0.2;mod=1;sha256sum=6b69dafd3cf64d7b57e978848a7e271a2be0a04d9a2564dd2556491d27d0a034 \
     gomod://github.com/kr/pretty;version=v0.1.0;mod=1;sha256sum=e3d5d46d2f6ac94a666a54b5e867ec16bf199d9f4b700827cd731607efdd109a \
     gomod://github.com/kr/pty;version=v1.1.1;mod=1;sha256sum=6da4c9c7364446894e5ef877e19f985cd51d671ce6e8f4ca87862b449f6dd7f6 \
     gomod://github.com/kr/pty;version=v1.1.8;mod=1;sha256sum=84fd3216760a197e72c3799224956254c50b92c21c146852f6ef4f5785e3f15d \
     gomod://github.com/kr/text;version=v0.1.0;mod=1;sha256sum=2fba9529e5c13dde62f371ef7383baf04d7132501dac6aa08e910f9ec0bf85c5 \
+    gomod://github.com/kylelemons/godebug;version=v1.1.0;mod=1;sha256sum=1605871e895331a39f5952559ebbc91228d86b8100354f857b562866eca5bb13 \
     gomod://github.com/leodido/go-urn;version=v1.4.0;sha256sum=948fe5f705b9eab6c3bc7e34a3ad2549ead87a8f5f73e5a85a8c66f347612ab2 \
     gomod://github.com/lib/pq;version=v1.0.0;mod=1;sha256sum=4c8ac83a989579853015fde612e6563b26cb67d1b937649bbe0a1877ac249114 \
     gomod://github.com/lib/pq;version=v1.1.0;mod=1;sha256sum=4c8ac83a989579853015fde612e6563b26cb67d1b937649bbe0a1877ac249114 \
     gomod://github.com/lib/pq;version=v1.10.2;mod=1;sha256sum=94c1488688b2b9822a96e1375e32002a652cc1aee71520f6bfa87bec8eb79c06 \
     gomod://github.com/lib/pq;version=v1.2.0;mod=1;sha256sum=4c8ac83a989579853015fde612e6563b26cb67d1b937649bbe0a1877ac249114 \
-    gomod://github.com/lufia/plan9stats;version=v0.0.0-20211012122336-39d0f177ccd0;mod=1;sha256sum=5bfa5aa9d2b1f15002ad9bef70a297ab14270d0c6b0d505882b8ec9facd95077 \
-    gomod://github.com/magefile/mage;version=v1.15.1-0.20250615140142-78acbaf2e3ae;mod=1;sha256sum=c179221303b82802269c361abc52cfa144bc1a1bd36319a4fe77ab2145782a8b \
-    gomod://github.com/mailru/easyjson;version=v0.9.0;sha256sum=090087778afa675a863f7f6c9c7e5dff41523639a72235c5a9014811dfd0a4bc \
+    gomod://github.com/lufia/plan9stats;version=v0.0.0-20260330125221-c963978e514e;mod=1;sha256sum=37a53f16d9ab910339d4395983695afb4490aae01435c0a59980675c45d0bd95 \
+    gomod://github.com/magefile/mage;version=v1.17.1;mod=1;sha256sum=0b82f958994d548d2bd8b65598fc28600eac06658589a07c73b461d6de75b381 \
     gomod://github.com/mattn/go-colorable;version=v0.1.1;mod=1;sha256sum=eea1203659e82719021af821e1f4c66335e955fa630be09f7cb3fdb1bb193497 \
     gomod://github.com/mattn/go-colorable;version=v0.1.12;mod=1;sha256sum=301b4efcc69da40b91ccc8d2cc58e88595e8ad8712aca01403f10086d96b1813 \
-    gomod://github.com/mattn/go-colorable;version=v0.1.13;sha256sum=08be322dcc584a9fcfde5caf0cf878b4e11cd98f252e32bc704e92c5a4ba9d15 \
+    gomod://github.com/mattn/go-colorable;version=v0.1.14;sha256sum=5e0e7925a070bb5bd11b4097e1a7b608167f0217ee83901b44c135f6e5e85c78 \
     gomod://github.com/mattn/go-colorable;version=v0.1.2;mod=1;sha256sum=a1161e694ac3bdfebf8550b34d8273fafddbe76fda0c62e85440f71799e56b9d \
     gomod://github.com/mattn/go-colorable;version=v0.1.6;mod=1;sha256sum=adff3e24384bcd2ecf0c6d6a1a9e4e31065401e9b5d29ce6a120255ab3c02313 \
     gomod://github.com/mattn/go-colorable;version=v0.1.9;mod=1;sha256sum=adff3e24384bcd2ecf0c6d6a1a9e4e31065401e9b5d29ce6a120255ab3c02313 \
     gomod://github.com/mattn/go-isatty;version=v0.0.12;mod=1;sha256sum=1a062e56c0266d004bea51115acf8c2b597d1407ca55ad56cce01e97ada3da4b \
     gomod://github.com/mattn/go-isatty;version=v0.0.14;mod=1;sha256sum=e9299133cd7243ec2667aa25a04b2dac6009234ae4c1cda4edb45749970dae9f \
-    gomod://github.com/mattn/go-isatty;version=v0.0.16;mod=1;sha256sum=714766ec82d67db895ade8af6b8054ad430c3cea5e15b3a888f23ed2f3e1b863 \
-    gomod://github.com/mattn/go-isatty;version=v0.0.20;sha256sum=f2d5f89ca451577e17464b9bb596dc0d0ecececb5eaa63622c41b57cd0b7b8cc \
+    gomod://github.com/mattn/go-isatty;version=v0.0.24;sha256sum=4fcffec0bae0ad4af7bf96e2497a817d85de64af19ffe31d82bda362148234b8 \
     gomod://github.com/mattn/go-isatty;version=v0.0.5;mod=1;sha256sum=4f775a89be9a80189a826ef22dc303e389557c558f14bfd40b75b5ef2845e56f \
     gomod://github.com/mattn/go-isatty;version=v0.0.7;mod=1;sha256sum=4f775a89be9a80189a826ef22dc303e389557c558f14bfd40b75b5ef2845e56f \
     gomod://github.com/mattn/go-isatty;version=v0.0.8;mod=1;sha256sum=4f775a89be9a80189a826ef22dc303e389557c558f14bfd40b75b5ef2845e56f \
-    gomod://github.com/mattn/go-runewidth;version=v0.0.16;sha256sum=179d2d900c76ee3560fbeda60d0237a3be6acb734d0cb7423b55e5ccb0cedbca \
-    gomod://github.com/mattn/go-sqlite3;version=v1.14.24;sha256sum=c655f3f056f9e4422f9ccf4850841cbfc125058e0702715ef9c600449cdcd458 \
+    gomod://github.com/mattn/go-runewidth;version=v0.0.22;sha256sum=20a9d0b6365a245a6da5db173737750bc2442fe7085a9aa2ca928e1d6968726d \
+    gomod://github.com/mattn/go-sqlite3;version=v1.14.32;sha256sum=c70101000256656bc0b7286807cf177852c753a001a3aa3c55d5373575fb81aa \
     gomod://github.com/mgutz/ansi;version=v0.0.0-20170206155736-9520e82c474b;mod=1;sha256sum=12e14b97ea604f1fcb9f7fcc85ee93d9ba7f858a03469ee29e929a07d55d0a4d \
     gomod://github.com/mgutz/ansi;version=v0.0.0-20200706080929-d51e80ef957d;sha256sum=2e0c063f9597cb225904292981732f10298e95aa22a1b815297e318ba103dc1d \
-    gomod://github.com/mitchellh/copystructure;version=v1.0.0;mod=1;sha256sum=f1caf5434296b380a55af8ea9994a01cac975e1170dc63b50cb33569d65bc5e1 \
     gomod://github.com/mitchellh/copystructure;version=v1.2.0;sha256sum=4a1ce1f3c66bf99883e55da50fe1b3122299b79ad1d11c5407abbd74ace12550 \
     gomod://github.com/mitchellh/go-wordwrap;version=v1.0.1;sha256sum=5f96426c4b3b3e90a9b7471568cb1d61d6a306744f5d4765a30fa8a61e1c0b47 \
-    gomod://github.com/mitchellh/mapstructure;version=v1.5.0;sha256sum=118d5b2cb65c50dba967fb6d708f450a9caf93f321f8fc99080675b2ee374199 \
-    gomod://github.com/mitchellh/reflectwalk;version=v1.0.0;mod=1;sha256sum=7a5fefd3afb6a309c9c38b51a5448e01cdc9cff07be066e29d53609f3290f2bb \
     gomod://github.com/mitchellh/reflectwalk;version=v1.0.2;sha256sum=c96eed6b50f00b1acdc79224e8e55f66ef3e98e3f7c6373afa3e3b8c6ef440d1 \
     gomod://github.com/moby/docker-image-spec;version=v1.3.1;sha256sum=e3fe212be410465c0cae032baa7e2c7282b9bb878f081f00549333edc260c306 \
-    gomod://github.com/moby/moby/api;version=v1.52.1-0.20251116162601-e9ff10bf365a;sha256sum=35a38321db58305f469350fc48eabb2997d141bd4b000628daefb9808b69126f \
-    gomod://github.com/moby/moby/client;version=v0.1.1-0.20251116162601-e9ff10bf365a;sha256sum=3ebdfd6bab474be0edabdef1cbdb5ce0def357c1ab52591f91cd2ee0f488bb6b \
+    gomod://github.com/moby/moby/api;version=v1.55.0;sha256sum=5e6428e58b17018a8e1ecffb176dbdffc7678b97f7bf4f50fd3f814747de4847 \
+    gomod://github.com/moby/moby/client;version=v0.5.1;sha256sum=1fbfaea19d085d23f99d47352f0665713c11986b383b8209625abac6db2e04b2 \
     gomod://github.com/modern-go/concurrent;version=v0.0.0-20180228061459-e0a39a4cb421;mod=1;sha256sum=27a5e9f05c71089b6fd5e119fc1c8ce81f0c16da4ec3357157b1d85e2ba85ae2 \
     gomod://github.com/modern-go/concurrent;version=v0.0.0-20180306012644-bacd9c7ef1dd;sha256sum=91ef49599bec459869d94ff3dec128871ab66bd2dfa61041f1e1169f9b4a8073 \
-    gomod://github.com/modern-go/reflect2;version=v1.0.2;sha256sum=f46f41409c2e74293f82cfe6c70b5d582bff8ada0106a7d3ff5706520c50c21c \
+    gomod://github.com/modern-go/reflect2;version=v1.0.2;mod=1;sha256sum=099ee58ec210155280692f9e2360f523272e525f06272754be7a2a44dbfa0623 \
+    gomod://github.com/modern-go/reflect2;version=v1.0.3-0.20250322232337-35a7c28c31ee;sha256sum=49f3fb0f76b1b98b52b5e6e8eab2a48454eab33904b937625941c28138a7fea4 \
     gomod://github.com/mohae/deepcopy;version=v0.0.0-20170929034955-c48cc78d4826;sha256sum=41ba726508a213f4af89e7d58937263ff778e352d591edd422d3a3dc3272585c \
     gomod://github.com/munnerz/goautoneg;version=v0.0.0-20191010083416-a7dc8b61c822;sha256sum=3d7ce17916779890be02ea6b3dd6345c3c30c1df502ad9d8b5b9b310e636afd9 \
-    gomod://github.com/ncruces/go-strftime;version=v0.1.9;mod=1;sha256sum=e5864a1dd9ac62bd778e7444e02e1e4130fa7c00d88eaea271c34f934e724f73 \
+    gomod://github.com/ncruces/go-strftime;version=v1.0.0;mod=1;sha256sum=e5864a1dd9ac62bd778e7444e02e1e4130fa7c00d88eaea271c34f934e724f73 \
     gomod://github.com/nxadm/tail;version=v1.4.11;sha256sum=c42a7b1a10a9b31f61806742e7be99e524a2885c9180f18403be48a703b5667a \
-    gomod://github.com/oklog/run;version=v1.0.0;sha256sum=108d409b7d235d61b82cfb6e1df139501123fcd8fa68fe94ddb024b53335cb48 \
-    gomod://github.com/oklog/ulid;version=v1.3.1;sha256sum=40e502c064a922d5eb7f2bc2cda9c6a2a929ec0fc76c9aae4db54fb7b6b611ae \
+    gomod://github.com/oasdiff/yaml;version=v0.1.1;sha256sum=c7813b8bf97831462a9d3a347a8ea9dbd71644c53de7af55f6df45688a968af4 \
+    gomod://github.com/oasdiff/yaml3;version=v0.0.14;sha256sum=3e8b91dd2b5208d482fe592467b6654927291031a19f7792d51bb64781ad738c \
+    gomod://github.com/oklog/run;version=v1.2.0;sha256sum=730451ad4b759a648873e99b72abb9e8b3f7e23a4949f808d0238b827594073d \
+    gomod://github.com/oklog/ulid/v2;version=v2.1.1;sha256sum=312b5fea3f68df920adaffc327440efbaba43ad6a8df2f7e0c9e365743f6ff89 \
     gomod://github.com/opencontainers/go-digest;version=v1.0.0;sha256sum=615efb31ff6cd71035b8aa38c3659d8b4da46f3cd92ac807cb50449adfe37c86 \
     gomod://github.com/opencontainers/image-spec;version=v1.1.1;sha256sum=3a32eeb459719172947c20be78b5b7293c6ea84f4039184e846f6b676bc19574 \
-    gomod://github.com/oschwald/geoip2-golang;version=v1.9.0;sha256sum=2fc05b05b02aac3f86b4752d7517fa6063a0b0d2ea9f6c50d89432c98c907f62 \
-    gomod://github.com/oschwald/maxminddb-golang;version=v1.12.0;sha256sum=160a3e324bd889247553c362405f405800c955046499d5fa5d69c149218d9206 \
-    gomod://github.com/pelletier/go-toml/v2;version=v2.2.4;sha256sum=82162be7b85077f3be49bfe0f1e01f308b9c9554c72a980a22a34432f94885f0 \
+    gomod://github.com/oschwald/geoip2-golang;version=v1.13.0;sha256sum=ae8e8157da293279d085518ca009aa11dab141aa7d5521cb9c9851ce52c8c418 \
+    gomod://github.com/oschwald/maxminddb-golang;version=v1.13.1;sha256sum=717e0e89131541827935e02a76aed474247009bae9653a76b0c0a9152ba49e20 \
+    gomod://github.com/pborman/getopt;version=v0.0.0-20170112200414-7148bc3a4c30;mod=1;sha256sum=35411c4b33e0d9eb3a694855ac64f9889d85c957f86a4984ed7dcc123952ec9f \
+    gomod://github.com/pelletier/go-toml/v2;version=v2.3.0;sha256sum=27ab9ac7f21fbe4c16c8b8252b27d10d4e86f29adea7dbca15fb920e07787f3d \
     gomod://github.com/petar-dambovaliev/aho-corasick;version=v0.0.0-20250424160509-463d218d4745;sha256sum=e867b11b91e833e277f95a8d71e0a3462e647038bb49437eaef52d7b1ca881cb \
-    gomod://github.com/pierrec/lz4/v4;version=v4.1.15;mod=1;sha256sum=2c89e56a6db7a7760fa45f2494631d9202e10d9c5c4cb8e7377c37212d7cb975 \
-    gomod://github.com/pierrec/lz4/v4;version=v4.1.18;sha256sum=b397db34ff05610125e7c9de6de067a174a70ba3ba7dac81ba8ce4f22b1c0933 \
+    gomod://github.com/pierrec/lz4/v4;version=v4.1.26;sha256sum=cf67f99d8d4ed84775a51de3167b70907e5436dd2f501f37deffac46c0a51ae1 \
     gomod://github.com/pkg/errors;version=v0.8.1;mod=1;sha256sum=df28c6a823f181d76179697177c0c5943c6ffb38f3c10b2dc53be360ee7d4589 \
     gomod://github.com/pmezard/go-difflib;version=v0.0.0-20151028094244-d8ed2627bdf0;mod=1;sha256sum=74b2e766eb215377864d587badf57e95521f692d2a7860b3c7759093f9c9bec2 \
     gomod://github.com/pmezard/go-difflib;version=v1.0.0;mod=1;sha256sum=74b2e766eb215377864d587badf57e95521f692d2a7860b3c7759093f9c9bec2 \
-    gomod://github.com/pmezard/go-difflib;version=v1.0.1-0.20181226105442-5d4384ee4fb2;mod=1;sha256sum=74b2e766eb215377864d587badf57e95521f692d2a7860b3c7759093f9c9bec2 \
+    gomod://github.com/pmezard/go-difflib;version=v1.0.1-0.20181226105442-5d4384ee4fb2;sha256sum=24ff45e356f638a53bd0c89fff961fbeaecfdb0dc5e482ceed0a2230e0e5f3b7 \
     gomod://github.com/power-devops/perfstat;version=v0.0.0-20240221224432-82ca36839d55;mod=1;sha256sum=05744a9262bcd294613e65624f3f8bae83d79a58aa48b8328c7df91190aa07bf \
-    gomod://github.com/prometheus/client_golang;version=v1.23.2;sha256sum=dfcc6c52ad09e3d0dca2e9f41de7f8d1c0dde7baae4b867353d112918a1511de \
+    gomod://github.com/prometheus/client_golang;version=v1.24.1;sha256sum=90b627e392d9936cf410ed23066d6198fecc11130bbab2e17dda627da3a86fc3 \
     gomod://github.com/prometheus/client_model;version=v0.6.2;sha256sum=67017b19f220c6ab91ecfdd10a93824e2a8b09fcb6390054dbdc49df3354a9ca \
-    gomod://github.com/prometheus/common;version=v0.66.1;sha256sum=05d9e8e5c289209245dc22a7d07812b1b72472c67f372b5579dfabc3774e17b4 \
-    gomod://github.com/prometheus/procfs;version=v0.16.1;sha256sum=e4b74815566cbf5aa372d23e1de32f16ac5c3c4c80bc94a31fdee60a1de6074a \
+    gomod://github.com/prometheus/common;version=v0.70.1;sha256sum=587d6d0890642e7f9ef2ce6a76cdf6dcbd71f70c59437282a2e19c98cf68c2b8 \
+    gomod://github.com/prometheus/procfs;version=v0.21.1;sha256sum=b417ab3081ad334ce4c6b367b2d5e74dea49e2eb3b5431c1dd5a65e1256736f9 \
+    gomod://github.com/quic-go/qpack;version=v0.6.0;sha256sum=3ac037cd1747420bc00bd6a793b4b197a2359fc354de12dc2187477417564914 \
+    gomod://github.com/quic-go/quic-go;version=v0.59.1;sha256sum=d00c08f9c9fa94654733baecbbfc930c41e86aa2c84a5eadfe25b8ccf9685fff \
     gomod://github.com/r3labs/diff/v2;version=v2.15.1;sha256sum=58da63a4f92aaee6117b927788d60082418e0870be3e7c762341b748120ff510 \
     gomod://github.com/remyoudompheng/bigfft;version=v0.0.0-20230129092748-24d4a6f8daec;mod=1;sha256sum=6401dabced8e037796108d28559bffc06d135305cd6222c3cea153767ea95680 \
-    gomod://github.com/rivo/uniseg;version=v0.2.0;mod=1;sha256sum=6c7318a27a8d5473a8eb661e75fb00528176e0efc59310ed277ca13bd12a53f1 \
-    gomod://github.com/rivo/uniseg;version=v0.4.7;sha256sum=b995e4aa0cc1e5779cc61138ac925cb8c1e963e40c80e4b93ee8553812ebb792 \
     gomod://github.com/robfig/cron/v3;version=v3.0.1;sha256sum=ebe6454642220832a451b8cc50eae5f9150fd8d36b90b242a5de27676be86c70 \
     gomod://github.com/rogpeppe/go-internal;version=v1.3.0;mod=1;sha256sum=33b55e839b0754283c3eeec1f33e16cc66432dffb8b8a96d24f536d01e51495b \
     gomod://github.com/rs/xid;version=v1.2.1;mod=1;sha256sum=9825a682f345142b87e0d0a3de1ce877b4531961d5331f0f8c2cb869ca273c91 \
@@ -290,24 +295,23 @@ SRC_URI += "\
     gomod://github.com/rs/zerolog;version=v1.15.0;mod=1;sha256sum=a53fcb58074e9b31fa6bc5b2bb87853cd51d1b4d29489015dcbe439c79896b53 \
     gomod://github.com/russross/blackfriday/v2;version=v2.1.0;sha256sum=7852750d58a053ce38b01f2c203208817564f552ebf371b2b630081d7004c6ae \
     gomod://github.com/sanity-io/litter;version=v1.5.8;sha256sum=4880fcf58f4d2f712273bfd123a14d93161659054685ccb11aba31561e1bb17b \
-    gomod://github.com/santhosh-tekuri/jsonschema/v6;version=v6.0.2;mod=1;sha256sum=48f5e138633d4d85be9f6cd447e2db32aabd00e530a00a45985695af5e0372e5 \
+    gomod://github.com/santhosh-tekuri/jsonschema/v6;version=v6.0.3;sha256sum=79282583888de6fd146e513f01e09bd3b228976942d2114688e97608279b1ebe \
     gomod://github.com/satori/go.uuid;version=v1.2.0;mod=1;sha256sum=4179602495a0a2456cd6ad14a9964b3372683eb17998c287462eca379007c4ff \
-    gomod://github.com/segmentio/kafka-go;version=v0.4.48;sha256sum=21feb8ed80b4a7edaf4f2142d9410b9a20e51d644e0d0a6dc27938b3795bf231 \
-    gomod://github.com/sergi/go-diff;version=v1.3.1;mod=1;sha256sum=d0d5157e1c0396fdd42bd849a87542a5c34e55d81efa9c25177edf0884d65784 \
-    gomod://github.com/shirou/gopsutil/v4;version=v4.25.8;sha256sum=c79f74d9e5466578ffcb6031e02424e4687b60cf86b25bf5edafcd3310db9be5 \
+    gomod://github.com/segmentio/kafka-go;version=v0.4.51;sha256sum=2ce854a2dff96c98deeaf93c24925de64db859f5cded5ad18e57a83c860bbefa \
+    gomod://github.com/shirou/gopsutil/v4;version=v4.26.7;sha256sum=e707bb272b2d66974997f49becc1dd991b23b35c400cbdecd5906461e42c236c \
     gomod://github.com/shopspring/decimal;version=v0.0.0-20180709203117-cd690d0c9e24;mod=1;sha256sum=efb3296a57d42e30fbe229452070a1a87115dbbbafdd536dd738d18d46d55f52 \
     gomod://github.com/shopspring/decimal;version=v1.2.0;mod=1;sha256sum=983f79d79f2dfb76233371da2a6d6bd7980eed64c3e43ef7d815ebd37dae9c1e \
     gomod://github.com/shopspring/decimal;version=v1.4.0;sha256sum=751d4cd3460984afc72973d2a0df56ed9b10499c5cd0508d7f2207245d9e3315 \
+    gomod://github.com/sirupsen/logrus;version=v1.10.0;sha256sum=e9597626924d23f5e0e731fffe940b03cbf108ce7ec801fec65cdd48e5976e62 \
     gomod://github.com/sirupsen/logrus;version=v1.4.1;mod=1;sha256sum=219855a87fbdc6db059e210407557f24621981b1f17505a924a55832ac709113 \
     gomod://github.com/sirupsen/logrus;version=v1.4.2;mod=1;sha256sum=6c6bbbca5fad7ea9b863d9ec99c30caa77805785405b21e70d75783b5194c678 \
-    gomod://github.com/sirupsen/logrus;version=v1.9.3;sha256sum=4501f4e6b858bfdd997671fcdd2f647a3178b29b6b4d1344caa7c07517121dd0 \
-    gomod://github.com/slack-go/slack;version=v0.16.0;sha256sum=c241d63e8fc6a8931feab9af92e05c9d62f63070101ec7417422ee2ca1a1bb36 \
-    gomod://github.com/spf13/cast;version=v1.3.1;mod=1;sha256sum=b98f2c1774e0b7c0c5747531a6a0c6c8c25a37cf397ff05f1971bbdd97d52fae \
-    gomod://github.com/spf13/cast;version=v1.7.0;sha256sum=7b24198857474e3f3c9c368fdec153b06003d06863a182c77c0605c3e51002c1 \
-    gomod://github.com/spf13/cobra;version=v1.10.1;sha256sum=00955783267c9ced54274df456377a15bc1b658362f93f85dfda0708b54f9a28 \
+    gomod://github.com/slack-go/slack;version=v0.29.0;sha256sum=2943c9b8b2ac15cc76824bf0fd2779b80d8d1984a3d14b0c01ae32bca004cee3 \
+    gomod://github.com/spf13/cast;version=v1.10.0;sha256sum=7c7ba27f9979ada980c2a69f6b2fdf7b4ce1f2b766e245c0a4716f546ad7ddce \
+    gomod://github.com/spf13/cobra;version=v1.10.2;sha256sum=a00aae6fcd631e0fde52c98604452ff70e1b73c3b8a560d68db15aff5e26872d \
     gomod://github.com/spf13/cobra;version=v1.4.0;mod=1;sha256sum=575f3f520642009bac1fe464f2090d1c07298b4778f3c13ac1f00671790cdadb \
+    gomod://github.com/spf13/pflag;version=v1.0.10;sha256sum=a246b8c9d3daa87d6c634cdfee1bdf7fa53d5817eeef4fa0c6da43edd12de4ca \
     gomod://github.com/spf13/pflag;version=v1.0.5;mod=1;sha256sum=16c6dfc0eb58eb3c9113ce197d460c6725c647e4688ac26d31c8ed69f1ebbc68 \
-    gomod://github.com/spf13/pflag;version=v1.0.9;sha256sum=83910188d8735f84a48a80ab78351edac0b569896f2b3a244c696a07da9aa5ed \
+    gomod://github.com/spf13/pflag;version=v1.0.9;mod=1;sha256sum=16c6dfc0eb58eb3c9113ce197d460c6725c647e4688ac26d31c8ed69f1ebbc68 \
     gomod://github.com/stretchr/objx;version=v0.1.0;mod=1;sha256sum=1350354d52d2287a62336ecc0d56232d4c47699af9bba49c67c2b48254da98f1 \
     gomod://github.com/stretchr/objx;version=v0.1.1;mod=1;sha256sum=1350354d52d2287a62336ecc0d56232d4c47699af9bba49c67c2b48254da98f1 \
     gomod://github.com/stretchr/objx;version=v0.2.0;mod=1;sha256sum=27e3901c232f819e8d6e0b322c166732b8140b3977c0665925b5566138e87fec \
@@ -316,7 +320,7 @@ SRC_URI += "\
     gomod://github.com/stretchr/objx;version=v0.5.2;mod=1;sha256sum=58eca54d26728427806f40908828e8762d352cc3b0a0b0b60dc60ce61767fff6 \
     gomod://github.com/stretchr/testify;version=v0.0.0-20161117074351-18a02ba4a312;mod=1;sha256sum=4ab463f68c370041f950c10cab5104903d4598c50cf824f9aad1b7b7f69255af \
     gomod://github.com/stretchr/testify;version=v1.10.0;mod=1;sha256sum=c0a648a037da54a6b02e8a811b1d3917d49dc4e1841cd756f28f0c4f1593933c \
-    gomod://github.com/stretchr/testify;version=v1.11.1;mod=1;sha256sum=5846af204043f29df285026109bf32db6519c3d7e1d5c3a65fefb174f9d81d33 \
+    gomod://github.com/stretchr/testify;version=v1.12.1;mod=1;sha256sum=a6aa921ea6dedc1cbb384d3c1b79c58b6e5d6ce26d13b786ec60a99809ae1daa \
     gomod://github.com/stretchr/testify;version=v1.2.2;mod=1;sha256sum=4ab463f68c370041f950c10cab5104903d4598c50cf824f9aad1b7b7f69255af \
     gomod://github.com/stretchr/testify;version=v1.3.0;mod=1;sha256sum=ab063d5154a8e8730bced4c52698e5770eb50bfae347bebc35eca488b8e3f6e3 \
     gomod://github.com/stretchr/testify;version=v1.4.0;mod=1;sha256sum=6b0c7b71030d4fc55d4e6e6e24c0bfc025621341f76141e3aec0044c4ce89950 \
@@ -328,43 +332,42 @@ SRC_URI += "\
     gomod://github.com/stretchr/testify;version=v1.8.0;mod=1;sha256sum=e076074c1560ad1dda98b8b00fea6308c4b6ccd06ddd088d22db4626ed68f738 \
     gomod://github.com/stretchr/testify;version=v1.8.1;mod=1;sha256sum=af1a5dcb331ace7a3f9fc1b5d7eee9c0bc82b4a2a182fe4cec2add217e2853d6 \
     gomod://github.com/stretchr/testify;version=v1.8.4;mod=1;sha256sum=05e26cd069285a33cf2af46fdacdef569d5ae185e7963a76c0178328f68e97f9 \
-    gomod://github.com/tetratelabs/wazero;version=v1.9.0;sha256sum=caa5349be0eeac1d14b0faee72e5a9b2de198374e064fb9158e39d1d891217b7 \
+    gomod://github.com/tetratelabs/wazero;version=v1.12.0;sha256sum=dcee360162e809d1273c685d20f6faf6df7ae0d925a73bf8f1af1a4756bfe587 \
     gomod://github.com/tidwall/gjson;version=v1.18.0;sha256sum=ab8092b3e42f83f003466757c63ec819a45d1e83caa63c6c131cebbe760f1df2 \
-    gomod://github.com/tidwall/match;version=v1.1.1;sha256sum=2ba41f7f27330d49e0e432cbf96bf90720a33e4a97be58fe53f63a7e66f04d37 \
+    gomod://github.com/tidwall/match;version=v1.1.1;mod=1;sha256sum=02364e515327d9988d1f6bd37af9c584f8b98d3b4f43f9e1f18e26d76aec0f44 \
+    gomod://github.com/tidwall/match;version=v1.2.0;sha256sum=f35502f3dd450fa84ddc7b028310f7fecc86c8112f2397fe7ff7941c5afbcbc1 \
     gomod://github.com/tidwall/pretty;version=v1.2.0;mod=1;sha256sum=6e5c5fa493d8f18e8974b38ed63e8c71863cce59e659d98d0ef8417bf81e3ecf \
     gomod://github.com/tidwall/pretty;version=v1.2.1;sha256sum=9327579bf9e610de753eeb7c35c8cf1e3f56e6e5623cbf65e47bc8076023d1ab \
-    gomod://github.com/tklauser/go-sysconf;version=v0.3.15;sha256sum=caa29c6df6c316969c9f2559186bd1ca8f8aceafbef236233e415c1d974f0383 \
-    gomod://github.com/tklauser/numcpus;version=v0.10.0;sha256sum=b2526d47517ccff481cc7baad7f450bdde58ddb9b65d53e3eec7c3504f94e853 \
-    gomod://github.com/toorop/go-dkim;version=v0.0.0-20201103131630-e1cd1a0a5208;sha256sum=45b3a61ab1eb8f80f48e3a28ea7981dd8931fa3f31375d815402f0ef8018e3ff \
+    gomod://github.com/tklauser/go-sysconf;version=v0.3.16;sha256sum=d4c896f77e5934f54d772b5f6a8f8043b8d34df189f6581bc2ba84d239a6b643 \
+    gomod://github.com/tklauser/numcpus;version=v0.11.0;sha256sum=7a7527e1f68059a77189ae875c294e5c310925fbb8ba5a6c794edd2b7e687267 \
+    gomod://github.com/toorop/go-dkim;version=v0.0.0-20201103131630-e1cd1a0a5208;mod=1;sha256sum=67fee1d99ef4244df63e083e7b5a2800d9ab0244982d9d45177bf6ec31cf3af8 \
+    gomod://github.com/toorop/go-dkim;version=v0.0.0-20250226130143-9025cce95817;sha256sum=2a1c5262ea26e4ded1aef5aa4fee2b562cd54d9e0609f18dffd8b11d9e719e80 \
     gomod://github.com/twitchyliquid64/golang-asm;version=v0.15.1;mod=1;sha256sum=b198a096146daeff6177f0a11bdee5a2cbe0e6fec80714ccf1f2dd6b95a7dd6f \
-    gomod://github.com/ugorji/go/codec;version=v1.2.12;sha256sum=ca38b5b9f58e33de24f88ac2505e2c67f2b454d09d929228a10b938bddda848d \
+    gomod://github.com/ugorji/go/codec;version=v1.3.1;sha256sum=a559951814404d1f955cd8a3d91689c31ea774dc9fc0c7e4a5fa45cc749324d0 \
     gomod://github.com/umahmood/haversine;version=v0.0.0-20151105152445-808ab04add26;sha256sum=ffc82bcdb2bf7f1e64f1e940b9aeee8c6e81e84717cfad56170df9e298e28951 \
     gomod://github.com/valllabh/ocsf-schema-golang;version=v1.0.3;sha256sum=ffb04c1651a4e08f1339cc0e308f9699026e23acee7dda1dbf9ffea4ae2a8208 \
     gomod://github.com/vmihailenco/msgpack;version=v4.0.4+incompatible;sha256sum=918f7dd7883105b9c55728c704a3bc54c80568b2b09583890b51508c03391356 \
-    gomod://github.com/wasilibs/go-re2;version=v1.10.0;sha256sum=dddcf95e30684f986ac328689d7bf1f529e31a0f49c2449c67d6ab209470494d \
-    gomod://github.com/wasilibs/wazero-helpers;version=v0.0.0-20250123031827-cd30c44769bb;sha256sum=64f949dc77386e83881a6d5b60e49823e9c3446240c1476394db1a07bc5a762c \
-    gomod://github.com/xdg-go/pbkdf2;version=v1.0.0;mod=1;sha256sum=b21709ce5da1fca99d98e4664b4a673f2620cf33d0fc57564b9a534eb1a6d798 \
-    gomod://github.com/xdg-go/scram;version=v1.1.2;mod=1;sha256sum=b9d568c44018b33bddfcca5ebc51163b8de9bf64da60d8ea12fa88b88fe60cd8 \
-    gomod://github.com/xdg-go/stringprep;version=v1.0.4;mod=1;sha256sum=9f9e4513f20d770b95c24952d390a5ed3a07889e2cea661127b56f3e404657d1 \
+    gomod://github.com/wasilibs/go-re2;version=v1.12.0;sha256sum=5176f4611a3a5466e575070c0c2e6ebdddd328a8c13eae121ab72471feab55a3 \
+    gomod://github.com/wasilibs/wazero-helpers;version=v0.0.0-20250123031827-cd30c44769bb;mod=1;sha256sum=49ca46dffde7100373e17172bfb5217cddbd98e9e24898e6367ebb764abf270f \
+    gomod://github.com/x448/float16;version=v0.8.4;sha256sum=73b24a41037ea999ab66851e3798a0973dbb1f214925915b01f0820f7b2f1500 \
+    gomod://github.com/xdg-go/scram;version=v1.2.0;mod=1;sha256sum=6f032e4589e3660c7438543f499166c4190de48dc486b15ac1dda0ae392f47fc \
     gomod://github.com/xhit/go-simple-mail/v2;version=v2.16.0;sha256sum=dd5f49b91c868268619085df3330bb797ad423a2473dd4d8efc783fffb67d229 \
     gomod://github.com/youmark/pkcs8;version=v0.0.0-20240726163527-a2c0da244d78;sha256sum=cdcf5e96850f9f60bc96ab512e4bd06ee19dd2dbe855260c3589c6c79a1bcfb5 \
-    gomod://github.com/yuin/goldmark;version=v1.1.27;mod=1;sha256sum=e2c763f861ada05c6150c32f804bca31c96a18b944320e0ee9bbf0d6c6075ad7 \
-    gomod://github.com/yuin/goldmark;version=v1.2.1;mod=1;sha256sum=e2c763f861ada05c6150c32f804bca31c96a18b944320e0ee9bbf0d6c6075ad7 \
     gomod://github.com/yuin/goldmark;version=v1.4.13;mod=1;sha256sum=ee7fe4466203a01d3ac19adc134cdec99bc6de71992c28f3dd9a74480bff0603 \
     gomod://github.com/yusufpapurcu/wmi;version=v1.2.4;mod=1;sha256sum=ff2a9c8c99aaed6bc6984eae094a9e8cdc36f6ab2ef2c56779dd98ecc583135b \
-    gomod://github.com/zclconf/go-cty;version=v1.14.4;sha256sum=96325cc1e200dd6ea73535b2fdb2a8e9e143b597b23114c3cf7695e400cd78c9 \
-    gomod://github.com/zclconf/go-cty-yaml;version=v1.1.0;sha256sum=1419385462f79bc2d20da574ffcec0d766ad33b6d6ca5bdcbcf67992103c273c \
+    gomod://github.com/zclconf/go-cty;version=v1.18.0;sha256sum=410a989752bce9d5192cb23a350eba27b42575e3df5512d8d208e9d539f9f638 \
+    gomod://github.com/zclconf/go-cty-yaml;version=v1.2.0;sha256sum=84cd48191428a94ab2fc4f7b06d9826538e970d0a3ac3ef62c54088b161cbf8f \
     gomod://github.com/zenazn/goji;version=v0.9.0;mod=1;sha256sum=2e5435768eeb0ffb1593111093fbc436916d5c85b97cda404f77aa56643e79b7 \
-    gomod://go.mongodb.org/mongo-driver;version=v1.14.0;sha256sum=26e169eb3bd7639b44cfc0cf8b4469d110d13e0dae1518d49558138cf5449ff4 \
     gomod://go.opentelemetry.io/auto/sdk;version=v1.2.1;sha256sum=a08a16fc0a7041cdb875f47a260a56000632212c85f65a302a043c76380c8335 \
-    gomod://go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp;version=v0.60.0;sha256sum=0192a852a8c6b4fccd55a0400bda162a83a4935102ebdec5fcf56ef1e7d94a51 \
-    gomod://go.opentelemetry.io/otel;version=v1.39.0;sha256sum=bc050a9c5e07e09a8dba7dd70fdc31c821114bc87910e9d027218cf25ef62a72 \
-    gomod://go.opentelemetry.io/otel/metric;version=v1.39.0;sha256sum=75c1ba2a79f0b556d16a818591d199d8c82804c7b78a4b4f675985470420000d \
-    gomod://go.opentelemetry.io/otel/trace;version=v1.39.0;sha256sum=da9a3bda6281f72c041e00c76e794156cdb43228255650c2f323ee04ba9f632c \
+    gomod://go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp;version=v0.68.0;sha256sum=84a5f546bebf91ebebe431b04f13230e0bd189a0eefcc6652f523e4c29ae12ba \
+    gomod://go.opentelemetry.io/otel;version=v1.44.0;sha256sum=4b7ef50caaf3dc6fc1a058f9ce2ccda6aad2ab3e8657acc4c8bb3102f79c53bc \
+    gomod://go.opentelemetry.io/otel/metric;version=v1.44.0;sha256sum=4442ba5f269f81251f549acb14ac16176f23967f4a0706163440b0df91592f96 \
+    gomod://go.opentelemetry.io/otel/trace;version=v1.44.0;sha256sum=cd1abf8dcec62fe9788fae9105760db1711e6e994d2e31cdda57ccb467e7ceec \
     gomod://go.uber.org/atomic;version=v1.3.2;mod=1;sha256sum=dcff3098f14452022e7a84a52624be8082b87728f8ccf0baad7e06a3a285f3b7 \
     gomod://go.uber.org/atomic;version=v1.4.0;mod=1;sha256sum=dcff3098f14452022e7a84a52624be8082b87728f8ccf0baad7e06a3a285f3b7 \
     gomod://go.uber.org/atomic;version=v1.5.0;mod=1;sha256sum=782efe5cb1f88f104ab69bb7b2c099dc5ea88e64dec62a6fbe03dba7f53f1733 \
     gomod://go.uber.org/atomic;version=v1.6.0;mod=1;sha256sum=782efe5cb1f88f104ab69bb7b2c099dc5ea88e64dec62a6fbe03dba7f53f1733 \
+    gomod://go.uber.org/goleak;version=v1.3.0;mod=1;sha256sum=3f15dc6354aae8fe42d3cbd130230731d5c6aae6aa651ca6a73f4c646cda8fec \
     gomod://go.uber.org/multierr;version=v1.1.0;mod=1;sha256sum=ff6c97e57138fc150113ae9431c1dbb64827186cb6af4a78dba70d369d081aac \
     gomod://go.uber.org/multierr;version=v1.3.0;mod=1;sha256sum=1dc2cea1cb6094bcb35ad7770b6eac1d39dc4044ebaedbfa718a47e52b7dcee3 \
     gomod://go.uber.org/multierr;version=v1.5.0;mod=1;sha256sum=be412e345592b4e0d4af1aa1ec017b45570eef2d58d7a89d1677e6f75281f34f \
@@ -372,8 +375,10 @@ SRC_URI += "\
     gomod://go.uber.org/zap;version=v1.10.0;mod=1;sha256sum=e28ef1b76ac60f1897f36c50e704fc28c1283d59ae39b0c7dde6878e5cd4bdd6 \
     gomod://go.uber.org/zap;version=v1.13.0;mod=1;sha256sum=aff065f5dc3976d52c064fe0da7c535e10cb6378dc8a5c1ecbcad3fbb9523944 \
     gomod://go.uber.org/zap;version=v1.9.1;mod=1;sha256sum=e28ef1b76ac60f1897f36c50e704fc28c1283d59ae39b0c7dde6878e5cd4bdd6 \
-    gomod://go.yaml.in/yaml/v2;version=v2.4.2;sha256sum=ed63e181cbb5a991c104639b0e6d48d45fd951f22b47d4c5d1a36156d8ed06ee \
-    gomod://golang.org/x/arch;version=v0.15.0;mod=1;sha256sum=96439769b0cde554790077a58b1c11e483592f8c52dc5d3778cde40a027afc5d \
+    gomod://go.yaml.in/yaml/v2;version=v2.4.4;sha256sum=1b98a6a498cf255c5f2982d32c74633bc7969770957e98103ac1e14345aa4576 \
+    gomod://go.yaml.in/yaml/v3;version=v3.0.4;mod=1;sha256sum=2989f8b800605890ad40cf49109b0b6a972bda79d92df236d40ddb798093127e \
+    gomod://go.yaml.in/yaml/v3;version=v3.0.5;sha256sum=f2d70caa35f66283aec58b889af8c5f07c374c5934be27a738c1215263e19205 \
+    gomod://golang.org/x/arch;version=v0.25.0;mod=1;sha256sum=395ebb3de2e12b6c0e9848a1071b46c27715970e09d45616a658f63a0a501a6f \
     gomod://golang.org/x/crypto;version=v0.0.0-20190308221718-c2843e01d9a2;mod=1;sha256sum=33ed070a5a66e0960685ac5386440e1b59899e74d8a38a1180685e72a2195ded \
     gomod://golang.org/x/crypto;version=v0.0.0-20190411191339-88737f569e3a;mod=1;sha256sum=b9489bf48de3551f57868f35d44753705bbb573942ee50075911d0147d94adf3 \
     gomod://golang.org/x/crypto;version=v0.0.0-20190510104115-cbcb75029529;mod=1;sha256sum=3ab9f01f4610fe7b39bd85d68e8d97825351e7e282c39cda41457c2a276f3be3 \
@@ -384,16 +389,13 @@ SRC_URI += "\
     gomod://golang.org/x/crypto;version=v0.0.0-20210616213533-5ff15b29337e;mod=1;sha256sum=cd6311612a2aa4d0d7e03c41b3aa1fbc2d5f895ab3f61089fab80bfe9f8f5485 \
     gomod://golang.org/x/crypto;version=v0.0.0-20210711020723-a769d52b0f97;mod=1;sha256sum=cd6311612a2aa4d0d7e03c41b3aa1fbc2d5f895ab3f61089fab80bfe9f8f5485 \
     gomod://golang.org/x/crypto;version=v0.0.0-20210921155107-089bfa567519;mod=1;sha256sum=cd6311612a2aa4d0d7e03c41b3aa1fbc2d5f895ab3f61089fab80bfe9f8f5485 \
-    gomod://golang.org/x/crypto;version=v0.14.0;mod=1;sha256sum=336a220466eb3ced51eb4489762a3264a5cfb6cb710358870096660099a9caa7 \
-    gomod://golang.org/x/crypto;version=v0.3.0;mod=1;sha256sum=b795106f8b8deb7ed77523a81de01ab4601f0f0381353918457d2d78ad9e3ce9 \
-    gomod://golang.org/x/crypto;version=v0.46.0;sha256sum=5f2921ccdf7252ffbe26046948c6044ab0917e500a34710e0ba6664260d6a460 \
-    gomod://golang.org/x/exp;version=v0.0.0-20250620022241-b7579e27df2b;mod=1;sha256sum=210261af3b2b0d7bc9d913800ba9364e53fcec004fad4762505438360c3ed448 \
+    gomod://golang.org/x/crypto;version=v0.19.0;mod=1;sha256sum=f8b595e5c961093c6877b96af679f43322254a53087b11fd2645642e693befd5 \
+    gomod://golang.org/x/crypto;version=v0.20.0;mod=1;sha256sum=d8536991eb61062128778a081f729b52e279ed1eb4d76ce180bda420bf87a100 \
+    gomod://golang.org/x/crypto;version=v0.55.0;sha256sum=0660bba47b3643fe1beb1b97af93b6a4d2bf2ed069d9e52a2b1bdf6f17cf3e79 \
     gomod://golang.org/x/lint;version=v0.0.0-20190930215403-16217165b5de;mod=1;sha256sum=79df4350b922a8d193782e5600f88280a2b9d41781bfb3760c09bf52ad3023bf \
     gomod://golang.org/x/mod;version=v0.0.0-20190513183733-4bf6d317e70e;mod=1;sha256sum=ac221647647b0b59618b2e312ba252fc36d6e5cf33d0f2ca64f1fac65a1d6034 \
     gomod://golang.org/x/mod;version=v0.1.1-0.20191105210325-c90efee705ee;mod=1;sha256sum=d76bbdea81d196d09858967a67ac805dacecdd1fb30c5001a187d24c129b1597 \
-    gomod://golang.org/x/mod;version=v0.2.0;mod=1;sha256sum=b288f088fd851885a6d348339e2f588e58a94e6c76e5e634ae1d67c2749eb413 \
-    gomod://golang.org/x/mod;version=v0.3.0;mod=1;sha256sum=b288f088fd851885a6d348339e2f588e58a94e6c76e5e634ae1d67c2749eb413 \
-    gomod://golang.org/x/mod;version=v0.30.0;sha256sum=dffdae50c0a7903e522053e8e9880069ed1854446326f954cf903f713678c3a2 \
+    gomod://golang.org/x/mod;version=v0.40.0;sha256sum=a191080b1494c194059ae71aa1d300741a8e24dfb6e28cd32580dbdcc52a0598 \
     gomod://golang.org/x/mod;version=v0.6.0-dev.0.20220419223038-86c51ed26bb4;mod=1;sha256sum=42d19023ff8f2eae700bc5495f371ecd998a22d19ba985d0af5f69900b254083 \
     gomod://golang.org/x/mod;version=v0.8.0;mod=1;sha256sum=624567459c6e9947ac4abde0b7034ee61dcbb6a9373f5970094c0bb3e8121964 \
     gomod://golang.org/x/net;version=v0.0.0-20190311183353-d8887717615a;mod=1;sha256sum=f7046769daac02beb57cbcc481280df59fb403c96fe8262282aba858c7f7fa4d \
@@ -401,21 +403,17 @@ SRC_URI += "\
     gomod://golang.org/x/net;version=v0.0.0-20190603091049-60506f45cf65;mod=1;sha256sum=6ebeb3fafb09612d3ef1ff0413dfaac05bbaf8f229abde0ae0e012298dfe6702 \
     gomod://golang.org/x/net;version=v0.0.0-20190620200207-3b0461eec859;mod=1;sha256sum=e6efdaf78a29503f080cf6d2615e289cfb1d9e3ab7d570f53668eca2b4ab41da \
     gomod://golang.org/x/net;version=v0.0.0-20190813141303-74dc4d7220e7;mod=1;sha256sum=e6efdaf78a29503f080cf6d2615e289cfb1d9e3ab7d570f53668eca2b4ab41da \
-    gomod://golang.org/x/net;version=v0.0.0-20200226121028-0de0cce0169b;mod=1;sha256sum=e6efdaf78a29503f080cf6d2615e289cfb1d9e3ab7d570f53668eca2b4ab41da \
-    gomod://golang.org/x/net;version=v0.0.0-20201021035429-f5854403a974;mod=1;sha256sum=66fc44a0644a506da780f7a22a5d73dd025d44a6e58740b62d27f74d7c3a4948 \
     gomod://golang.org/x/net;version=v0.0.0-20210226172049-e18ecbb05110;mod=1;sha256sum=fef5896d103a0bce5055fdb5e96e830944334792437865347718edceb633348a \
     gomod://golang.org/x/net;version=v0.0.0-20220722155237-a158d28d115b;mod=1;sha256sum=b315c52647d2da2f76e5cdb9d367e1d6727784236a9bffb612192b19b10a128d \
     gomod://golang.org/x/net;version=v0.10.0;mod=1;sha256sum=d3b7e236ff09e6322be489170216e018d3221862f1a053dcb63e53eab8533c17 \
-    gomod://golang.org/x/net;version=v0.17.0;mod=1;sha256sum=cba6184b8b8e0d54560bf5a65f136ccd76a734c49c066ed803eb70bd06c17696 \
-    gomod://golang.org/x/net;version=v0.2.0;mod=1;sha256sum=07ec645e3353fc2673f2d8dee5c14eb928b9c13127a409fe3ec40eaba4dbdb30 \
-    gomod://golang.org/x/net;version=v0.48.0;sha256sum=cf5206797e66bbe72fc13542d53a57d069a563cebb6d045c07a870eb4fd888c9 \
+    gomod://golang.org/x/net;version=v0.21.0;mod=1;sha256sum=0eef3e9fe7f668be5b4d24c8f1251c6c502d1168953c8081ac9dc3f399c64f06 \
+    gomod://golang.org/x/net;version=v0.58.0;sha256sum=aa78bbf8d55db3e6995630165e2bcd7dce6d0b8831c166fa03b80ac94fb650e7 \
     gomod://golang.org/x/net;version=v0.6.0;mod=1;sha256sum=41ec76ea2172f3ee3031e38f9a535939a584d6bb35ef480854fdcb8c2026701b \
+    gomod://golang.org/x/oauth2;version=v0.36.0;sha256sum=15bf65ff103e5dafc809d78cd037a1d1e88ccb8451824e851156002a13304504 \
     gomod://golang.org/x/sync;version=v0.0.0-20190423024810-112230192c58;mod=1;sha256sum=421f6139686d5891f3dc5a563d0995780d3279f65cad4d225cea52686794161c \
-    gomod://golang.org/x/sync;version=v0.0.0-20190911185100-cd5d95a43a6e;mod=1;sha256sum=421f6139686d5891f3dc5a563d0995780d3279f65cad4d225cea52686794161c \
-    gomod://golang.org/x/sync;version=v0.0.0-20201020160332-67f06af15bc9;mod=1;sha256sum=421f6139686d5891f3dc5a563d0995780d3279f65cad4d225cea52686794161c \
     gomod://golang.org/x/sync;version=v0.0.0-20220722155255-886fb9371eb4;mod=1;sha256sum=421f6139686d5891f3dc5a563d0995780d3279f65cad4d225cea52686794161c \
     gomod://golang.org/x/sync;version=v0.1.0;mod=1;sha256sum=421f6139686d5891f3dc5a563d0995780d3279f65cad4d225cea52686794161c \
-    gomod://golang.org/x/sync;version=v0.19.0;sha256sum=25211fe2cffd8020bb405b9adb7a90f5e06760f2818b8fb2e74aaaa21a66ed9e \
+    gomod://golang.org/x/sync;version=v0.22.0;sha256sum=4bc67d258ce7867cfc1a43765c43d98b4c49b90c46dd0b86f896a5a4909fade0 \
     gomod://golang.org/x/sys;version=v0.0.0-20180905080454-ebe1bf3edb33;mod=1;sha256sum=8969115e4a39108848324e79a1bd8a8445230e6e3aaccbe9f8057fb50fffc8c1 \
     gomod://golang.org/x/sys;version=v0.0.0-20190215142949-d0b11bdaac8a;mod=1;sha256sum=8969115e4a39108848324e79a1bd8a8445230e6e3aaccbe9f8057fb50fffc8c1 \
     gomod://golang.org/x/sys;version=v0.0.0-20190222072716-a9d3bda3a223;mod=1;sha256sum=8969115e4a39108848324e79a1bd8a8445230e6e3aaccbe9f8057fb50fffc8c1 \
@@ -427,7 +425,6 @@ SRC_URI += "\
     gomod://golang.org/x/sys;version=v0.0.0-20191026070338-33540a1f6037;mod=1;sha256sum=181979e8bd57d2d9e064182da86c9a6111aa69755e888f08431ece4742aec343 \
     gomod://golang.org/x/sys;version=v0.0.0-20200116001909-b77594299b42;mod=1;sha256sum=181979e8bd57d2d9e064182da86c9a6111aa69755e888f08431ece4742aec343 \
     gomod://golang.org/x/sys;version=v0.0.0-20200223170610-d5e6a3e2c0ae;mod=1;sha256sum=181979e8bd57d2d9e064182da86c9a6111aa69755e888f08431ece4742aec343 \
-    gomod://golang.org/x/sys;version=v0.0.0-20200930185726-fdedc70b468f;mod=1;sha256sum=181979e8bd57d2d9e064182da86c9a6111aa69755e888f08431ece4742aec343 \
     gomod://golang.org/x/sys;version=v0.0.0-20201119102817-f84b799fce68;mod=1;sha256sum=181979e8bd57d2d9e064182da86c9a6111aa69755e888f08431ece4742aec343 \
     gomod://golang.org/x/sys;version=v0.0.0-20201204225414-ed752295db88;mod=1;sha256sum=181979e8bd57d2d9e064182da86c9a6111aa69755e888f08431ece4742aec343 \
     gomod://golang.org/x/sys;version=v0.0.0-20210615035016-665e8c7367d1;mod=1;sha256sum=f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024 \
@@ -437,23 +434,20 @@ SRC_URI += "\
     gomod://golang.org/x/sys;version=v0.0.0-20220520151302-bc2c85ada10a;mod=1;sha256sum=f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024 \
     gomod://golang.org/x/sys;version=v0.0.0-20220715151400-c0bba94af5f8;mod=1;sha256sum=f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024 \
     gomod://golang.org/x/sys;version=v0.0.0-20220722155257-8c9f86f7a55f;mod=1;sha256sum=f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024 \
-    gomod://golang.org/x/sys;version=v0.0.0-20220811171246-fbc7d0a398ab;mod=1;sha256sum=f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024 \
     gomod://golang.org/x/sys;version=v0.0.0-20220908164124-27713097b956;mod=1;sha256sum=f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024 \
-    gomod://golang.org/x/sys;version=v0.13.0;mod=1;sha256sum=f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024 \
-    gomod://golang.org/x/sys;version=v0.2.0;mod=1;sha256sum=f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024 \
-    gomod://golang.org/x/sys;version=v0.39.0;sha256sum=65444efd299ce78bc457588bc2061e69fb5ceadec70220eeda39657402ad4b1b \
+    gomod://golang.org/x/sys;version=v0.1.0;mod=1;sha256sum=f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024 \
+    gomod://golang.org/x/sys;version=v0.17.0;mod=1;sha256sum=d227b325f621f4ebe28d39ba773ea99b870f393b7c09c34592c365b16dd560de \
+    gomod://golang.org/x/sys;version=v0.47.0;sha256sum=cdac013ddced0262926ec29ffcda645da39670e61c7e5b761e572b6b1809bb1b \
     gomod://golang.org/x/sys;version=v0.5.0;mod=1;sha256sum=f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024 \
-    gomod://golang.org/x/sys;version=v0.6.0;mod=1;sha256sum=f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024 \
     gomod://golang.org/x/sys;version=v0.8.0;mod=1;sha256sum=f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024 \
     gomod://golang.org/x/term;version=v0.0.0-20201117132131-f5c789dd3221;mod=1;sha256sum=be95e45a793860e61e60b5d4373946d73b25d6e1d42e4455a8acdef6c665ef84 \
     gomod://golang.org/x/term;version=v0.0.0-20201126162022-7de9c90e9dd1;mod=1;sha256sum=4cbab14f7706771b271d995a1b3cc131fe5a246aadc7ee6d1ba6f0bd894781fa \
     gomod://golang.org/x/term;version=v0.0.0-20210927222741-03fcf44c2211;mod=1;sha256sum=740794e2914f5cc87e25656c5843222b2c65665821205f45632a0477c8d3f79b \
-    gomod://golang.org/x/term;version=v0.13.0;mod=1;sha256sum=26277b0b5bc33d0241f2337839e8a663d2a6c603058870f27ced9df1fee7e357 \
-    gomod://golang.org/x/term;version=v0.2.0;mod=1;sha256sum=edf833da101900fe2ce8db23409e42448f441898d3d7d8ee451988e3b30c9302 \
-    gomod://golang.org/x/term;version=v0.38.0;sha256sum=00cec8beae98bb5a15c9ee9e8e705b7cab9c50269e7858bff98df0533b317363 \
+    gomod://golang.org/x/term;version=v0.17.0;mod=1;sha256sum=dbea02254aac2cf3fd0f72c7c602e543c5fbad2d00dafc2f819c28a935258199 \
+    gomod://golang.org/x/term;version=v0.45.0;sha256sum=b3a3af689728b43012ae1b21482571a35c033c545e98e021606bd4fcf1f79108 \
     gomod://golang.org/x/term;version=v0.5.0;mod=1;sha256sum=0d6f58228aadc1a6528e6755da018516566e3ae5c5201f7ade1773f56fa8d934 \
     gomod://golang.org/x/term;version=v0.8.0;mod=1;sha256sum=5d362d6a83453f7024725e824c05c5949624ef8f4cb13f5d7e3d4b7f1ca0b327 \
-    gomod://golang.org/x/text;version=v0.13.0;mod=1;sha256sum=151e6a1839491c4b50dfe9c33451f06328d5518bd8ee4a0061de02b7ad332fb2 \
+    gomod://golang.org/x/text;version=v0.14.0;mod=1;sha256sum=971579f17e9abc5926ab76214f533bd517cf4925c885243ac4755a1a0a7c69ef \
     gomod://golang.org/x/text;version=v0.3.0;mod=1;sha256sum=36879d586fd8001e84da8787190a11e4f78749e2a81dfe8b9b6931899fff31cf \
     gomod://golang.org/x/text;version=v0.3.2;mod=1;sha256sum=6c3c7adf2b0ad7143d913f4698d1908422369a5e6f198620f97f3e52f9a1b8dd \
     gomod://golang.org/x/text;version=v0.3.3;mod=1;sha256sum=fbb7a88ed140515e790eca7a10ffd319c9786b11c6a6c7e59f80f7fb37bb4542 \
@@ -461,8 +455,8 @@ SRC_URI += "\
     gomod://golang.org/x/text;version=v0.3.6;mod=1;sha256sum=fbb7a88ed140515e790eca7a10ffd319c9786b11c6a6c7e59f80f7fb37bb4542 \
     gomod://golang.org/x/text;version=v0.3.7;mod=1;sha256sum=c45d669089427bc4635d07b185f9b9680332d1c48c75b3c49cb715b81a04a5b0 \
     gomod://golang.org/x/text;version=v0.3.8;mod=1;sha256sum=0c06e8d4bc0c4eddce0f9ca01ad87dd9ff74cad7fa8ba166fe97d97d1deb27ae \
-    gomod://golang.org/x/text;version=v0.32.0;sha256sum=bc6c70d37c37bc625a83abd48ee32372b459a8c559a1cf5f25dfbf7c7941f81b \
     gomod://golang.org/x/text;version=v0.4.0;mod=1;sha256sum=15929e76fce04aea4c92a354426bb43370684645a4ee03f2e75d0c2eb1466304 \
+    gomod://golang.org/x/text;version=v0.41.0;sha256sum=e63f35daaae749d0ffff97a295ad8f4837a662938a46b7a87f18a88e85a5cbf9 \
     gomod://golang.org/x/text;version=v0.7.0;mod=1;sha256sum=15929e76fce04aea4c92a354426bb43370684645a4ee03f2e75d0c2eb1466304 \
     gomod://golang.org/x/text;version=v0.9.0;mod=1;sha256sum=436f592e77b593b02fbea374e23ad3369c8623ff0d29c91de7de1e6672db9a41 \
     gomod://golang.org/x/tools;version=v0.0.0-20180917221912-90fa682c2a6e;mod=1;sha256sum=a0e02f0678fe62dc3c4b4bc77fa912c9b70de10fa9f7cf2f7aad0337392b52af \
@@ -474,9 +468,8 @@ SRC_URI += "\
     gomod://golang.org/x/tools;version=v0.0.0-20191029190741-b9c20aec41a5;mod=1;sha256sum=88d479265f886f5e598d76c003d0f257b42dbf1b895d820a12b5ab0b3501aca1 \
     gomod://golang.org/x/tools;version=v0.0.0-20191119224855-298f0cb1881e;mod=1;sha256sum=88d479265f886f5e598d76c003d0f257b42dbf1b895d820a12b5ab0b3501aca1 \
     gomod://golang.org/x/tools;version=v0.0.0-20200103221440-774c71fcf114;mod=1;sha256sum=5ea469c803b6ef8d41d1561b9e301a003fdd93976468bda5574b26b056ea7f49 \
-    gomod://golang.org/x/tools;version=v0.0.0-20200619180055-7c47624df98f;mod=1;sha256sum=ef6e2f94244214971780f9ba31d90806928ad410c82b04d8888f815341f7a667 \
-    gomod://golang.org/x/tools;version=v0.0.0-20210106214847-113979e3529a;mod=1;sha256sum=25d72c03e7aa571136087ebafc9e83d004d0bd8cd3864d78c2f5813e122aba81 \
     gomod://golang.org/x/tools;version=v0.1.12;mod=1;sha256sum=2a8b9365898f0822face65ba089a1353e68a65d342f300ca317cceccde6421f3 \
+    gomod://golang.org/x/tools;version=v0.49.0;mod=1;sha256sum=86e34efea35b8aa52aabff0ea18c0ef217f074dff67ef7b4c700ae833968cf62 \
     gomod://golang.org/x/tools;version=v0.6.0;mod=1;sha256sum=830ed78dcd3e9927c412e2641230308447749d513d31024d276e2443b2016609 \
     gomod://golang.org/x/xerrors;version=v0.0.0-20190410155217-1f06c39b4373;mod=1;sha256sum=aa5e3ec9bb7b9f681609efac019d9de1a7ba7719248ff1eaa27e78882db3d7f5 \
     gomod://golang.org/x/xerrors;version=v0.0.0-20190513163551-3ee3066db522;mod=1;sha256sum=aa5e3ec9bb7b9f681609efac019d9de1a7ba7719248ff1eaa27e78882db3d7f5 \
@@ -486,38 +479,39 @@ SRC_URI += "\
     gomod://golang.org/x/xerrors;version=v0.0.0-20200804184101-5ec99f83aff1;mod=1;sha256sum=aa5e3ec9bb7b9f681609efac019d9de1a7ba7719248ff1eaa27e78882db3d7f5 \
     gomod://google.golang.org/appengine;version=v1.6.6;mod=1;sha256sum=476fc776d2906c32b6d6f30691df098cd4a70ad57967b3818faa444319cd9294 \
     gomod://google.golang.org/appengine;version=v1.6.8;mod=1;sha256sum=ef17709123a95906e09d1318b71489fd455bd6efbf6d404083b3137256df2423 \
-    gomod://google.golang.org/genproto/googleapis/rpc;version=v0.0.0-20251202230838-ff82c1b0f217;sha256sum=29f02d8e0e2f6e9cc0ee24abc29989e5e44d168eec35c12046efee3fea201aef \
-    gomod://google.golang.org/grpc;version=v1.79.3;sha256sum=91e4c27a4c29ed867049d1eadbb29fb7cc6cd58c364ca2004d22bbaaafcafb9f \
+    gomod://google.golang.org/genproto/googleapis/rpc;version=v0.0.0-20260526163538-3dc84a4a5aaa;sha256sum=55f932b106d6f4f8cb76ae869e44f5d6d8400965fa441ee3532d09c96d64aac1 \
+    gomod://google.golang.org/grpc;version=v1.83.0;sha256sum=74f959ac1f70dc56b80f39b8001abe5b4af5d325d72d38dd65d3b9a8d380011b \
     gomod://google.golang.org/protobuf;version=v1.26.0;mod=1;sha256sum=08ec2e20f38efcb651462800069ece4891e252a261007fa9d5a1b157f516ee5f \
     gomod://google.golang.org/protobuf;version=v1.26.0-rc.1;mod=1;sha256sum=b2c4fe1a66ff5be6eb7c0c5388f080d08821c327ac5cf975dee51d8b0fb49e9f \
-    gomod://google.golang.org/protobuf;version=v1.36.10;sha256sum=9265fbe7d073ca8571f1a9c4b8e8f20b244c35ad913346892d688e58fe4b1f22 \
+    gomod://google.golang.org/protobuf;version=v1.36.12;sha256sum=68f8a3174aff42950fd9bd02c11b45c6986eb8060508d124d1c3dd6bf86b9be6 \
     gomod://gopkg.in/check.v1;version=v0.0.0-20161208181325-20d25e280405;mod=1;sha256sum=5c306e0d633cd66a11b40e2e5fbbc6da42110db7d72ea3c1524ceb45ee40c33f \
     gomod://gopkg.in/check.v1;version=v1.0.0-20180628173108-788fd7840127;mod=1;sha256sum=5c306e0d633cd66a11b40e2e5fbbc6da42110db7d72ea3c1524ceb45ee40c33f \
-    gomod://gopkg.in/check.v1;version=v1.0.0-20190902080502-41f04d3bba15;mod=1;sha256sum=5c306e0d633cd66a11b40e2e5fbbc6da42110db7d72ea3c1524ceb45ee40c33f \
     gomod://gopkg.in/errgo.v2;version=v2.1.0;mod=1;sha256sum=e305204248256627966ff85c7dc591cf2d0e7de2094d0f465849f1b62a102748 \
+    gomod://gopkg.in/evanphx/json-patch.v4;version=v4.13.0;sha256sum=de94747c5023a2c83909845c76acc6b4bfe28b44994207394b5e057f3085625a \
     gomod://gopkg.in/inconshreveable/log15.v2;version=v2.0.0-20180818164646-67afb5ed74ec;mod=1;sha256sum=1d56fa48d098d7a6777880892ee6cf2176cbdc1e8645b4bfcbd6730ac93c3655 \
     gomod://gopkg.in/inf.v0;version=v0.9.1;sha256sum=08abac18c95cc43b725d4925f63309398d618beab68b4669659b61255e5374a0 \
     gomod://gopkg.in/natefinch/lumberjack.v2;version=v2.2.1;sha256sum=e28804b050e7debf4f5b2dd8d241d804f5d592d0519b6e7a3dc9d4cce6f075b3 \
     gomod://gopkg.in/tomb.v1;version=v1.0.0-20141024135613-dd632973f1e7;sha256sum=34898dc0e38ba7a792ab74a3e0fa113116313fd9142ffb444b011fd392762186 \
     gomod://gopkg.in/tomb.v2;version=v2.0.0-20161208151619-d5d1b5820637;sha256sum=15d93d96e1e8b2d8daf7b9e57a2a9193c0e676a2c6b63d9325bf34b53e93db00 \
     gomod://gopkg.in/yaml.v2;version=v2.2.2;mod=1;sha256sum=88d979d2f093d2397f756bc86efa2ca03f73a60d668ceb391b3510029f3f7cfc \
-    gomod://gopkg.in/yaml.v2;version=v2.2.8;mod=1;sha256sum=88d979d2f093d2397f756bc86efa2ca03f73a60d668ceb391b3510029f3f7cfc \
-    gomod://gopkg.in/yaml.v2;version=v2.3.0;mod=1;sha256sum=88d979d2f093d2397f756bc86efa2ca03f73a60d668ceb391b3510029f3f7cfc \
     gomod://gopkg.in/yaml.v2;version=v2.4.0;sha256sum=ede49e27c4cca6cdd2ec719aed8ea4d363710cceb3d411e7a786fbdec0d391fd \
     gomod://gopkg.in/yaml.v3;version=v3.0.0-20200313102051-9f266ea9e77c;mod=1;sha256sum=21579860a20306fcf43b1bd234d1fba319499c77611b71c05f9bf3ba90dab939 \
     gomod://gopkg.in/yaml.v3;version=v3.0.1;sha256sum=aab8fbc4e6300ea08e6afe1caea18a21c90c79f489f52c53e2f20431f1a9a015 \
     gomod://honnef.co/go/tools;version=v0.0.1-2019.2.3;mod=1;sha256sum=592e9c55bb272525a46900c55469feb97adae507e7649beab4dc1350d735f64f \
-    gomod://k8s.io/api;version=v0.28.4;sha256sum=eff8202063496b701784d305dc90c235c1b6df8b394a04161f1890f3ee8164e3 \
-    gomod://k8s.io/apimachinery;version=v0.28.4;sha256sum=731a1f026cbb3cefcca91fc0a758d6249207f3b36cc004ac2e498b3828745b48 \
-    gomod://k8s.io/apiserver;version=v0.28.4;sha256sum=bffa8bf91447c8327f5a1acb5296f45ce248048328c60b22f9046da2ed09f0a5 \
-    gomod://k8s.io/klog/v2;version=v2.100.1;sha256sum=753a27de9f28b54d76937797e1a6c9a197c92ff97dd17330d2800b8de2a06241 \
-    gomod://k8s.io/utils;version=v0.0.0-20230406110748-d93618cff8a2;sha256sum=548e140f5e720fae8058b3020ceb1c79299a0c2a2f7af0cd878d50345ba37503 \
-    gomod://modernc.org/libc;version=v1.66.10;mod=1;sha256sum=63ce2408b0d247d899f24f90b9cfa7301ca7ae68f0663543fbb86ba3750f5592 \
+    gomod://k8s.io/api;version=v0.36.3;sha256sum=95f7a42e06dbd40d12aaf3e970bf14444a439e1d64b96dfad936070793bdff21 \
+    gomod://k8s.io/apimachinery;version=v0.36.3;sha256sum=23ab7303b43f39c7275a56b44b3f4e38ed9f77db0296a711ab2324ef3cf81297 \
+    gomod://k8s.io/apiserver;version=v0.36.3;sha256sum=0d227bfb8ee65a5ac90796b179180534bffd9581e5045debb9076836f910c07c \
+    gomod://k8s.io/client-go;version=v0.36.3;sha256sum=6747e6664289daae7f310b54e594b56e91edd252d607cfcd8cdccbb5a59f45b7 \
+    gomod://k8s.io/klog/v2;version=v2.140.0;sha256sum=46fab8686139b04c42f1b44e84c5a162667fbf22628216d5061d95206625a886 \
+    gomod://k8s.io/kube-openapi;version=v0.0.0-20260330154417-16be699c7b31;sha256sum=41eef64b5efc175ae1f174812e622fc1674f1f1848ee156e95a8ec40a5006a82 \
+    gomod://k8s.io/utils;version=v0.0.0-20260319190234-28399d86e0b5;sha256sum=5d87a7ffd5c0ba5381c1af420a421938a4bff87badf2d002c17013feee978a54 \
+    gomod://modernc.org/libc;version=v1.74.4;mod=1;sha256sum=2904d69c00aef038bbe75d81a30f01ae2891d5f6ebd814be6a8221255483dfff \
     gomod://modernc.org/mathutil;version=v1.7.1;mod=1;sha256sum=68683385203fe0204d853bae60003c336716d2526e7149bf58f51815a2479fd8 \
     gomod://modernc.org/memory;version=v1.11.0;mod=1;sha256sum=e9890d3b9794d40a3703aa9809edc4e131cbb55a2831b602314076e91c5ace97 \
-    gomod://modernc.org/sqlite;version=v1.42.2;mod=1;sha256sum=01f57ba172ac6cdec9dc43f2fc78e609e84e65a66008025189efceb219e435e8 \
-    gomod://nullprogram.com/x/optparse;version=v1.0.0;mod=1;sha256sum=b295dfc4e093132fbae98f3bb582e8a70d15d88c81e212bd15cad9bd837364fe \
+    gomod://modernc.org/sqlite;version=v1.56.0;mod=1;sha256sum=16d48f22c12f295bdb2b457473223bfa96c2b480d0bfb3243e8ecc577f49f10a \
     gomod://rsc.io/binaryregexp;version=v0.2.0;sha256sum=b3e706aa278fa7f880d32fa1cc40ef8282d1fc7d6e00356579ed0db88f3b0047 \
-    gomod://sigs.k8s.io/json;version=v0.0.0-20221116044647-bc3834ca7abd;sha256sum=ddcc6a7c6c22b9b370c270bfefb4b68f424bf740aa18cb766f104531de6e0e6e \
-    gomod://sigs.k8s.io/structured-merge-diff/v4;version=v4.2.3;sha256sum=81c147c247afbc71fa135b2f4209c0641e141267be5c6a956a0f8bf851e74e31 \
+    gomod://sigs.k8s.io/json;version=v0.0.0-20250730193827-2d320260d730;sha256sum=7cec6eae3e4e4c9c1e0a009eef200740990fafbcb9cab081eb18ce32f6e7a7b9 \
+    gomod://sigs.k8s.io/randfill;version=v1.0.0;sha256sum=31dbbfc44ce12f78f1b68d6bbeed8526aa73c53243353d44d50b2532c828f5f1 \
+    gomod://sigs.k8s.io/structured-merge-diff/v6;version=v6.3.3;sha256sum=cc7604660434c50e1ca34529ea9b395af5333ba4521bfd463161d6db838e8966 \
+    gomod://sigs.k8s.io/yaml;version=v1.6.0;sha256sum=cf88648a471581817b00a42ee8d24fd73eb0e3503998cf46d8e63787e11e5052 \
 "
diff --git a/recipes-ids/crowdsec/crowdsec-licenses.inc b/recipes-ids/crowdsec/crowdsec-licenses.inc
index cb45b10..362f5c1 100644
--- a/recipes-ids/crowdsec/crowdsec-licenses.inc
+++ b/recipes-ids/crowdsec/crowdsec-licenses.inc
@@ -7,62 +7,60 @@
 LICENSE += "& Apache-2.0 & BSD-2-Clause & BSD-3-Clause & ISC & MIT & MPL-2.0 & WTFPL"
 
 LIC_FILES_CHKSUM += "\
-    file://pkg/mod/ariga.io/atlas@v0.31.1-0.20250212144724-069be8033e83/LICENSE;md5=175792518e4ac015ab6696d16c4f607e;spdx=Apache-2.0 \
-    file://pkg/mod/entgo.io/ent@v0.14.2/LICENSE;md5=175792518e4ac015ab6696d16c4f607e;spdx=Apache-2.0 \
-    file://pkg/mod/filippo.io/edwards25519@v1.1.1/LICENSE;md5=5d4950ecb7b26d2c5e4e7b4e0dd74707;spdx=BSD-3-Clause \
+    file://pkg/mod/ariga.io/atlas@v1.1.0/LICENSE;md5=175792518e4ac015ab6696d16c4f607e;spdx=Apache-2.0 \
+    file://pkg/mod/dario.cat/mergo@v1.0.2/LICENSE;md5=ff13e03bb57bf9c52645f2f942afa28b;spdx=BSD-3-Clause \
+    file://pkg/mod/entgo.io/ent@v0.14.6/LICENSE;md5=175792518e4ac015ab6696d16c4f607e;spdx=Apache-2.0 \
+    file://pkg/mod/filippo.io/edwards25519@v1.2.0/LICENSE;md5=5d4950ecb7b26d2c5e4e7b4e0dd74707;spdx=BSD-3-Clause \
     file://pkg/mod/github.com/!alec!aivazis/survey/v2@v2.3.7/LICENSE;md5=615828847c7140c5e6bac90e11888eb5;spdx=MIT \
     file://pkg/mod/github.com/!alec!aivazis/survey/v2@v2.3.7/terminal/LICENSE.txt;md5=5cdf1025c7ad0102cd31c5d517307e8d;spdx=MIT \
     file://pkg/mod/github.com/!masterminds/goutils@v1.1.1/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/!masterminds/semver/v3@v3.2.1/LICENSE.txt;md5=4c1ffeeb02e3f8f4af042205e189b3f7;spdx=MIT \
-    file://pkg/mod/github.com/!masterminds/sprig/v3@v3.2.3/LICENSE.txt;md5=4ed8d725bea5f035fcea1ab05a767f78;spdx=MIT \
+    file://pkg/mod/github.com/!masterminds/semver/v3@v3.5.0/LICENSE.txt;md5=4c1ffeeb02e3f8f4af042205e189b3f7;spdx=MIT \
+    file://pkg/mod/github.com/!masterminds/sprig/v3@v3.3.0/LICENSE.txt;md5=4ed8d725bea5f035fcea1ab05a767f78;spdx=MIT \
     file://pkg/mod/github.com/agext/levenshtein@v1.2.3/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
     file://pkg/mod/github.com/alexliesenfeld/health@v0.8.1/LICENSE;md5=77aecb31b0bf38e6c2c292463604c338;spdx=MIT \
-    file://pkg/mod/github.com/apparentlymart/go-textseg/v13@v13.0.0/LICENSE;beginline=1;endline=19;md5=d57e691f661895b6e63c173405869a37;spdx=MIT \
-    file://pkg/mod/github.com/apparentlymart/go-textseg/v13@v13.0.0/LICENSE;beginline=25;endline=34;md5=c37d99507ac95d0eace7ccc51bf683f2;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/apparentlymart/go-textseg/v13@v13.0.0/LICENSE;beginline=65;md5=aed6f1c844d036b1ec630879c0856cf0;spdx=MIT \
     file://pkg/mod/github.com/apparentlymart/go-textseg/v15@v15.0.0/LICENSE;beginline=1;endline=19;md5=d57e691f661895b6e63c173405869a37;spdx=MIT \
     file://pkg/mod/github.com/apparentlymart/go-textseg/v15@v15.0.0/LICENSE;beginline=25;endline=34;md5=c37d99507ac95d0eace7ccc51bf683f2;spdx=Apache-2.0 \
     file://pkg/mod/github.com/apparentlymart/go-textseg/v15@v15.0.0/LICENSE;beginline=65;md5=aed6f1c844d036b1ec630879c0856cf0;spdx=MIT \
     file://pkg/mod/github.com/appleboy/gin-jwt/v2@v2.10.3/LICENSE;md5=c4620316ae1fb3b746e5cee94986dfd2;spdx=MIT \
-    file://pkg/mod/github.com/asaskevich/govalidator@v0.0.0-20230301143203-a9d515a09cc2/LICENSE;md5=44f42f71b1145516f11eb20da85d7344;spdx=MIT \
-    file://pkg/mod/github.com/aws/aws-lambda-go@v1.47.0/LICENSE;md5=b1e01b26bacfc2232046c90a330332b3;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/aws/protocol/eventstream@v1.7.1/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/config@v1.31.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/credentials@v1.18.10/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/feature/ec2/imds@v1.18.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/feature/s3/manager@v1.19.4/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/internal/configsources@v1.4.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/internal/endpoints/v2@v2.7.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/internal/ini@v1.8.3/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/internal/v4a@v1.4.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/cloudwatchlogs@v1.57.2/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding@v1.13.1/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/internal/checksum@v1.8.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/internal/presigned-url@v1.13.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/internal/s3shared@v1.19.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/kinesis@v1.40.1/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/s3@v1.87.3/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/sqs@v1.42.3/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/sso@v1.29.1/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/ssooidc@v1.34.2/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/sts@v1.38.2/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2@v1.38.3/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2@v1.38.3/internal/sync/singleflight/LICENSE;md5=bdc234595bc2fe370918f5de5077c8e9;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/aws/smithy-go@v1.23.0/LICENSE;md5=34400b68072d710fecd0a2940a0d1658;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/smithy-go@v1.23.0/internal/sync/singleflight/LICENSE;md5=bdc234595bc2fe370918f5de5077c8e9;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/beevik/etree@v1.4.1/LICENSE;md5=5220faf6133cbaef3cb62eee4bc0e09e;spdx=BSD-2-Clause \
+    file://pkg/mod/github.com/aws/aws-lambda-go@v1.54.0/LICENSE;md5=b1e01b26bacfc2232046c90a330332b3;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/aws/protocol/eventstream@v1.7.18/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/config@v1.32.37/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/credentials@v1.19.36/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/feature/ec2/imds@v1.18.37/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/feature/s3/manager@v1.22.43/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/internal/configsources@v1.4.37/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/internal/endpoints/v2@v2.7.37/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/internal/v4a@v1.4.38/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/cloudwatchlogs@v1.82.2/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding@v1.13.17/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/internal/checksum@v1.9.30/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/internal/presigned-url@v1.13.37/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/internal/s3shared@v1.19.38/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/kinesis@v1.46.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/s3@v1.107.2/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/signin@v1.5.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/sqs@v1.46.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/sso@v1.33.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/ssooidc@v1.38.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/sts@v1.45.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2@v1.43.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2@v1.43.6/internal/sync/singleflight/LICENSE;md5=bdc234595bc2fe370918f5de5077c8e9;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/aws/smithy-go@v1.27.8/LICENSE;md5=34400b68072d710fecd0a2940a0d1658;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/smithy-go@v1.27.8/internal/sync/singleflight/LICENSE;md5=bdc234595bc2fe370918f5de5077c8e9;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/beevik/etree@v1.7.1/LICENSE;md5=5220faf6133cbaef3cb62eee4bc0e09e;spdx=BSD-2-Clause \
     file://pkg/mod/github.com/beorn7/perks@v1.0.1/LICENSE;md5=0d0738f37ee8dc0b5f88a32e83c60198;spdx=MIT \
     file://pkg/mod/github.com/bluele/gcache@v0.0.2/LICENSE;md5=f16f1a674492e15d2ad50ab1acc0ba7a;spdx=MIT \
     file://pkg/mod/github.com/bmatcuk/doublestar@v1.3.4/LICENSE;md5=2a0ed06d3f9d0a3be066dc72088ae2ed;spdx=MIT \
-    file://pkg/mod/github.com/buger/jsonparser@v1.1.2/LICENSE;md5=b60ae568cc483bde7743064a52388501;spdx=MIT \
+    file://pkg/mod/github.com/buger/jsonparser@v1.6.1/LICENSE;md5=b60ae568cc483bde7743064a52388501;spdx=MIT \
     file://pkg/mod/github.com/cenkalti/backoff/v5@v5.0.3/LICENSE;md5=1571d94433e3f3aa05267efd4dbea68b;spdx=MIT \
     file://pkg/mod/github.com/cespare/xxhash/v2@v2.3.0/LICENSE.txt;md5=802da049c92a99b4387d3f3d91b00fa9;spdx=MIT \
+    file://pkg/mod/github.com/clipperhouse/uax29/v2@v2.7.0/LICENSE;md5=39b00daa69674119df37aadf8ab34aeb;spdx=MIT \
     file://pkg/mod/github.com/containerd/errdefs/pkg@v0.3.0/LICENSE;md5=1269f40c0d099c21a871163984590d89;spdx=Apache-2.0 \
     file://pkg/mod/github.com/containerd/errdefs@v1.0.0/LICENSE;md5=1269f40c0d099c21a871163984590d89;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/corazawaf/libinjection-go@v0.2.2/LICENSE;md5=8d2cfb1b0d35fea175f7d3f201dec57e;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/coreos/go-systemd/v22@v22.5.0/LICENSE;md5=19cbd64715b51267a47bf3750cc6a8a5;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/cpuguy83/go-md2man/v2@v2.0.6/LICENSE.md;md5=80794f9009df723bbc6fe19234c9f517;spdx=MIT \
-    file://pkg/mod/github.com/crowdsecurity/coraza/v3@v3.3.3-crowdsec.20251113/LICENSE;md5=c7d40d02b84931ff4d1b0d0242868943;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/corazawaf/libinjection-go@v0.3.2/LICENSE;md5=8d2cfb1b0d35fea175f7d3f201dec57e;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/coreos/go-systemd/v22@v22.7.0/LICENSE;md5=19cbd64715b51267a47bf3750cc6a8a5;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/cpuguy83/go-md2man/v2@v2.0.7/LICENSE.md;md5=80794f9009df723bbc6fe19234c9f517;spdx=MIT \
+    file://pkg/mod/github.com/crowdsecurity/coraza/v3@v3.7.0-crowdsec.20260730/LICENSE;md5=c7d40d02b84931ff4d1b0d0242868943;spdx=Apache-2.0 \
     file://pkg/mod/github.com/crowdsecurity/dlog@v0.0.2/LICENSE;md5=5371b61f7962ad1b1222e74e7f06c138;spdx=Apache-2.0 \
     file://pkg/mod/github.com/crowdsecurity/go-cs-lib@v0.0.25/LICENSE;md5=1e58fe4126ce0b50677f3aa6ba8e13c2;spdx=MIT \
     file://pkg/mod/github.com/crowdsecurity/grokky@v0.2.2/LICENSE;md5=6c80118ac2c1c95b011c5040454d0af9;spdx=WTFPL \
@@ -70,170 +68,195 @@ LIC_FILES_CHKSUM += "\
     file://pkg/mod/github.com/crowdsecurity/time@v0.13.0-crowdsec.20250912/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
     file://pkg/mod/github.com/davecgh/go-spew@v1.1.2-0.20180830191138-d8f796af33cc/LICENSE;md5=c06795ed54b2a35ebeeb543cd3a73e56;spdx=ISC \
     file://pkg/mod/github.com/distribution/reference@v0.6.0/LICENSE;md5=d2794c0df5b907fdace235a619d80314;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/docker/go-connections@v0.6.0/LICENSE;md5=04424bc6f5a5be60691b9824d65c2ad8;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/docker/go-connections@v0.7.0/LICENSE;md5=04424bc6f5a5be60691b9824d65c2ad8;spdx=Apache-2.0 \
     file://pkg/mod/github.com/docker/go-units@v0.5.0/LICENSE;md5=04424bc6f5a5be60691b9824d65c2ad8;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/expr-lang/expr@v1.17.7/LICENSE;md5=1cad8446548a7b361129ccfca629db1a;spdx=MIT \
-    file://pkg/mod/github.com/fatih/color@v1.18.0/LICENSE.md;md5=316e6d590bdcde7993fb175662c0dd5a;spdx=MIT \
+    file://pkg/mod/github.com/emicklei/go-restful/v3@v3.13.0/LICENSE;md5=2ebc1c12a0f4eae5394522e31961e1de;spdx=MIT \
+    file://pkg/mod/github.com/evanw/esbuild@v0.28.2/LICENSE.md;md5=46b907b175628fe6d2a5258b252970fa;spdx=MIT \
+    file://pkg/mod/github.com/evanw/esbuild@v0.28.2/internal/xxhash/LICENSE.txt;md5=802da049c92a99b4387d3f3d91b00fa9;spdx=MIT \
+    file://pkg/mod/github.com/expr-lang/expr@v1.17.8/LICENSE;md5=1cad8446548a7b361129ccfca629db1a;spdx=MIT \
+    file://pkg/mod/github.com/fatih/color@v1.19.0/LICENSE.md;md5=316e6d590bdcde7993fb175662c0dd5a;spdx=MIT \
     file://pkg/mod/github.com/felixge/httpsnoop@v1.0.4/LICENSE.txt;md5=684da2bf3eed8fc8860e75ad84638225;spdx=MIT \
-    file://pkg/mod/github.com/fsnotify/fsnotify@v1.9.0/LICENSE;md5=8bae8b116e2cfd723492b02d9a212fe2;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/gabriel-vasile/mimetype@v1.4.8/LICENSE;md5=df3ca1fbe5632f81387306d9558a61c4;spdx=MIT \
+    file://pkg/mod/github.com/fsnotify/fsnotify@v1.10.1/LICENSE;md5=8bae8b116e2cfd723492b02d9a212fe2;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/fxamacker/cbor/v2@v2.9.1/LICENSE;md5=827f5a2fa861382d35a3943adf9ebb86;spdx=MIT \
+    file://pkg/mod/github.com/gabriel-vasile/mimetype@v1.4.13/LICENSE;md5=df3ca1fbe5632f81387306d9558a61c4;spdx=MIT \
+    file://pkg/mod/github.com/getkin/kin-openapi@v0.147.0/LICENSE;md5=cc9b47b0408dc7dc785675c4e1566da6;spdx=MIT \
     file://pkg/mod/github.com/gin-contrib/gzip@v1.2.3/LICENSE;md5=b4a9ad063c97e6fe4a23e1b81f761e60;spdx=MIT \
-    file://pkg/mod/github.com/gin-contrib/sse@v1.0.0/LICENSE;md5=2e674b99ec94fcbd735f85c03ab8d74f;spdx=MIT \
-    file://pkg/mod/github.com/gin-gonic/gin@v1.10.0/LICENSE;md5=2e674b99ec94fcbd735f85c03ab8d74f;spdx=MIT \
-    file://pkg/mod/github.com/go-co-op/gocron/v2@v2.19.1/LICENSE;md5=90ff3cc9ad9aa451d5b5a4e470cec69d;spdx=MIT \
+    file://pkg/mod/github.com/gin-contrib/sse@v1.1.1/LICENSE;md5=2e674b99ec94fcbd735f85c03ab8d74f;spdx=MIT \
+    file://pkg/mod/github.com/gin-gonic/gin@v1.11.0/LICENSE;md5=2e674b99ec94fcbd735f85c03ab8d74f;spdx=MIT \
+    file://pkg/mod/github.com/go-co-op/gocron/v2@v2.22.0/LICENSE;md5=90ff3cc9ad9aa451d5b5a4e470cec69d;spdx=MIT \
+    file://pkg/mod/github.com/go-json-experiment/json@v0.0.0-20260214004413-d219187c3433/LICENSE;md5=9d210c7471ce08e3db5261f33bf8fce6;spdx=BSD-3-Clause \
     file://pkg/mod/github.com/go-logr/logr@v1.4.3/LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e;spdx=Apache-2.0 \
     file://pkg/mod/github.com/go-logr/stdr@v1.2.2/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/analysis@v0.23.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/errors@v0.22.2/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/inflect@v0.19.0/LICENCE;md5=c522af998c3755d0e857ca6e57d85cdc;spdx=MIT \
-    file://pkg/mod/github.com/go-openapi/jsonpointer@v0.21.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/jsonreference@v0.21.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/loads@v0.22.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/spec@v0.21.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/strfmt@v0.23.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/swag@v0.23.1/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/validate@v0.24.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/analysis@v0.26.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/errors@v0.22.8/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/inflect@v0.21.5/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/jsonpointer@v1.0.0/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/jsonreference@v1.0.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/loads@v0.25.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/spec@v0.22.9/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/strfmt@v0.27.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/cmdutils@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/conv@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/fileutils@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/jsonutils@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/loading@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/mangling@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/netutils@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/pools@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/stringutils@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/typeutils@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/yamlutils@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/validate@v0.26.3/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
     file://pkg/mod/github.com/go-playground/locales@v0.14.1/LICENSE;md5=3ccbda375ee345400ad1da85ba522301;spdx=MIT \
     file://pkg/mod/github.com/go-playground/universal-translator@v0.18.1/LICENSE;md5=2e2b21ef8f61057977d27c727c84bef1;spdx=MIT \
-    file://pkg/mod/github.com/go-playground/validator/v10@v10.26.0/LICENSE;md5=a718a0f318d76f7c5d510cbae84f0b60;spdx=MIT \
-    file://pkg/mod/github.com/go-sql-driver/mysql@v1.9.3/LICENSE;md5=815ca599c9df247a0c7f619bab123dad;spdx=MPL-2.0 \
-    file://pkg/mod/github.com/goccy/go-json@v0.10.5/LICENSE;md5=33a07164132d795872805bfc53f6097d;spdx=MIT \
-    file://pkg/mod/github.com/goccy/go-yaml@v1.18.0/LICENSE;md5=346470d8ac0a6ffe1eb8635a452cec2b;spdx=MIT \
-    file://pkg/mod/github.com/gogo/protobuf@v1.3.2/LICENSE;md5=38be95f95200434dc208e2ee3dab5081;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/go-playground/validator/v10@v10.30.2/LICENSE;md5=a718a0f318d76f7c5d510cbae84f0b60;spdx=MIT \
+    file://pkg/mod/github.com/go-sql-driver/mysql@v1.10.0/LICENSE;md5=815ca599c9df247a0c7f619bab123dad;spdx=MPL-2.0 \
+    file://pkg/mod/github.com/go-viper/mapstructure/v2@v2.5.0/LICENSE;md5=3f7765c3d4f58e1f84c4313cecf0f5bd;spdx=MIT \
+    file://pkg/mod/github.com/goccy/go-yaml@v1.19.2/LICENSE;md5=346470d8ac0a6ffe1eb8635a452cec2b;spdx=MIT \
     file://pkg/mod/github.com/golang/protobuf@v1.5.4/LICENSE;md5=939cce1ec101726fa754e698ac871622;spdx=BSD-3-Clause \
     file://pkg/mod/github.com/golang-jwt/jwt/v4@v4.5.2/LICENSE;md5=a21b708d8b320c68979c44ac9dba9b0d;spdx=MIT \
+    file://pkg/mod/github.com/google/gnostic-models@v0.7.0/LICENSE;md5=b1e01b26bacfc2232046c90a330332b3;spdx=Apache-2.0 \
     file://pkg/mod/github.com/google/go-cmp@v0.7.0/LICENSE;md5=4ac66f7dea41d8d116cb7fb28aeff2ab;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/google/go-querystring@v1.1.0/LICENSE;md5=29f156828ca5f2df0d1c12543a75f12a;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/google/gofuzz@v1.2.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/google/go-querystring@v1.2.0/LICENSE;md5=29f156828ca5f2df0d1c12543a75f12a;spdx=BSD-3-Clause \
     file://pkg/mod/github.com/google/uuid@v1.6.0/LICENSE;md5=88073b6dd8ec00fe09da59e0b6dfded1;spdx=BSD-3-Clause \
     file://pkg/mod/github.com/goombaio/namegenerator@v0.0.0-20181006234301-989e774b106e/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/gorilla/websocket@v1.5.0/LICENSE;md5=c007b54a1743d596f46b2748d9f8c044;spdx=BSD-2-Clause \
-    file://pkg/mod/github.com/gotnospirit/makeplural@v0.0.0-20180622080156-a5f48d94d976/LICENSE;md5=600ac2feda8347557a72c59b52ff302b;spdx=BSD-2-Clause \
-    file://pkg/mod/github.com/gotnospirit/messageformat@v0.0.0-20221001023931-dfe49f1eb092/LICENSE;md5=600ac2feda8347557a72c59b52ff302b;spdx=BSD-2-Clause \
-    file://pkg/mod/github.com/hashicorp/go-hclog@v1.5.0/LICENSE;md5=08d72ffda4fb40269260bfa13423c5be;spdx=MIT \
-    file://pkg/mod/github.com/hashicorp/go-plugin@v1.6.3/LICENSE;md5=385ead67d9cf89227f52640ad36b20a6;spdx=MPL-2.0 \
-    file://pkg/mod/github.com/hashicorp/go-version@v1.7.0/LICENSE;md5=81eb103d8076ec72ebe52e3ee40176db;spdx=MPL-2.0 \
-    file://pkg/mod/github.com/hashicorp/hcl/v2@v2.13.0/LICENSE;md5=d44fdeb607e2d2614db9464dbedd4094;spdx=MPL-2.0 \
-    file://pkg/mod/github.com/hashicorp/yamux@v0.1.1/LICENSE;md5=2dd1a9ecf92cd5617f128808f9b85b44;spdx=MPL-2.0 \
+    file://pkg/mod/github.com/gorilla/websocket@v1.5.4-0.20250319132907-e064f32e3674/LICENSE;md5=c007b54a1743d596f46b2748d9f8c044;spdx=BSD-2-Clause \
+    file://pkg/mod/github.com/hashicorp/go-hclog@v1.6.3/LICENSE;md5=08d72ffda4fb40269260bfa13423c5be;spdx=MIT \
+    file://pkg/mod/github.com/hashicorp/go-plugin@v1.8.0/LICENSE;md5=8e52337969808a9f2285f3ba453f5225;spdx=MPL-2.0 \
+    file://pkg/mod/github.com/hashicorp/go-version@v1.9.0/LICENSE;md5=cad2f12165769bbebe1d9235ea7dfbd6;spdx=MPL-2.0 \
+    file://pkg/mod/github.com/hashicorp/hcl/v2@v2.24.0/LICENSE;md5=b1c7d811d58ca6da0bffe95cffc4d43f;spdx=MPL-2.0 \
+    file://pkg/mod/github.com/hashicorp/yamux@v0.1.2/LICENSE;md5=4fb1de3449662e9252530414c87ed011;spdx=MPL-2.0 \
     file://pkg/mod/github.com/hexops/gotextdiff@v1.0.3/LICENSE;md5=5d4950ecb7b26d2c5e4e7b4e0dd74707;spdx=BSD-3-Clause \
     file://pkg/mod/github.com/huandu/xstrings@v1.5.0/LICENSE;md5=0a9edd7ffc0f2c020fe849875cb6810d;spdx=MIT \
-    file://pkg/mod/github.com/imdario/mergo@v0.3.11/LICENSE;md5=ff13e03bb57bf9c52645f2f942afa28b;spdx=BSD-3-Clause \
     file://pkg/mod/github.com/ivanpirog/coloredcobra@v1.0.1/LICENSE;md5=536471af1aa0a9e6b6b80f8d0734024e;spdx=MIT \
     file://pkg/mod/github.com/jackc/chunkreader/v2@v2.0.1/LICENSE;md5=ea2961e52eec5b1203f8147a49ef985f;spdx=MIT \
     file://pkg/mod/github.com/jackc/pgconn@v1.14.3/LICENSE;md5=d554a30973e07a28d3c1eabfaf7d2a2a;spdx=MIT \
     file://pkg/mod/github.com/jackc/pgio@v1.0.0/LICENSE;md5=ea2961e52eec5b1203f8147a49ef985f;spdx=MIT \
     file://pkg/mod/github.com/jackc/pgpassfile@v1.0.0/LICENSE;md5=ea2961e52eec5b1203f8147a49ef985f;spdx=MIT \
     file://pkg/mod/github.com/jackc/pgproto3/v2@v2.3.3/LICENSE;md5=ea2961e52eec5b1203f8147a49ef985f;spdx=MIT \
-    file://pkg/mod/github.com/jackc/pgservicefile@v0.0.0-20221227161230-091c0ba34f0a/LICENSE;md5=209ee38a480b3726bf58105857868aa4;spdx=MIT \
-    file://pkg/mod/github.com/jackc/pgtype@v1.14.0/LICENSE;md5=6d996fb721b0bbe83ef9c55fee3f0c97;spdx=MIT \
-    file://pkg/mod/github.com/jackc/pgx/v4@v4.18.2/LICENSE;md5=6d996fb721b0bbe83ef9c55fee3f0c97;spdx=MIT \
-    file://pkg/mod/github.com/jedib0t/go-pretty/v6@v6.6.7/LICENSE;md5=dfa583903393a7d3fef6168e278a58ba;spdx=MIT \
+    file://pkg/mod/github.com/jackc/pgservicefile@v0.0.0-20240606120523-5a60cdf6a761/LICENSE;md5=209ee38a480b3726bf58105857868aa4;spdx=MIT \
+    file://pkg/mod/github.com/jackc/pgtype@v1.14.4/LICENSE;md5=6d996fb721b0bbe83ef9c55fee3f0c97;spdx=MIT \
+    file://pkg/mod/github.com/jackc/pgx/v4@v4.18.3/LICENSE;md5=6d996fb721b0bbe83ef9c55fee3f0c97;spdx=MIT \
+    file://pkg/mod/github.com/jedib0t/go-pretty/v6@v6.8.3/LICENSE;md5=dfa583903393a7d3fef6168e278a58ba;spdx=MIT \
     file://pkg/mod/github.com/jonboulle/clockwork@v0.5.0/LICENSE;md5=136e4f49dbf29942c572a3a8f6e88a77;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/josharian/intern@v1.0.0/license.md;md5=6bc75378a26e0addbcdfa118e4d54574;spdx=MIT \
     file://pkg/mod/github.com/json-iterator/go@v1.1.12/LICENSE;md5=0b69744b481d72d30dbf69f84a451cfd;spdx=MIT \
-    file://pkg/mod/github.com/jszwec/csvutil@v1.5.1/LICENSE;md5=404c6dd3f100debdaaf2bdd343cbd034;spdx=MIT \
-    file://pkg/mod/github.com/kaptinlin/go-i18n@v0.1.4/LICENSE;md5=9f19607b8eeb65eab2627e488215d4bd;spdx=MIT \
-    file://pkg/mod/github.com/kaptinlin/jsonschema@v0.4.6/LICENSE;md5=35f406ad10530cf65e9f367edf5b1b88;spdx=MIT \
+    file://pkg/mod/github.com/jszwec/csvutil@v1.10.0/LICENSE;md5=404c6dd3f100debdaaf2bdd343cbd034;spdx=MIT \
+    file://pkg/mod/github.com/kaptinlin/go-i18n@v0.3.1/LICENSE;md5=ac29f424978421d3e8f6144db1d741dc;spdx=MIT \
+    file://pkg/mod/github.com/kaptinlin/jsonpointer@v0.4.17/LICENSE;md5=e3b2d8cc7672cf690c51b9d067795763;spdx=MIT \
+    file://pkg/mod/github.com/kaptinlin/jsonschema@v0.7.7/LICENSE;md5=e3b2d8cc7672cf690c51b9d067795763;spdx=MIT \
+    file://pkg/mod/github.com/kaptinlin/messageformat-go@v0.4.19/LICENSE;md5=3261cc78e02c58c0eed7ae2ed7a8bdc9;spdx=MIT \
     file://pkg/mod/github.com/kballard/go-shellquote@v0.0.0-20180428030007-95032a82bc51/LICENSE;md5=9d95d1ad917c814c23909addb8692eeb;spdx=MIT \
-    file://pkg/mod/github.com/klauspost/compress@v1.18.0/LICENSE;md5=d0fd9ebda39468b51ff4539c9fbb13a8;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/klauspost/compress@v1.18.0/internal/snapref/LICENSE;md5=b8b79c7d4cda128290b98c6a21f9aac6;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/klauspost/compress@v1.18.0/s2/LICENSE;md5=2460814a2b25a7277556c2d89de915d1;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/klauspost/compress@v1.18.0/snappy/LICENSE;md5=b8b79c7d4cda128290b98c6a21f9aac6;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/klauspost/compress@v1.18.0/zstd/internal/xxhash/LICENSE.txt;md5=802da049c92a99b4387d3f3d91b00fa9;spdx=MIT \
+    file://pkg/mod/github.com/klauspost/compress@v1.19.1/LICENSE;md5=d0fd9ebda39468b51ff4539c9fbb13a8;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/klauspost/compress@v1.19.1/internal/snapref/LICENSE;md5=b8b79c7d4cda128290b98c6a21f9aac6;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/klauspost/compress@v1.19.1/s2/LICENSE;md5=2460814a2b25a7277556c2d89de915d1;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/klauspost/compress@v1.19.1/snappy/LICENSE;md5=b8b79c7d4cda128290b98c6a21f9aac6;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/klauspost/compress@v1.19.1/zstd/internal/xxhash/LICENSE.txt;md5=802da049c92a99b4387d3f3d91b00fa9;spdx=MIT \
     file://pkg/mod/github.com/leodido/go-urn@v1.4.0/LICENSE;md5=8f50db5538ec1148a9b3d14ed96c3418;spdx=MIT \
-    file://pkg/mod/github.com/mailru/easyjson@v0.9.0/LICENSE;md5=819e81c2ec13e1bbc47dc5e90bb4d88b;spdx=MIT \
-    file://pkg/mod/github.com/mattn/go-colorable@v0.1.13/LICENSE;md5=24ce168f90aec2456a73de1839037245;spdx=MIT \
-    file://pkg/mod/github.com/mattn/go-isatty@v0.0.20/LICENSE;md5=f509beadd5a11227c27b5d2ad6c9f2c6;spdx=MIT \
-    file://pkg/mod/github.com/mattn/go-runewidth@v0.0.16/LICENSE;md5=24ce168f90aec2456a73de1839037245;spdx=MIT \
-    file://pkg/mod/github.com/mattn/go-sqlite3@v1.14.24/LICENSE;md5=2b7590a6661bc1940f50329c495898c6;spdx=MIT \
+    file://pkg/mod/github.com/mattn/go-colorable@v0.1.14/LICENSE;md5=24ce168f90aec2456a73de1839037245;spdx=MIT \
+    file://pkg/mod/github.com/mattn/go-isatty@v0.0.24/LICENSE;md5=f509beadd5a11227c27b5d2ad6c9f2c6;spdx=MIT \
+    file://pkg/mod/github.com/mattn/go-runewidth@v0.0.22/LICENSE;md5=24ce168f90aec2456a73de1839037245;spdx=MIT \
+    file://pkg/mod/github.com/mattn/go-sqlite3@v1.14.32/LICENSE;md5=2b7590a6661bc1940f50329c495898c6;spdx=MIT \
     file://pkg/mod/github.com/mgutz/ansi@v0.0.0-20200706080929-d51e80ef957d/LICENSE;md5=69548df4465c22180e0382cdb58c9379;spdx=MIT \
     file://pkg/mod/github.com/mitchellh/copystructure@v1.2.0/LICENSE;md5=56da355a12d4821cda57b8f23ec34bc4;spdx=MIT \
     file://pkg/mod/github.com/mitchellh/go-wordwrap@v1.0.1/LICENSE.md;md5=56da355a12d4821cda57b8f23ec34bc4;spdx=MIT \
-    file://pkg/mod/github.com/mitchellh/mapstructure@v1.5.0/LICENSE;md5=3f7765c3d4f58e1f84c4313cecf0f5bd;spdx=MIT \
     file://pkg/mod/github.com/mitchellh/reflectwalk@v1.0.2/LICENSE;md5=3f7765c3d4f58e1f84c4313cecf0f5bd;spdx=MIT \
     file://pkg/mod/github.com/moby/docker-image-spec@v1.3.1/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/moby/moby/api@v1.52.1-0.20251116162601-e9ff10bf365a/LICENSE;md5=4859e97a9c7780e77972d989f0823f28;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/moby/moby/client@v0.1.1-0.20251116162601-e9ff10bf365a/LICENSE;md5=4859e97a9c7780e77972d989f0823f28;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/moby/moby/api@v1.55.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/moby/moby/client@v0.5.1/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
     file://pkg/mod/github.com/modern-go/concurrent@v0.0.0-20180306012644-bacd9c7ef1dd/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/modern-go/reflect2@v1.0.2/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/modern-go/reflect2@v1.0.3-0.20250322232337-35a7c28c31ee/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
     file://pkg/mod/github.com/mohae/deepcopy@v0.0.0-20170929034955-c48cc78d4826/LICENSE;md5=268dc9c546e3de67a93c1d12a039d702;spdx=MIT \
     file://pkg/mod/github.com/munnerz/goautoneg@v0.0.0-20191010083416-a7dc8b61c822/LICENSE;md5=0c241922fc69330e2e5590de114f3bf5;spdx=BSD-3-Clause \
     file://pkg/mod/github.com/nxadm/tail@v1.4.11/LICENSE;md5=0bdce43b16cd5c587124d6f274632c87;spdx=MIT \
-    file://pkg/mod/github.com/oklog/run@v1.0.0/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/oklog/ulid@v1.3.1/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/oasdiff/yaml3@v0.0.14/LICENSE;md5=3c91c17266710e16afdbb2b6d15c761c;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/oasdiff/yaml@v0.1.1/LICENSE;md5=0ceb9ff3b27d3a8cf451ca3785d73c71;spdx=MIT \
+    file://pkg/mod/github.com/oklog/run@v1.2.0/LICENSE;md5=c19dbea2f4885137f8d45fede9891755;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/oklog/ulid/v2@v2.1.1/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
     file://pkg/mod/github.com/opencontainers/go-digest@v1.0.0/LICENSE;md5=2d6fc0e85c3f118af64c85a78d56d3cf;spdx=Apache-2.0 \
     file://pkg/mod/github.com/opencontainers/image-spec@v1.1.1/LICENSE;md5=27ef03aa2da6e424307f102e8b42621d;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/oschwald/geoip2-golang@v1.9.0/LICENSE;md5=7ff10cf9f9802aa6a69c6a73d03742c4;spdx=ISC \
-    file://pkg/mod/github.com/oschwald/maxminddb-golang@v1.12.0/LICENSE;md5=7ff10cf9f9802aa6a69c6a73d03742c4;spdx=ISC \
-    file://pkg/mod/github.com/pelletier/go-toml/v2@v2.2.4/LICENSE;md5=390892c6562af0d807e527b06d635f94;spdx=MIT \
+    file://pkg/mod/github.com/oschwald/geoip2-golang@v1.13.0/LICENSE;md5=7ff10cf9f9802aa6a69c6a73d03742c4;spdx=ISC \
+    file://pkg/mod/github.com/oschwald/maxminddb-golang@v1.13.1/LICENSE;md5=7ff10cf9f9802aa6a69c6a73d03742c4;spdx=ISC \
+    file://pkg/mod/github.com/pelletier/go-toml/v2@v2.3.0/LICENSE;md5=390892c6562af0d807e527b06d635f94;spdx=MIT \
     file://pkg/mod/github.com/petar-dambovaliev/aho-corasick@v0.0.0-20250424160509-463d218d4745/LICENSE;md5=79da2eab36bdb4ea5e3b7ef4e5d19825;spdx=MIT \
-    file://pkg/mod/github.com/pierrec/lz4/v4@v4.1.18/LICENSE;md5=09ece85f3c312a63b522bfc6ebd44943;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/prometheus/client_golang@v1.23.2/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/prometheus/client_golang@v1.23.2/internal/github.com/golang/gddo/LICENSE;md5=4c728948788b1a02f33ae4e906546eef;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/pierrec/lz4/v4@v4.1.26/LICENSE;md5=09ece85f3c312a63b522bfc6ebd44943;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/pmezard/go-difflib@v1.0.1-0.20181226105442-5d4384ee4fb2/LICENSE;md5=e9a2ebb8de779a07500ddecca806145e;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/prometheus/client_golang@v1.24.1/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/prometheus/client_golang@v1.24.1/internal/github.com/golang/gddo/LICENSE;md5=4c728948788b1a02f33ae4e906546eef;spdx=BSD-3-Clause \
     file://pkg/mod/github.com/prometheus/client_model@v0.6.2/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/prometheus/common@v0.66.1/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/prometheus/procfs@v0.16.1/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/prometheus/common@v0.70.1/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/prometheus/procfs@v0.21.1/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/quic-go/qpack@v0.6.0/LICENSE.md;md5=d670bcd1510d5f6c013032947d36132b;spdx=MIT \
+    file://pkg/mod/github.com/quic-go/quic-go@v0.59.1/LICENSE;md5=357080a3c7c0a7c4e23100893c301235;spdx=MIT \
     file://pkg/mod/github.com/r3labs/diff/v2@v2.15.1/LICENSE;md5=9741c346eef56131163e13b9db1241b3;spdx=MPL-2.0 \
-    file://pkg/mod/github.com/rivo/uniseg@v0.4.7/LICENSE.txt;md5=4393c339bf180cf6e188b6ea32d8b93c;spdx=MIT \
     file://pkg/mod/github.com/robfig/cron/v3@v3.0.1/LICENSE;md5=d924a63cb54a2a6c4bd28c50b2b0af59;spdx=MIT \
     file://pkg/mod/github.com/russross/blackfriday/v2@v2.1.0/LICENSE.txt;md5=ecf8a8a60560c35a862a4a545f2db1b3;spdx=BSD-2-Clause \
     file://pkg/mod/github.com/sanity-io/litter@v1.5.8/LICENSE;md5=a1cb9e8d77e4fbf4cf17a15a53cfb72b;spdx=MIT \
-    file://pkg/mod/github.com/segmentio/kafka-go@v0.4.48/LICENSE;md5=245177e51c68aa2071d537392357ab87;spdx=MIT \
-    file://pkg/mod/github.com/shirou/gopsutil/v4@v4.25.8/LICENSE;md5=ae6de3dee02712a1e55b280671be53bf;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/santhosh-tekuri/jsonschema/v6@v6.0.3/LICENSE;md5=3eb31626add6ada64ff9ac772bd3c653;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/segmentio/kafka-go@v0.4.51/LICENSE;md5=245177e51c68aa2071d537392357ab87;spdx=MIT \
+    file://pkg/mod/github.com/shirou/gopsutil/v4@v4.26.7/LICENSE;md5=ae6de3dee02712a1e55b280671be53bf;spdx=BSD-3-Clause \
     file://pkg/mod/github.com/shopspring/decimal@v1.4.0/LICENSE;md5=d21d25475326cf7f1b36eef8c9789801;spdx=MIT \
-    file://pkg/mod/github.com/sirupsen/logrus@v1.9.3/LICENSE;md5=8dadfef729c08ec4e631c4f6fc5d43a0;spdx=MIT \
-    file://pkg/mod/github.com/slack-go/slack@v0.16.0/LICENSE;md5=5be3e17d84b16d39bb01b55af9d8a913;spdx=BSD-2-Clause \
-    file://pkg/mod/github.com/spf13/cast@v1.7.0/LICENSE;md5=67fac7567cbf6ba946e5576d590b1ed4;spdx=MIT \
-    file://pkg/mod/github.com/spf13/cobra@v1.10.1/LICENSE.txt;md5=920d76114a32b0fb75b3f2718c5a91be;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/spf13/pflag@v1.0.9/LICENSE;md5=1e8b7dc8b906737639131047a590f21d;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/tetratelabs/wazero@v1.9.0/LICENSE;md5=a80aae5626b7e957ac00f5d22276ac9e;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/sirupsen/logrus@v1.10.0/LICENSE;md5=8dadfef729c08ec4e631c4f6fc5d43a0;spdx=MIT \
+    file://pkg/mod/github.com/slack-go/slack@v0.29.0/LICENSE;md5=5be3e17d84b16d39bb01b55af9d8a913;spdx=BSD-2-Clause \
+    file://pkg/mod/github.com/spf13/cast@v1.10.0/LICENSE;md5=67fac7567cbf6ba946e5576d590b1ed4;spdx=MIT \
+    file://pkg/mod/github.com/spf13/cobra@v1.10.2/LICENSE.txt;md5=920d76114a32b0fb75b3f2718c5a91be;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/spf13/pflag@v1.0.10/LICENSE;md5=1e8b7dc8b906737639131047a590f21d;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/tetratelabs/wazero@v1.12.0/LICENSE;md5=a80aae5626b7e957ac00f5d22276ac9e;spdx=Apache-2.0 \
     file://pkg/mod/github.com/tidwall/gjson@v1.18.0/LICENSE;md5=f1ccda76a282fada49760e27335f1c28;spdx=MIT \
-    file://pkg/mod/github.com/tidwall/match@v1.1.1/LICENSE;md5=f1ccda76a282fada49760e27335f1c28;spdx=MIT \
+    file://pkg/mod/github.com/tidwall/match@v1.2.0/LICENSE;md5=f1ccda76a282fada49760e27335f1c28;spdx=MIT \
     file://pkg/mod/github.com/tidwall/pretty@v1.2.1/LICENSE;md5=898bc94f87439245e8cf1c5797098e90;spdx=MIT \
-    file://pkg/mod/github.com/tklauser/go-sysconf@v0.3.15/LICENSE;md5=d4eb2084b3083d2c275ec52ef4ba9ac1;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/tklauser/numcpus@v0.10.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/toorop/go-dkim@v0.0.0-20201103131630-e1cd1a0a5208/LICENSE;md5=c1f71ecc29f9b25806e07f9f45ce9089;spdx=MIT \
-    file://pkg/mod/github.com/ugorji/go/codec@v1.2.12/LICENSE;md5=f39cb00aceeac4bc5f861dc07456d5d5;spdx=MIT \
+    file://pkg/mod/github.com/tklauser/go-sysconf@v0.3.16/LICENSE;md5=d4eb2084b3083d2c275ec52ef4ba9ac1;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/tklauser/numcpus@v0.11.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/toorop/go-dkim@v0.0.0-20250226130143-9025cce95817/LICENSE;md5=c1f71ecc29f9b25806e07f9f45ce9089;spdx=MIT \
+    file://pkg/mod/github.com/ugorji/go/codec@v1.3.1/LICENSE;md5=f39cb00aceeac4bc5f861dc07456d5d5;spdx=MIT \
     file://pkg/mod/github.com/umahmood/haversine@v0.0.0-20151105152445-808ab04add26/LICENSE.md;md5=878ae7dec555c1bf7626a69eaa5eeed1;spdx=MIT \
     file://pkg/mod/github.com/valllabh/ocsf-schema-golang@v1.0.3/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
     file://pkg/mod/github.com/vmihailenco/msgpack@v4.0.4+incompatible/LICENSE;md5=5de50b60705d666cd9542dd48d5e4b56;spdx=BSD-2-Clause \
-    file://pkg/mod/github.com/wasilibs/go-re2@v1.10.0/LICENSE;md5=7cce3e5a10534670a924d9206dd18716;spdx=MIT \
-    file://pkg/mod/github.com/wasilibs/wazero-helpers@v0.0.0-20250123031827-cd30c44769bb/LICENSE;md5=1408c2b96cd0e1bbe2c223ae9f71a6db;spdx=MIT \
+    file://pkg/mod/github.com/wasilibs/go-re2@v1.12.0/LICENSE;md5=7cce3e5a10534670a924d9206dd18716;spdx=MIT \
+    file://pkg/mod/github.com/x448/float16@v0.8.4/LICENSE;md5=de8f8e025d57fe7ee0b67f30d571323b;spdx=MIT \
     file://pkg/mod/github.com/xhit/go-simple-mail/v2@v2.16.0/LICENSE;md5=2f9ea4621bcff112a477b70f86730128;spdx=MIT \
     file://pkg/mod/github.com/youmark/pkcs8@v0.0.0-20240726163527-a2c0da244d78/LICENSE;md5=7e949f736d1222f15e83233702459f41;spdx=MIT \
-    file://pkg/mod/github.com/zclconf/go-cty-yaml@v1.1.0/LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/zclconf/go-cty@v1.14.4/LICENSE;md5=ab8202e057bc8a5fba04f82e264bf14d;spdx=MIT \
-    file://pkg/mod/go.mongodb.org/mongo-driver@v1.14.0/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/zclconf/go-cty-yaml@v1.2.0/LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/zclconf/go-cty@v1.18.0/LICENSE;md5=5fa044db97ab139f0b76ceeca0e5a3d5;spdx=MIT \
     file://pkg/mod/go.opentelemetry.io/auto/sdk@v1.2.1/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
-    file://pkg/mod/go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp@v0.60.0/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
-    file://pkg/mod/go.opentelemetry.io/otel/metric@v1.39.0/LICENSE;md5=24dad3abbe7a8f390afc8ab967bfefa7;spdx=Apache-2.0 \
-    file://pkg/mod/go.opentelemetry.io/otel/trace@v1.39.0/LICENSE;md5=24dad3abbe7a8f390afc8ab967bfefa7;spdx=Apache-2.0 \
-    file://pkg/mod/go.opentelemetry.io/otel@v1.39.0/LICENSE;md5=24dad3abbe7a8f390afc8ab967bfefa7;spdx=Apache-2.0 \
-    file://pkg/mod/go.yaml.in/yaml/v2@v2.4.2/LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e;spdx=Apache-2.0 \
-    file://pkg/mod/golang.org/x/crypto@v0.46.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
-    file://pkg/mod/golang.org/x/mod@v0.30.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
-    file://pkg/mod/golang.org/x/net@v0.48.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
-    file://pkg/mod/golang.org/x/sync@v0.19.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
-    file://pkg/mod/golang.org/x/sys@v0.39.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
-    file://pkg/mod/golang.org/x/term@v0.38.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
-    file://pkg/mod/golang.org/x/text@v0.32.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
-    file://pkg/mod/google.golang.org/genproto/googleapis/rpc@v0.0.0-20251202230838-ff82c1b0f217/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/google.golang.org/grpc@v1.79.3/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/google.golang.org/protobuf@v1.36.10/LICENSE;md5=02d4002e9171d41a8fad93aa7faf3956;spdx=BSD-3-Clause \
+    file://pkg/mod/go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp@v0.68.0/LICENSE;md5=24dad3abbe7a8f390afc8ab967bfefa7;spdx=Apache-2.0 \
+    file://pkg/mod/go.opentelemetry.io/otel/metric@v1.44.0/LICENSE;md5=24dad3abbe7a8f390afc8ab967bfefa7;spdx=Apache-2.0 \
+    file://pkg/mod/go.opentelemetry.io/otel/trace@v1.44.0/LICENSE;md5=24dad3abbe7a8f390afc8ab967bfefa7;spdx=Apache-2.0 \
+    file://pkg/mod/go.opentelemetry.io/otel@v1.44.0/LICENSE;md5=24dad3abbe7a8f390afc8ab967bfefa7;spdx=Apache-2.0 \
+    file://pkg/mod/go.yaml.in/yaml/v2@v2.4.4/LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e;spdx=Apache-2.0 \
+    file://pkg/mod/go.yaml.in/yaml/v3@v3.0.5/LICENSE;md5=3c91c17266710e16afdbb2b6d15c761c;spdx=Apache-2.0 \
+    file://pkg/mod/golang.org/x/crypto@v0.55.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
+    file://pkg/mod/golang.org/x/mod@v0.40.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
+    file://pkg/mod/golang.org/x/net@v0.58.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
+    file://pkg/mod/golang.org/x/oauth2@v0.36.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
+    file://pkg/mod/golang.org/x/sync@v0.22.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
+    file://pkg/mod/golang.org/x/sys@v0.47.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
+    file://pkg/mod/golang.org/x/term@v0.45.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
+    file://pkg/mod/golang.org/x/text@v0.41.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
+    file://pkg/mod/google.golang.org/genproto/googleapis/rpc@v0.0.0-20260526163538-3dc84a4a5aaa/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/google.golang.org/grpc@v1.83.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/google.golang.org/protobuf@v1.36.12/LICENSE;md5=02d4002e9171d41a8fad93aa7faf3956;spdx=BSD-3-Clause \
+    file://pkg/mod/gopkg.in/evanphx/json-patch.v4@v4.13.0/LICENSE;md5=96ae735ca1b4dcdb6b26f4ca4b8ba645;spdx=BSD-3-Clause \
     file://pkg/mod/gopkg.in/inf.v0@v0.9.1/LICENSE;md5=13cea479df204c85485b5db6eb1bc9d5;spdx=BSD-3-Clause \
     file://pkg/mod/gopkg.in/natefinch/lumberjack.v2@v2.2.1/LICENSE;md5=574cdb55b81249478f5af5f789e9e29f;spdx=MIT \
     file://pkg/mod/gopkg.in/tomb.v1@v1.0.0-20141024135613-dd632973f1e7/LICENSE;md5=95d4102f39f26da9b66fee5d05ac597b;spdx=BSD-3-Clause \
     file://pkg/mod/gopkg.in/tomb.v2@v2.0.0-20161208151619-d5d1b5820637/LICENSE;md5=95d4102f39f26da9b66fee5d05ac597b;spdx=BSD-3-Clause \
     file://pkg/mod/gopkg.in/yaml.v2@v2.4.0/LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e;spdx=Apache-2.0 \
     file://pkg/mod/gopkg.in/yaml.v3@v3.0.1/LICENSE;md5=3c91c17266710e16afdbb2b6d15c761c;spdx=Apache-2.0 \
-    file://pkg/mod/k8s.io/api@v0.28.4/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/k8s.io/apimachinery@v0.28.4/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/k8s.io/apimachinery@v0.28.4/third_party/forked/golang/LICENSE;md5=5d4950ecb7b26d2c5e4e7b4e0dd74707;spdx=BSD-3-Clause \
-    file://pkg/mod/k8s.io/apiserver@v0.28.4/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/k8s.io/klog/v2@v2.100.1/LICENSE;md5=19cbd64715b51267a47bf3750cc6a8a5;spdx=Apache-2.0 \
-    file://pkg/mod/k8s.io/utils@v0.0.0-20230406110748-d93618cff8a2/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/k8s.io/utils@v0.0.0-20230406110748-d93618cff8a2/internal/third_party/forked/golang/LICENSE;md5=591778525c869cdde0ab5a1bf283cd81;spdx=BSD-3-Clause \
+    file://pkg/mod/k8s.io/api@v0.36.3/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/k8s.io/apimachinery@v0.36.3/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/k8s.io/apimachinery@v0.36.3/third_party/forked/golang/LICENSE;md5=5d4950ecb7b26d2c5e4e7b4e0dd74707;spdx=BSD-3-Clause \
+    file://pkg/mod/k8s.io/apiserver@v0.36.3/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/k8s.io/client-go@v0.36.3/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/k8s.io/klog/v2@v2.140.0/LICENSE;md5=19cbd64715b51267a47bf3750cc6a8a5;spdx=Apache-2.0 \
+    file://pkg/mod/k8s.io/kube-openapi@v0.0.0-20260330154417-16be699c7b31/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/k8s.io/kube-openapi@v0.0.0-20260330154417-16be699c7b31/pkg/internal/third_party/go-json-experiment/json/LICENSE;md5=9d210c7471ce08e3db5261f33bf8fce6;spdx=BSD-3-Clause \
+    file://pkg/mod/k8s.io/kube-openapi@v0.0.0-20260330154417-16be699c7b31/pkg/validation/spec/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/k8s.io/utils@v0.0.0-20260319190234-28399d86e0b5/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/k8s.io/utils@v0.0.0-20260319190234-28399d86e0b5/internal/third_party/forked/golang/LICENSE;md5=591778525c869cdde0ab5a1bf283cd81;spdx=BSD-3-Clause \
     file://pkg/mod/rsc.io/binaryregexp@v0.2.0/LICENSE;md5=5d4950ecb7b26d2c5e4e7b4e0dd74707;spdx=BSD-3-Clause \
-    file://pkg/mod/sigs.k8s.io/json@v0.0.0-20221116044647-bc3834ca7abd/LICENSE;md5=545d3f23616dee7495323aeb0b098df3;spdx=Apache-2.0 \
-    file://pkg/mod/sigs.k8s.io/structured-merge-diff/v4@v4.2.3/LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e;spdx=Apache-2.0 \
+    file://pkg/mod/sigs.k8s.io/json@v0.0.0-20250730193827-2d320260d730/LICENSE;md5=545d3f23616dee7495323aeb0b098df3;spdx=Apache-2.0 \
+    file://pkg/mod/sigs.k8s.io/randfill@v1.0.0/LICENSE;md5=8f245a894b7d4f5880176fafd88faad8;spdx=Apache-2.0 \
+    file://pkg/mod/sigs.k8s.io/structured-merge-diff/v6@v6.3.3/LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e;spdx=Apache-2.0 \
+    file://pkg/mod/sigs.k8s.io/yaml@v1.6.0/LICENSE;md5=b5d30dd5bc47d1b56b678ac06dead1c7;spdx=MIT \
 "
diff --git a/recipes-ids/crowdsec/crowdsec_1.7.7.bb b/recipes-ids/crowdsec/crowdsec_1.8.1.bb
similarity index 96%
rename from recipes-ids/crowdsec/crowdsec_1.7.7.bb
rename to recipes-ids/crowdsec/crowdsec_1.8.1.bb
index 0697022..10be348 100644
--- a/recipes-ids/crowdsec/crowdsec_1.7.7.bb
+++ b/recipes-ids/crowdsec/crowdsec_1.8.1.bb
@@ -13,7 +13,7 @@ LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=1e58fe4126ce0b50677f3aa6
 CROWDSEC_BRANCH_VERSION = "${@'.'.join(d.getVar('PV').split('.')[0:2])}"
 SRC_URI = "gitsm://${GO_IMPORT};protocol=https;branch=releases/${CROWDSEC_BRANCH_VERSION}.x;tag=v${PV};destsuffix=${GO_SRCURI_DESTSUFFIX}"
 
-SRCREV = "027974f20cf422bbe1406cf4297fbff37417bd03"
+SRCREV = "909b5157986a2b2c2163300fdaef5ed01289f7d2"
 
 require ${BPN}-licenses.inc
 require ${BPN}-go-mods.inc
-- 
2.55.0


