Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9280.1795883254560833282
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:27:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=i1ryY0hq;
 spf=pass (domain: konsulko.com, ip: 209.85.128.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so78616955e9.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795883253; x=1796488053; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/FToo7NezGYtnqFly3Kp04Sjr4yyPnpTNtjgAd071qs=;
        b=i1ryY0hqPNZb2/ucaVa0mSlBcmV71RP8aWvZvszkVOvzrDWo7TjVctTN9KAjMe+Ikx
         JvJhrjOoulzWgEewa00v7GK/zuJZfSh0h+VAawYfdCLA3LsPiCs7hWWTSe5hU3kzAL8S
         NIEFu3p6wMTTx7jSjZvYSnJ2b4HKBfDLefVV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795883253; x=1796488053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/FToo7NezGYtnqFly3Kp04Sjr4yyPnpTNtjgAd071qs=;
        b=v9rOfj7idZPwBhchRrjEDyCCuUACNcwSeDdSSWhQ9CAO3OplSJZyV4AGd2sPakbXeH
         9WT5O6RaVDnt81o7TsoDict5jA3JZk7sZRixs9sFaEnZuXUwx+c69kNELkqPiOfIAX6Q
         y9BGiBgQL8d7xGcdWEj9RRRWlShQ9ab7RPzyIFitOBFGWZ3LkJpTqanaaEYVt4cQpFbC
         XCcB7Srxi8vdmM5sAlGJ0hnhF9obS2c3apGZPYY7cGdVFm0BK6GVDQzc3hf7IHmMEMmN
         c+tYQ6cBvBcJIV/7PqY76GPoLEZRjtsaD115jje2W39qnqKYxPO782ip9hDxZmvxoEke
         VFZw==
X-Gm-Message-State: APuU4Z8JMpKo/3vUbSxOnbkVSnNOKX+faN4RhQJyC1mLmDmaehBNvQAe
	lmhtngZeXys2/Fv8XETlJwo6Z2ZeTKZHdyFR+OKp6y4kARK4lo262DIfOPBxwSSSdG4QunXrfJ7
	SG/zCYkI=
X-Gm-Gg: AZFdTZcbB5GDDeU9PiNTe1hXZjZTjZoJy7pz0aVtJxDOJ1HGFhmZqtTsHr1kzvmv1o5
	FWr40RbkhHIQR0tRJ3LLdBRs1TErEdHpckjg1KiuLXW0sUsmooQ2QpixO/dd6IRKZ5Fp5pFkUmK
	eeKjmG3I2DKIrlharfzTD0gslsvbhPH1G1k0iaUEysmTQIoug/rtfbrY91Jd/i2251PJDeAfcP9
	nj/ZpenTXm8/n6AiAjac8yRrrI3VOUtDgwe6EmutSOoxNkiWaa4TcS7Lt+yrHZnpAgXEbuNUnxC
	2/k5WhFY/u/sKBQj9FddbVrpCrs7hv/tPHtyjCat39RWDiuOzMqHNzDyGjC/LVVwtUGNat8U21Z
	ql8/uScybgwhbxZKWlQhAW1C9ftmtGHs0EqsnoZRqxox5zwn0xDG4b7AT/iYyA5pXcS6sYcGjwP
	cFkx/hUYMRqWNqTtXJb6HGX6Fbq1mQgcEzvQzaI/M1Nl//qtjFNKS78kj02QDr4YXXoek5twaYe
	e+8eZS6/eybzPcG0NuWiglG3ETGOhv7tw4dabo9vC+fqtb5EyadSSP6SCO0DQdTeWjy99D/fXJW
	WcfUHkKuN4IvoRai54fQQgLE0a/X3M+T5w4UaSffOxS3fggKmDGh7qC377Vqs90dYq4ovn8ln4w
	IzsDNnUCo+DGTpMRsR/qjlXAXEgN2rA==
X-Received: by 2002:a05:600c:3b0e:b0:4a1:efba:511 with SMTP id 5b1f17b1804b1-4bb8882508emr600989725e9.35.1795883251945;
        Sat, 28 Nov 2026 08:27:31 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90655f5asm529202045e9.1.2026.11.28.08.27.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:27:31 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 07/10] crowdsec: Upgrade 1.8.1 -> 1.8.2
Date: Sat, 28 Nov 2026 18:27:10 +0200
Message-ID: <83b6ec220b3f071597cc74356ed94b37b3de484a.1795882913.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795882913.git.scott.murray@konsulko.com>
References: <cover.1795882913.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:27:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5566
Content-Type: text/plain; charset="utf-8"

Also corrected my manually edited value for the licenses for the
apparentlymart/go-textseg/v15 Go module, the third license is the
unique Unicode 3.0 license, which is in oe-core.

Release notes:
https://github.com/crowdsecurity/crowdsec/releases/tag/v1.8.2

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/crowdsec/crowdsec-go-mods.inc     | 185 +++++++++--------
 recipes-ids/crowdsec/crowdsec-licenses.inc    | 194 +++++++++---------
 .../{crowdsec_1.8.1.bb => crowdsec_1.8.2.bb}  |   2 +-
 3 files changed, 192 insertions(+), 189 deletions(-)
 rename recipes-ids/crowdsec/{crowdsec_1.8.1.bb => crowdsec_1.8.2.bb} (96%)

diff --git a/recipes-ids/crowdsec/crowdsec-go-mods.inc b/recipes-ids/crowdsec/crowdsec-go-mods.inc
index 31428e8..b528066 100644
--- a/recipes-ids/crowdsec/crowdsec-go-mods.inc
+++ b/recipes-ids/crowdsec/crowdsec-go-mods.inc
@@ -5,7 +5,7 @@
 # running the update-modules task.
 
 SRC_URI += "\
-    gomod://ariga.io/atlas;version=v1.1.0;sha256sum=1e8161d91f8f07204edb35fe4048cf75605e378df5bfdc60b6a9174d7a57e833 \
+    gomod://ariga.io/atlas;version=v1.3.0;sha256sum=ac2012bc785431cc678dc0f3fbd6b183c1e809da2980de756157ff14851301d5 \
     gomod://dario.cat/mergo;version=v1.0.2;sha256sum=67d2e9d83ca57d3a8ce1a0e0e626a7c03753b3966b58b41b95e97ca4e7b2c640 \
     gomod://entgo.io/ent;version=v0.14.6;sha256sum=cf316ab8814166ec8870f2ebc89f7ea1d0ab6ca14abc8ab653c60f6cf2a49752 \
     gomod://filippo.io/edwards25519;version=v1.2.0;sha256sum=98f2d3ca9b88daa031b0fb2fb521b7ea386af1fed61b6f445a20bef7fa381c17 \
@@ -21,30 +21,30 @@ SRC_URI += "\
     gomod://github.com/alexliesenfeld/health;version=v0.8.1;sha256sum=687dc6b0928b4ca68e9ce580f5197cc55f9e9e798873915accb64f198d4c3b58 \
     gomod://github.com/apparentlymart/go-textseg/v15;version=v15.0.0;sha256sum=4886c2e43b8cd2f6ffbd3a78ef436bd7bc8da7825ab7426257969f346e7bb7eb \
     gomod://github.com/appleboy/gin-jwt/v2;version=v2.10.3;sha256sum=9c7359efc2d016bae0e976f9654a3ec56a875042b220857f635760b1c59b3688 \
-    gomod://github.com/aws/aws-lambda-go;version=v1.54.0;sha256sum=4dc4a889cf28e306149e4845a29355163e561e58d3b44ccca8af2fe4a9ebf40c \
-    gomod://github.com/aws/aws-sdk-go-v2;version=v1.43.6;sha256sum=d07b16918a5d088d78bcbc800f9b4cfb3280a6c509df7ca7dbc46e723b70c9eb \
-    gomod://github.com/aws/aws-sdk-go-v2/aws/protocol/eventstream;version=v1.7.18;sha256sum=df6b679e2d32e966cdd363be28264f226e25e1ad35030e793add3816c11cc517 \
-    gomod://github.com/aws/aws-sdk-go-v2/config;version=v1.32.37;sha256sum=c77e4d9abf5526331107dcd02ebf4f8a467cc2ece2da028f97017c08efbf6f3d \
-    gomod://github.com/aws/aws-sdk-go-v2/credentials;version=v1.19.36;sha256sum=b6da89b27832da6aadb9df0f1e30a20371dca3c349f5544ea267c2ff5040438d \
-    gomod://github.com/aws/aws-sdk-go-v2/feature/ec2/imds;version=v1.18.37;sha256sum=4c4bfc37500b8c94ea8029f5db25c70cb53418e7b6af43655b56657b3815f8df \
-    gomod://github.com/aws/aws-sdk-go-v2/feature/s3/manager;version=v1.22.43;sha256sum=3d3046f7dce9fbe961b9c7faecba25cde3d68c9b16ef99216f1da33224860b89 \
-    gomod://github.com/aws/aws-sdk-go-v2/internal/configsources;version=v1.4.37;sha256sum=c95bda31df03689a4516b1be7a92b6bf5fb8933f1feb818633b4f4fc45a91a26 \
-    gomod://github.com/aws/aws-sdk-go-v2/internal/endpoints/v2;version=v2.7.37;sha256sum=19c76b91b117034d899864f5787bec2dd74640a29ebd5f2027beb81f3a053399 \
-    gomod://github.com/aws/aws-sdk-go-v2/internal/v4a;version=v1.4.38;sha256sum=49d13292e116e8ea0d49cd96bb5524b52bc019823cfce36f5fa1fa48f4a739a8 \
-    gomod://github.com/aws/aws-sdk-go-v2/service/cloudwatchlogs;version=v1.82.2;sha256sum=115867a776c83e11b0316c0f204d11137889ea5a37360d0546ab1edce20ef487 \
-    gomod://github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding;version=v1.13.17;sha256sum=5da6d06e605d71ee3202d46bf2b11c20512210a9c641cb34541690995dcbb6d9 \
-    gomod://github.com/aws/aws-sdk-go-v2/service/internal/checksum;version=v1.9.30;sha256sum=9cf039ac3e98217e34c6d6078a9d4088cc74ccb2bd1b232196fcfe6112f86d1a \
-    gomod://github.com/aws/aws-sdk-go-v2/service/internal/presigned-url;version=v1.13.37;sha256sum=1f0f45888b51a524e091c8c3534aeaaca1a6e5d5aaede79f8249169615b222af \
-    gomod://github.com/aws/aws-sdk-go-v2/service/internal/s3shared;version=v1.19.38;sha256sum=207a5e12107653ad9c2b883ce0af9a3e025ca1b84c7d71e57e29b7f697a6da44 \
-    gomod://github.com/aws/aws-sdk-go-v2/service/kinesis;version=v1.46.6;sha256sum=e2a0c30bed2e361ae1b7868639039230f697e2c2c4c6ce24e5b0e5a3c0d7d2dc \
-    gomod://github.com/aws/aws-sdk-go-v2/service/s3;version=v1.107.2;sha256sum=173d0a705649cea5d63c95e18acda146e99ff6bff3427a9014769807cdf12c5f \
-    gomod://github.com/aws/aws-sdk-go-v2/service/signin;version=v1.5.6;sha256sum=6720b3e00de03856b23d4fdde8f8fd1f67135d104f5bdcafe2fe99975111252b \
-    gomod://github.com/aws/aws-sdk-go-v2/service/sqs;version=v1.46.6;sha256sum=5fcf9709577b18c9dac9f8f68ffee9dea4125418ffb02a4553a7f08843ebc375 \
-    gomod://github.com/aws/aws-sdk-go-v2/service/sso;version=v1.33.6;sha256sum=f2ea291a6e939f3c144291d0dc01e81762061a2157de6df24fe96b0f848bc4bc \
-    gomod://github.com/aws/aws-sdk-go-v2/service/ssooidc;version=v1.38.6;sha256sum=688a033c71b9ecc71c0ee414a2be6adf19b7a679fa851604b7edada850e9aff1 \
-    gomod://github.com/aws/aws-sdk-go-v2/service/sts;version=v1.45.6;sha256sum=6bea363338e61ca9049f3102c20fda348df3c3d12bee2bb46568d3ab63af8333 \
-    gomod://github.com/aws/smithy-go;version=v1.27.8;sha256sum=831b02e1447db3c2d47cefb15b184bd522f26db41cfd28e2635da87e030fdf69 \
-    gomod://github.com/beevik/etree;version=v1.7.1;sha256sum=b4885ad91fd1f277ae10a067b927443443b08539a11ea46e7ddf61839f698ea8 \
+    gomod://github.com/aws/aws-lambda-go;version=v1.55.1;sha256sum=1cf70f73b011990eea454a223deb87cced0fe4e3504c011e513275e9ec307410 \
+    gomod://github.com/aws/aws-sdk-go-v2;version=v1.47.3;sha256sum=4aa8e34e3474deed9df61edcd8d7bae09ec46b941ab2ff5805960dcdcfcd5db4 \
+    gomod://github.com/aws/aws-sdk-go-v2/aws/protocol/eventstream;version=v1.7.22;sha256sum=9838bb7dbc62b12d9501d3498cc4be519e7c20f1364a6ded627bacf1a4f61a2a \
+    gomod://github.com/aws/aws-sdk-go-v2/config;version=v1.33.9;sha256sum=8d05a0e25881b396f8e406207c0423098272c7a8b2be53af3d88a41d42d76747 \
+    gomod://github.com/aws/aws-sdk-go-v2/credentials;version=v1.20.9;sha256sum=4fffbed9c3b57fc3ad268cda6133c572f2d079c2da0a906fdd46ae06b0608c43 \
+    gomod://github.com/aws/aws-sdk-go-v2/feature/ec2/imds;version=v1.20.3;sha256sum=0e4cc47e1e3fa7f5f901f180a01c98c94c8e4d0d0a7012053f873e6f1eed2390 \
+    gomod://github.com/aws/aws-sdk-go-v2/feature/s3/manager;version=v1.23.14;sha256sum=8c36cea3d2d260eddfd0b6a157a5db19d36046329d10127bc6322d52686ff373 \
+    gomod://github.com/aws/aws-sdk-go-v2/internal/configsources;version=v1.5.6;sha256sum=6649de0f595b31e30d039bf01a2f9c9880ed4c64dacfb148e21275d48d778343 \
+    gomod://github.com/aws/aws-sdk-go-v2/internal/endpoints/v2;version=v2.8.6;sha256sum=718ee2f8eeeae766f6850c8c00b3f248feddd79d8a51d7f1e93cb2d13dbb57b7 \
+    gomod://github.com/aws/aws-sdk-go-v2/internal/v4a;version=v1.5.6;sha256sum=32b153f6d725a3e9ccfec87ad1b79fe3d39db5749e9a53bc20654214ecb46053 \
+    gomod://github.com/aws/aws-sdk-go-v2/service/cloudwatchlogs;version=v1.90.0;sha256sum=365e655bfad2c2d49769f5ddb171f0d4500ac5d4b0cc1148f1f5dc3e5137c2cd \
+    gomod://github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding;version=v1.13.21;sha256sum=297f64a3671e46441e17b0e4e489ccf9d58057d123266944161738e8e52f6740 \
+    gomod://github.com/aws/aws-sdk-go-v2/service/internal/checksum;version=v1.11.7;sha256sum=56f6b390c267596845fc1955ce68487174ff7b4528ff5435b9d1a3188d135dff \
+    gomod://github.com/aws/aws-sdk-go-v2/service/internal/presigned-url;version=v1.14.6;sha256sum=16a518a3698a2eaff3788cea50fa31347e16811cbb8b8eaa60350d097c550901 \
+    gomod://github.com/aws/aws-sdk-go-v2/service/internal/s3shared;version=v1.20.6;sha256sum=22e58ddf4744df2353f0fa8d90eb2bb99e16f084a2fcee242a3d7962af85f71f \
+    gomod://github.com/aws/aws-sdk-go-v2/service/kinesis;version=v1.56.5;sha256sum=b99e84ef695b3ac4b554aa91fb7d2f92fbd1614dcd27852ad1ec95d27cb09b97 \
+    gomod://github.com/aws/aws-sdk-go-v2/service/s3;version=v1.114.3;sha256sum=d80e9e310f21b27d0af761f4d63191e8124b1fc20006116bcc7f6445f13d41ed \
+    gomod://github.com/aws/aws-sdk-go-v2/service/signin;version=v1.10.4;sha256sum=b5547650b2389db84e435d2f84cb43ceb53cfbbfcac3c29d7fe0673451e19c89 \
+    gomod://github.com/aws/aws-sdk-go-v2/service/sqs;version=v1.52.5;sha256sum=a260e37017b25e51f105dedd6727b18b966a8a4e9c5f885842fdc7eba459caed \
+    gomod://github.com/aws/aws-sdk-go-v2/service/sso;version=v1.38.4;sha256sum=5d43b1f76b9bbbe9dd209b5052796faf1a5e5a3d0af176a75d8248d397d89215 \
+    gomod://github.com/aws/aws-sdk-go-v2/service/ssooidc;version=v1.43.4;sha256sum=460b52896bc218d8a3ad32ca6055458d50303ba284953295fdbcba4f8947746e \
+    gomod://github.com/aws/aws-sdk-go-v2/service/sts;version=v1.51.4;sha256sum=24030bc57bdae661b027adb927507ae10f5261a9059a30f20f8554bac1d69e21 \
+    gomod://github.com/aws/smithy-go;version=v1.28.5;sha256sum=2827daaa4ec0f109abe9c7f74772163561e4d24efea938b7051cf541b4ff8552 \
+    gomod://github.com/beevik/etree;version=v1.8.1;sha256sum=c0338bfc955c839a435fc49156536be7e39525455412940f12ef1e0a903ee706 \
     gomod://github.com/beorn7/perks;version=v1.0.1;sha256sum=25bd9e2d94aca770e6dbc1f53725f84f6af4432f631d35dd2c46f96ef0512f1a \
     gomod://github.com/bluele/gcache;version=v0.0.2;sha256sum=6b74bf6b1a6c2d961e2cb6bd01f42d37f6f70bc340394a0b052a65486e26df7f \
     gomod://github.com/bmatcuk/doublestar;version=v1.3.4;sha256sum=6da867cec2e9e748762e9c8d84b01e220a0fe4d917425be7825f9152c262a402 \
@@ -54,12 +54,13 @@ SRC_URI += "\
     gomod://github.com/bytedance/sonic/loader;version=v0.5.1;mod=1;sha256sum=c5b463f674a8ce937d7c88d4bfaf9b65044818392acd86eb176e543bc30c5c7a \
     gomod://github.com/cenkalti/backoff/v5;version=v5.0.3;sha256sum=58e4d9014277bc1c5c7ab64539137923964cc3920303a4f771d02a532939bedb \
     gomod://github.com/cespare/xxhash/v2;version=v2.3.0;sha256sum=145a26cdc7c49db566017b807c4989ee7f7ddeb569423e9cb99f995fac3621d3 \
+    gomod://github.com/clipperhouse/displaywidth;version=v0.10.0;mod=1;sha256sum=26f1f8342a6784ce253dc415a422852876340c894c37485328989cf6a39a0bd3 \
     gomod://github.com/clipperhouse/uax29/v2;version=v2.7.0;sha256sum=67b1278f1ffb4e4d783a390e48fe7396864650138e785d4b4bfca5914333f761 \
     gomod://github.com/cloudwego/base64x;version=v0.1.6;mod=1;sha256sum=8b494d199b3660a3320b502e73d59e20ef7da2ee802d643d3a5dfb33ef132121 \
     gomod://github.com/cockroachdb/apd;version=v1.1.0;mod=1;sha256sum=46ec9e27ae0d6eb416eb02e219eb609747461362358fc17cf32d1bc3f929a0da \
     gomod://github.com/containerd/errdefs;version=v1.0.0;sha256sum=b4ef42c38d00f2c81cf3e69646549b7f5dc8fb72de9402d7b391963dc0ac9162 \
     gomod://github.com/containerd/errdefs/pkg;version=v0.3.0;sha256sum=593bf56f1991517e493510815d8fc6d344b8550fbfb3de56812f015096aab24f \
-    gomod://github.com/corazawaf/libinjection-go;version=v0.3.2;sha256sum=034e123baa084430b11ec601ae6310e5508c558245de2cf0ea831a5cbc160ca2 \
+    gomod://github.com/corazawaf/libinjection-go;version=v0.3.5;sha256sum=ed56f80423f0a19a9361875d228e7db373478d2325d5b0775330b7f35b50684b \
     gomod://github.com/coreos/go-systemd;version=v0.0.0-20190321100706-95778dfbb74e;mod=1;sha256sum=dceb172eab082cca6a93107d9fbdde58e1d213fcab1bb81277c58da738177dcd \
     gomod://github.com/coreos/go-systemd;version=v0.0.0-20190719114852-fd7a80b32e1f;mod=1;sha256sum=dceb172eab082cca6a93107d9fbdde58e1d213fcab1bb81277c58da738177dcd \
     gomod://github.com/coreos/go-systemd/v22;version=v22.7.0;sha256sum=25c78b5dae5afa61291a8559328007cc77e60dd6747454af5c83423c26cfdfba \
@@ -68,10 +69,9 @@ SRC_URI += "\
     gomod://github.com/cpuguy83/go-md2man/v2;version=v2.0.7;sha256sum=9ad5f2cbc644c0bb648a9b182d6b70f92e7ac4dfab5cf0ef746bbeef944fda59 \
     gomod://github.com/creack/pty;version=v1.1.17;mod=1;sha256sum=0413a4191dccd6c75b0cc74cb71af1564070f2ecbfce3ab4ba3ccc9d701fd82c \
     gomod://github.com/creack/pty;version=v1.1.7;mod=1;sha256sum=5ec31d31b68c8b9854e121e09d579444eb7708b2b815a078bfa452c2e25b7b14 \
-    gomod://github.com/crowdsecurity/coraza/v3;version=v3.7.0-crowdsec.20260730;sha256sum=1848c256583056af990a73fe814f401627eeefa3d6d4c8c1a0bd39f0b99b5b30 \
+    gomod://github.com/crowdsecurity/coraza/v3;version=v3.8.0-crowdsec.20261001;sha256sum=c50baff6f29ec716dd7bc6f4e76245e95df2ad2f8fdaf3a27aeb75dcaf6b13e5 \
     gomod://github.com/crowdsecurity/dlog;version=v0.0.2;sha256sum=9769acaa57ea316b541bc68f19d5ed16050ca02146db16e7a579447c01b21645 \
     gomod://github.com/crowdsecurity/go-cs-lib;version=v0.0.25;sha256sum=117acf585de553fcbf1df5bf65f0646b3f952cb5db252d1da0d8a49f78707d6e \
-    gomod://github.com/crowdsecurity/grokky;version=v0.2.2;sha256sum=71ff3370e344569c085b147c086512dc321f9b98834e9997759d5c97dcef947d \
     gomod://github.com/crowdsecurity/machineid;version=v1.0.3;sha256sum=6fdd11930567dadc18b163d79b81426953418850af190fbdd58f4fc0c5118908 \
     gomod://github.com/crowdsecurity/time;version=v0.13.0-crowdsec.20250912;sha256sum=3f35a30384be23afbb243127725bca21711527b4827775cd7160db9e8c24ced7 \
     gomod://github.com/davecgh/go-spew;version=v0.0.0-20161028175848-04cdfd42973b;mod=1;sha256sum=bcb29393251237b79a17b6c19bf29134f43e8f438c3198988fcd461a1cdf05cc \
@@ -79,21 +79,21 @@ SRC_URI += "\
     gomod://github.com/davecgh/go-spew;version=v1.1.1;mod=1;sha256sum=bcb29393251237b79a17b6c19bf29134f43e8f438c3198988fcd461a1cdf05cc \
     gomod://github.com/davecgh/go-spew;version=v1.1.2-0.20180830191138-d8f796af33cc;sha256sum=b4d0923b169b194f0016ec46f3df1ab0c68e27999743e43fe2de59ecb2484128 \
     gomod://github.com/distribution/reference;version=v0.6.0;sha256sum=08232852a7a908263599777daab50e4306bd877e2467df036206367496122bcc \
-    gomod://github.com/docker/go-connections;version=v0.7.0;sha256sum=44c583ae40f15bd8abfe95a8b243d121ffef79b4605e8c737e24d5853188746e \
+    gomod://github.com/docker/go-connections;version=v0.8.2;sha256sum=21a93233185080e27e212d819ccfecd98fa0b071b1de16eb64d6090bbfdcdb46 \
     gomod://github.com/docker/go-units;version=v0.5.0;sha256sum=039d53ebe64af1aefa0be94ce42c621a17a3052c58ad15e5b3f357529beeaff6 \
     gomod://github.com/dustin/go-humanize;version=v1.0.1;mod=1;sha256sum=4325999d0a6841031258a2561c22879d9fbdf77abc6b32a17b1cb6edf0810fb2 \
-    gomod://github.com/ebitengine/purego;version=v0.10.2;mod=1;sha256sum=4920ecc5239d79446d9b61542c3749c7389d2178d3a142e557e0379051866514 \
+    gomod://github.com/ebitengine/purego;version=v0.11.1;mod=1;sha256sum=b63c9137b0c2608c4cd43a0234cbaeb777bc0d43a29744f2058c1da82b6d358e \
     gomod://github.com/emicklei/go-restful/v3;version=v3.13.0;sha256sum=06bd60484b324de0b8e4366d4ed326db2e1dc730459b46e19a5306a108439c77 \
     gomod://github.com/evanw/esbuild;version=v0.28.2;sha256sum=db0fc2918ef7d1769b1746ed123d40db4f92636e2536dda4e40f5d080ae30de2 \
     gomod://github.com/expr-lang/expr;version=v1.17.8;sha256sum=82210321f9078349af5dbf774e2a2d9f4aabe79db23a3124034722cdc632cd80 \
     gomod://github.com/fatih/color;version=v1.13.0;mod=1;sha256sum=f0ac49fdf878d4b36897025bfb18639e2fe67d884cea8e324e5c1915697f8b1c \
     gomod://github.com/fatih/color;version=v1.19.0;sha256sum=694b4265dc678e2a65b196371d5a6ec4eed3739f12a16021dcd2f0c1355d0ec6 \
-    gomod://github.com/felixge/httpsnoop;version=v1.0.4;sha256sum=75aa471311265e9860df0e523400b4650ed0c1a33262786a421f07226792e494 \
+    gomod://github.com/felixge/httpsnoop;version=v1.1.0;sha256sum=e3405a361843f8e69f64e41b523512925cd50fd5ea108b7912534922c31b00e7 \
     gomod://github.com/fsnotify/fsnotify;version=v1.10.1;sha256sum=b2c6a334e0d518da2e046066bdd9da34cb26bad6df9f17701802d3de522ab016 \
     gomod://github.com/fsnotify/fsnotify;version=v1.6.0;mod=1;sha256sum=83bf51fd60c28a81139f84189c7ba3e9d88fdbcd20fafd58392cb76501a61a64 \
     gomod://github.com/fxamacker/cbor/v2;version=v2.9.1;sha256sum=e1e319f75e5565aab662a6afd7ddc1565ab415bd46ee82ff4958fde909da20eb \
     gomod://github.com/gabriel-vasile/mimetype;version=v1.4.13;sha256sum=03b46aaa7bd4403d65dc23fb9d7e9b61214bb429491c864ee638490a42d55013 \
-    gomod://github.com/getkin/kin-openapi;version=v0.147.0;sha256sum=42d8f415d2a3e66d503eecaef9cfc104e36607c99ab8c33ec14d9b0f0d2dfd2a \
+    gomod://github.com/getkin/kin-openapi;version=v0.151.0;sha256sum=07f296f7d9ba309acaa290569b626875394bc499e3b60e11a18c25e9ea070875 \
     gomod://github.com/gin-contrib/gzip;version=v1.2.3;sha256sum=9df2eb0490af0b4dd1e2170268824ea5e35a0c60aff35710c3d3f4a619c8d228 \
     gomod://github.com/gin-contrib/sse;version=v1.1.1;sha256sum=6c129866d1d3cbb1556f2ae84d474f6b22871417aa6420a3be383a3c305049b9 \
     gomod://github.com/gin-gonic/gin;version=v1.11.0;sha256sum=ef27dd16d3edd311b60b920d44a57b52b1c208b5bb8a3a6c712945e0f5562cdf \
@@ -106,31 +106,31 @@ SRC_URI += "\
     gomod://github.com/go-logr/stdr;version=v1.2.2;sha256sum=9dd6893bf700198485ae699640b49bc1efbc6c73b37cb5792a0476e1fd8f7fef \
     gomod://github.com/go-ole/go-ole;version=v1.2.6;mod=1;sha256sum=de7da59858d6121956da002ded711242cc14ecf597e932a8625246418fd3bbaa \
     gomod://github.com/go-ole/go-ole;version=v1.3.0;mod=1;sha256sum=fcf0840f2ff50fbc3b5a54b9d4cb240c64d47003ab03e420aeff0057015a8953 \
-    gomod://github.com/go-openapi/analysis;version=v0.26.0;sha256sum=302fefa87c709aadcf9540702f9669468514ec83936a044d9731f14c7266b34b \
-    gomod://github.com/go-openapi/errors;version=v0.22.8;sha256sum=29105371e583abec5440063d20b77c67f67bf6b017c959c88934a5da6e65ae92 \
+    gomod://github.com/go-openapi/analysis;version=v1.0.0;sha256sum=806361b020a8dbfb202bc5d104f1008dff307c6dcf4edc757d372fa10914560b \
+    gomod://github.com/go-openapi/errors;version=v0.22.9;sha256sum=051d8685c61791cb57083da18eff3639f0a00dc4357c28b1598b675cf29bcc59 \
     gomod://github.com/go-openapi/inflect;version=v0.21.5;sha256sum=f04b7f703151f59d058b7941977b187c170cdd6b2837df7b6abd64526aabf920 \
-    gomod://github.com/go-openapi/jsonpointer;version=v1.0.0;sha256sum=403cc887595921a24880a173862ea95b7c46f0747725d7b75c31165e0647e157 \
-    gomod://github.com/go-openapi/jsonreference;version=v1.0.0;sha256sum=381714f9c672c76e573155e6e6fb38ab1ccceafba6163d672a52d4460a999f5b \
-    gomod://github.com/go-openapi/loads;version=v0.25.0;sha256sum=309d12a74ca10eacfe6d73a3b1f91a7fd4c5d30609bddb48afb05e101c3ac361 \
-    gomod://github.com/go-openapi/spec;version=v0.22.9;sha256sum=e99c84955b8268d1552d5a77ccaec6a9c92c5c397aeaa52ee693636b6be5cafd \
-    gomod://github.com/go-openapi/strfmt;version=v0.27.0;sha256sum=6e830c668d22047156cd9d1e991e9e2603a55fd2fbd7331ee2e4691e9646797e \
-    gomod://github.com/go-openapi/swag;version=v0.28.0;sha256sum=3d8ca6e12ec2e0ca5e14be6f2688cfb3005878b799d42fbe3828e293d375dd5b \
-    gomod://github.com/go-openapi/swag/cmdutils;version=v0.28.0;sha256sum=ec8d7c8093e697ab5aa09eb1c7644bc02f9bb48d2cd00278a1c851001c6f82c4 \
-    gomod://github.com/go-openapi/swag/conv;version=v0.28.0;sha256sum=0869a899afe4cdc64843f06a45cc9fe4feddb47be187e223730ffe4b57de854b \
-    gomod://github.com/go-openapi/swag/fileutils;version=v0.28.0;sha256sum=282c501d0d2f2539c5ea0ae18fcd0b3b544d958b91b483404426717610ffcacb \
-    gomod://github.com/go-openapi/swag/jsonutils;version=v0.28.0;sha256sum=9ec1021cfa869bcf862ec8a36b166c46ebbb47f736e2bb8fa2a6685b83170e34 \
-    gomod://github.com/go-openapi/swag/loading;version=v0.28.0;sha256sum=63c459ca5289190b2a231c05aff1d22710bab0f50c33a49fe5f0c6cb218612a0 \
-    gomod://github.com/go-openapi/swag/mangling;version=v0.28.0;sha256sum=2d16f070918e2fd8714aaf356dfb9984e84daf7643689a8e25cc58d5ded54b70 \
-    gomod://github.com/go-openapi/swag/netutils;version=v0.28.0;sha256sum=d7363cce443a04264c352c76d34d89d0993e7e299319b25c00854d7ab865672a \
-    gomod://github.com/go-openapi/swag/pools;version=v0.28.0;sha256sum=623705ee11fe884b4a998ca0e8305c4da03ada2f43c3b4c41e1f84486e627049 \
-    gomod://github.com/go-openapi/swag/stringutils;version=v0.28.0;sha256sum=e15348c48de427f551dc69583eb088a72510c257cf976f6ab382601ec602ab6c \
-    gomod://github.com/go-openapi/swag/typeutils;version=v0.28.0;sha256sum=9256dec49a60a1efca39e0486107c7d86d15f7c52c962cfb9a04a720023e3e0d \
-    gomod://github.com/go-openapi/swag/yamlutils;version=v0.28.0;sha256sum=66bffa6d57cfc00135695b8d873f08d11c6017f472aa00b777dd168b3ecec2c3 \
-    gomod://github.com/go-openapi/validate;version=v0.26.3;sha256sum=b630b6260bb14fc1fe45ce748057ebff07fa86affbe744ebaec0a4bbfb66ad4d \
+    gomod://github.com/go-openapi/jsonpointer;version=v1.0.1;sha256sum=2a65a7a48df16e1b477b11050552d6a32c2bedf8d10e2819be4a42b3fa3a77e9 \
+    gomod://github.com/go-openapi/jsonreference;version=v1.0.1;sha256sum=dc2be0608d3cf77b585d4f531279a3c9bb63b1a28c8fcf61b9eb6706ab1e93e1 \
+    gomod://github.com/go-openapi/loads;version=v0.25.2;sha256sum=8efa2be3c1070b3a3c66b03eeb2d31a62b544265a3590731ca7953bd2c9be2b0 \
+    gomod://github.com/go-openapi/spec;version=v1.0.0;sha256sum=ae99668764b3eb2c8c403989890032e5789d57b1a992d80e80c57c2876f1f61f \
+    gomod://github.com/go-openapi/strfmt;version=v0.27.4;sha256sum=cf7554bea11e3dc0d276d20cf6b040656e4e327a0041880517d538990128f58c \
+    gomod://github.com/go-openapi/swag;version=v0.29.2;sha256sum=7eb932c6e8d2c65399cb0ce05ac07ed6890e8be8f89f0e14c3633c13b9e6b5c1 \
+    gomod://github.com/go-openapi/swag/cmdutils;version=v0.29.2;sha256sum=9d3718108fe466f6939a02798e77610850bd3972b26bb4be767277b80a74491a \
+    gomod://github.com/go-openapi/swag/conv;version=v0.29.2;sha256sum=40f074336f5332566d1e591fef0213e1f5b66a056c529f23a742f00c48e9a98b \
+    gomod://github.com/go-openapi/swag/fileutils;version=v0.29.2;sha256sum=0df6e2bf0df5203870aefb951288b75edae2982c5ce7c74847e3f4ecfbe288b2 \
+    gomod://github.com/go-openapi/swag/jsonutils;version=v0.29.2;sha256sum=9501519560dd16e45329d8347494818cfaabae577a12a465a15a97690b870429 \
+    gomod://github.com/go-openapi/swag/loading;version=v0.29.2;sha256sum=cda07b9e0b9a53015118fac77ca11c733bac26e7bbb3b89089cef24f1e3c5271 \
+    gomod://github.com/go-openapi/swag/mangling;version=v0.29.2;sha256sum=ac4e040b22930aec1a70d099192a6fbbf68c9c7b624d50ab8f6faf08fb8859b8 \
+    gomod://github.com/go-openapi/swag/netutils;version=v0.29.2;sha256sum=e5cfc45406c88b20b54481afd011685bb2419a74ed7032348f9fea15d034e3bd \
+    gomod://github.com/go-openapi/swag/pools;version=v0.29.2;sha256sum=896d9fd8b6d08753fcadd1f6f3e064068c8a5c0d7a9af58d4ecdbdfbf07afa0c \
+    gomod://github.com/go-openapi/swag/stringutils;version=v0.29.2;sha256sum=f48ab90eedafb4059e96fcb9bb63c9bf47b6a7a03f2c191dcf9d5698e2c9700e \
+    gomod://github.com/go-openapi/swag/typeutils;version=v0.29.2;sha256sum=3029ba8a7894271a67db1bb24ebfb8e4945b960234167f0fa9c2fcd3fb13ac8d \
+    gomod://github.com/go-openapi/swag/yamlutils;version=v0.29.2;sha256sum=d2dd896648b99f6bd5c09e95c15002da7cedc36339cd53875e8ff1f70429109c \
+    gomod://github.com/go-openapi/validate;version=v1.0.0;sha256sum=1aae41b4fe221a74b4d081421a003ef344fa21d21a8dfd2adb5c7ee17a8deb5e \
     gomod://github.com/go-playground/locales;version=v0.14.1;sha256sum=f33b53f2eef290d8b43b1011285f1f9cfcb1295c690defcb452598773baace7b \
     gomod://github.com/go-playground/universal-translator;version=v0.18.1;sha256sum=77fc966f2d045c208ddeaa8343924f83688841b6f4c2ae005dc9ea5550c7d171 \
     gomod://github.com/go-playground/validator/v10;version=v10.30.2;sha256sum=19b740a35f29483539a143ff5226266e4fe5f39b339d30599a85cfc258a8b8c6 \
-    gomod://github.com/go-sql-driver/mysql;version=v1.10.0;sha256sum=dc93f5770556406e82bf750a980d2316f882a19d883a3689eadb820708c2b651 \
+    gomod://github.com/go-sql-driver/mysql;version=v1.10.1;sha256sum=540ca42579d19f7e548cda1a47f39cd26e1231577def50078ff9ab4c65b6dd7e \
     gomod://github.com/go-stack/stack;version=v1.8.0;mod=1;sha256sum=591552a7ca5f4351d9bef6b868f2d85a61ea028271442581f5f487dced196129 \
     gomod://github.com/go-viper/mapstructure/v2;version=v2.5.0;sha256sum=326f8e00f648af4ae8e6e18c606325e4206a92d6ed42f486dc2f4da8e1897547 \
     gomod://github.com/goccy/go-json;version=v0.10.6;mod=1;sha256sum=9027c83efc1eb1e1f4dfdc0ecd03d6de89dcb68ecae41d442485028f366fa98b \
@@ -217,7 +217,7 @@ SRC_URI += "\
     gomod://github.com/kaptinlin/messageformat-go;version=v0.4.19;sha256sum=e11931a8d89d5a4e598345ac73f79e6afb1e3b969e6d62dbd6313c29243d6733 \
     gomod://github.com/kballard/go-shellquote;version=v0.0.0-20180428030007-95032a82bc51;sha256sum=ae4cb7b097dc4eb0c248dff00ed3bbf0f36984c4162ad1d615266084e58bd6cc \
     gomod://github.com/kisielk/gotool;version=v1.0.0;mod=1;sha256sum=77aca7bffc0ec29fc9f088d5962ab3128f405d7b10c7ceb9693ff7a08958955d \
-    gomod://github.com/klauspost/compress;version=v1.19.1;sha256sum=a77e019f60dff8bdf00ad137985c808957cc657381daa4281824843bc6b46910 \
+    gomod://github.com/klauspost/compress;version=v1.20.1;sha256sum=eedb58d7e4a65669f9a290536646cbfe4188112368424b56a8c75cfdadb27dea \
     gomod://github.com/klauspost/cpuid/v2;version=v2.3.0;mod=1;sha256sum=ff61d47f254f2333bf44a8ff4187a2f2e973693807c10025033bb37143577237 \
     gomod://github.com/konsorten/go-windows-terminal-sequences;version=v1.0.1;mod=1;sha256sum=6b69dafd3cf64d7b57e978848a7e271a2be0a04d9a2564dd2556491d27d0a034 \
     gomod://github.com/konsorten/go-windows-terminal-sequences;version=v1.0.2;mod=1;sha256sum=6b69dafd3cf64d7b57e978848a7e271a2be0a04d9a2564dd2556491d27d0a034 \
@@ -253,8 +253,8 @@ SRC_URI += "\
     gomod://github.com/mitchellh/go-wordwrap;version=v1.0.1;sha256sum=5f96426c4b3b3e90a9b7471568cb1d61d6a306744f5d4765a30fa8a61e1c0b47 \
     gomod://github.com/mitchellh/reflectwalk;version=v1.0.2;sha256sum=c96eed6b50f00b1acdc79224e8e55f66ef3e98e3f7c6373afa3e3b8c6ef440d1 \
     gomod://github.com/moby/docker-image-spec;version=v1.3.1;sha256sum=e3fe212be410465c0cae032baa7e2c7282b9bb878f081f00549333edc260c306 \
-    gomod://github.com/moby/moby/api;version=v1.55.0;sha256sum=5e6428e58b17018a8e1ecffb176dbdffc7678b97f7bf4f50fd3f814747de4847 \
-    gomod://github.com/moby/moby/client;version=v0.5.1;sha256sum=1fbfaea19d085d23f99d47352f0665713c11986b383b8209625abac6db2e04b2 \
+    gomod://github.com/moby/moby/api;version=v1.56.1;sha256sum=de5d5f59f04bd5a3b531b85d99e25bdb81acc45c68ee23febcba2b93aef2af05 \
+    gomod://github.com/moby/moby/client;version=v0.6.2;sha256sum=47dcb0c5f386072be63eebd9d3a9ccb6977aab952edef42034bb79d7c9aeda69 \
     gomod://github.com/modern-go/concurrent;version=v0.0.0-20180228061459-e0a39a4cb421;mod=1;sha256sum=27a5e9f05c71089b6fd5e119fc1c8ce81f0c16da4ec3357157b1d85e2ba85ae2 \
     gomod://github.com/modern-go/concurrent;version=v0.0.0-20180306012644-bacd9c7ef1dd;sha256sum=91ef49599bec459869d94ff3dec128871ab66bd2dfa61041f1e1169f9b4a8073 \
     gomod://github.com/modern-go/reflect2;version=v1.0.2;mod=1;sha256sum=099ee58ec210155280692f9e2360f523272e525f06272754be7a2a44dbfa0623 \
@@ -266,7 +266,11 @@ SRC_URI += "\
     gomod://github.com/oasdiff/yaml;version=v0.1.1;sha256sum=c7813b8bf97831462a9d3a347a8ea9dbd71644c53de7af55f6df45688a968af4 \
     gomod://github.com/oasdiff/yaml3;version=v0.0.14;sha256sum=3e8b91dd2b5208d482fe592467b6654927291031a19f7792d51bb64781ad738c \
     gomod://github.com/oklog/run;version=v1.2.0;sha256sum=730451ad4b759a648873e99b72abb9e8b3f7e23a4949f808d0238b827594073d \
-    gomod://github.com/oklog/ulid/v2;version=v2.1.1;sha256sum=312b5fea3f68df920adaffc327440efbaba43ad6a8df2f7e0c9e365743f6ff89 \
+    gomod://github.com/oklog/ulid/v2;version=v2.1.2;sha256sum=0af1a4847c9dcf0084230afbe6d9265f433d9f45e2507ce155e3dbbd312aa7c3 \
+    gomod://github.com/olekukonko/cat;version=v0.0.0-20250911104152-50322a0618f6;mod=1;sha256sum=af802a21861eb1dc30f3ac67467610303efe9d0ec80801ee2a37ff68ef46de6c \
+    gomod://github.com/olekukonko/errors;version=v1.2.0;mod=1;sha256sum=ed0335fc7f6c84d6dbb240067fc8d97e38a47328259a92a1b3555a4b49c1595c \
+    gomod://github.com/olekukonko/ll;version=v0.1.6;mod=1;sha256sum=47f45f4644dd586c2c31d17383ec0dd698b9a9f30e78a0ee910f56f5e0f79d48 \
+    gomod://github.com/olekukonko/tablewriter;version=v1.1.4;mod=1;sha256sum=013e5a2085446d6c2c54321ae4471cce7e4ab2b121c5bea6a59774a5a3729916 \
     gomod://github.com/opencontainers/go-digest;version=v1.0.0;sha256sum=615efb31ff6cd71035b8aa38c3659d8b4da46f3cd92ac807cb50449adfe37c86 \
     gomod://github.com/opencontainers/image-spec;version=v1.1.1;sha256sum=3a32eeb459719172947c20be78b5b7293c6ea84f4039184e846f6b676bc19574 \
     gomod://github.com/oschwald/geoip2-golang;version=v1.13.0;sha256sum=ae8e8157da293279d085518ca009aa11dab141aa7d5521cb9c9851ce52c8c418 \
@@ -279,11 +283,11 @@ SRC_URI += "\
     gomod://github.com/pmezard/go-difflib;version=v0.0.0-20151028094244-d8ed2627bdf0;mod=1;sha256sum=74b2e766eb215377864d587badf57e95521f692d2a7860b3c7759093f9c9bec2 \
     gomod://github.com/pmezard/go-difflib;version=v1.0.0;mod=1;sha256sum=74b2e766eb215377864d587badf57e95521f692d2a7860b3c7759093f9c9bec2 \
     gomod://github.com/pmezard/go-difflib;version=v1.0.1-0.20181226105442-5d4384ee4fb2;sha256sum=24ff45e356f638a53bd0c89fff961fbeaecfdb0dc5e482ceed0a2230e0e5f3b7 \
-    gomod://github.com/power-devops/perfstat;version=v0.0.0-20240221224432-82ca36839d55;mod=1;sha256sum=05744a9262bcd294613e65624f3f8bae83d79a58aa48b8328c7df91190aa07bf \
-    gomod://github.com/prometheus/client_golang;version=v1.24.1;sha256sum=90b627e392d9936cf410ed23066d6198fecc11130bbab2e17dda627da3a86fc3 \
-    gomod://github.com/prometheus/client_model;version=v0.6.2;sha256sum=67017b19f220c6ab91ecfdd10a93824e2a8b09fcb6390054dbdc49df3354a9ca \
-    gomod://github.com/prometheus/common;version=v0.70.1;sha256sum=587d6d0890642e7f9ef2ce6a76cdf6dcbd71f70c59437282a2e19c98cf68c2b8 \
-    gomod://github.com/prometheus/procfs;version=v0.21.1;sha256sum=b417ab3081ad334ce4c6b367b2d5e74dea49e2eb3b5431c1dd5a65e1256736f9 \
+    gomod://github.com/power-devops/perfstat;version=v0.0.0-20260805114148-88456608a4f6;mod=1;sha256sum=05744a9262bcd294613e65624f3f8bae83d79a58aa48b8328c7df91190aa07bf \
+    gomod://github.com/prometheus/client_golang;version=v1.25.0;sha256sum=677986b15218e6e5f740fd0801a6024726e71bf909ca1a504417eae281df4519 \
+    gomod://github.com/prometheus/client_model;version=v0.6.3;sha256sum=92f5d9a39b75bdc3f6733563934438148a3c3661420a8f742fea8cbf40d39abe \
+    gomod://github.com/prometheus/common;version=v0.72.1;sha256sum=4bc895838ac3416153ab67a1459400ca32dfaf8d19220c1bda6133481bcecefd \
+    gomod://github.com/prometheus/procfs;version=v0.22.0;sha256sum=e13d43da4a9773cecdfa8b86e745bbd8efda07b005402c673a1e882b6dbb6804 \
     gomod://github.com/quic-go/qpack;version=v0.6.0;sha256sum=3ac037cd1747420bc00bd6a793b4b197a2359fc354de12dc2187477417564914 \
     gomod://github.com/quic-go/quic-go;version=v0.59.1;sha256sum=d00c08f9c9fa94654733baecbbfc930c41e86aa2c84a5eadfe25b8ccf9685fff \
     gomod://github.com/r3labs/diff/v2;version=v2.15.1;sha256sum=58da63a4f92aaee6117b927788d60082418e0870be3e7c762341b748120ff510 \
@@ -298,14 +302,14 @@ SRC_URI += "\
     gomod://github.com/santhosh-tekuri/jsonschema/v6;version=v6.0.3;sha256sum=79282583888de6fd146e513f01e09bd3b228976942d2114688e97608279b1ebe \
     gomod://github.com/satori/go.uuid;version=v1.2.0;mod=1;sha256sum=4179602495a0a2456cd6ad14a9964b3372683eb17998c287462eca379007c4ff \
     gomod://github.com/segmentio/kafka-go;version=v0.4.51;sha256sum=2ce854a2dff96c98deeaf93c24925de64db859f5cded5ad18e57a83c860bbefa \
-    gomod://github.com/shirou/gopsutil/v4;version=v4.26.7;sha256sum=e707bb272b2d66974997f49becc1dd991b23b35c400cbdecd5906461e42c236c \
+    gomod://github.com/shirou/gopsutil/v4;version=v4.26.9;sha256sum=2206a841e6e5ca18b4b88d10f90a05c0714528cdec5bdd0801b9c02ed76e0ab6 \
     gomod://github.com/shopspring/decimal;version=v0.0.0-20180709203117-cd690d0c9e24;mod=1;sha256sum=efb3296a57d42e30fbe229452070a1a87115dbbbafdd536dd738d18d46d55f52 \
     gomod://github.com/shopspring/decimal;version=v1.2.0;mod=1;sha256sum=983f79d79f2dfb76233371da2a6d6bd7980eed64c3e43ef7d815ebd37dae9c1e \
     gomod://github.com/shopspring/decimal;version=v1.4.0;sha256sum=751d4cd3460984afc72973d2a0df56ed9b10499c5cd0508d7f2207245d9e3315 \
-    gomod://github.com/sirupsen/logrus;version=v1.10.0;sha256sum=e9597626924d23f5e0e731fffe940b03cbf108ce7ec801fec65cdd48e5976e62 \
+    gomod://github.com/sirupsen/logrus;version=v1.10.2;sha256sum=73a40737da86682dd536ec2c87dff0f589eeeed81873362b08ed009818747b52 \
     gomod://github.com/sirupsen/logrus;version=v1.4.1;mod=1;sha256sum=219855a87fbdc6db059e210407557f24621981b1f17505a924a55832ac709113 \
     gomod://github.com/sirupsen/logrus;version=v1.4.2;mod=1;sha256sum=6c6bbbca5fad7ea9b863d9ec99c30caa77805785405b21e70d75783b5194c678 \
-    gomod://github.com/slack-go/slack;version=v0.29.0;sha256sum=2943c9b8b2ac15cc76824bf0fd2779b80d8d1984a3d14b0c01ae32bca004cee3 \
+    gomod://github.com/slack-go/slack;version=v0.30.1;sha256sum=897fc0aa3e4dfbfd34ad8526a240760e8cb4add06e19fb27790d8f52f7759061 \
     gomod://github.com/spf13/cast;version=v1.10.0;sha256sum=7c7ba27f9979ada980c2a69f6b2fdf7b4ce1f2b766e245c0a4716f546ad7ddce \
     gomod://github.com/spf13/cobra;version=v1.10.2;sha256sum=a00aae6fcd631e0fde52c98604452ff70e1b73c3b8a560d68db15aff5e26872d \
     gomod://github.com/spf13/cobra;version=v1.4.0;mod=1;sha256sum=575f3f520642009bac1fe464f2090d1c07298b4778f3c13ac1f00671790cdadb \
@@ -338,8 +342,8 @@ SRC_URI += "\
     gomod://github.com/tidwall/match;version=v1.2.0;sha256sum=f35502f3dd450fa84ddc7b028310f7fecc86c8112f2397fe7ff7941c5afbcbc1 \
     gomod://github.com/tidwall/pretty;version=v1.2.0;mod=1;sha256sum=6e5c5fa493d8f18e8974b38ed63e8c71863cce59e659d98d0ef8417bf81e3ecf \
     gomod://github.com/tidwall/pretty;version=v1.2.1;sha256sum=9327579bf9e610de753eeb7c35c8cf1e3f56e6e5623cbf65e47bc8076023d1ab \
-    gomod://github.com/tklauser/go-sysconf;version=v0.3.16;sha256sum=d4c896f77e5934f54d772b5f6a8f8043b8d34df189f6581bc2ba84d239a6b643 \
-    gomod://github.com/tklauser/numcpus;version=v0.11.0;sha256sum=7a7527e1f68059a77189ae875c294e5c310925fbb8ba5a6c794edd2b7e687267 \
+    gomod://github.com/tklauser/go-sysconf;version=v0.4.0;sha256sum=61e89253bc4d7091170601be12633dc02e94a3bc30470b081a2449944fa18784 \
+    gomod://github.com/tklauser/numcpus;version=v0.12.0;sha256sum=56c22a112976df3a4d8db776b41288658070650ae6382ec86d0a32fc07af0276 \
     gomod://github.com/toorop/go-dkim;version=v0.0.0-20201103131630-e1cd1a0a5208;mod=1;sha256sum=67fee1d99ef4244df63e083e7b5a2800d9ab0244982d9d45177bf6ec31cf3af8 \
     gomod://github.com/toorop/go-dkim;version=v0.0.0-20250226130143-9025cce95817;sha256sum=2a1c5262ea26e4ded1aef5aa4fee2b562cd54d9e0609f18dffd8b11d9e719e80 \
     gomod://github.com/twitchyliquid64/golang-asm;version=v0.15.1;mod=1;sha256sum=b198a096146daeff6177f0a11bdee5a2cbe0e6fec80714ccf1f2dd6b95a7dd6f \
@@ -347,8 +351,7 @@ SRC_URI += "\
     gomod://github.com/umahmood/haversine;version=v0.0.0-20151105152445-808ab04add26;sha256sum=ffc82bcdb2bf7f1e64f1e940b9aeee8c6e81e84717cfad56170df9e298e28951 \
     gomod://github.com/valllabh/ocsf-schema-golang;version=v1.0.3;sha256sum=ffb04c1651a4e08f1339cc0e308f9699026e23acee7dda1dbf9ffea4ae2a8208 \
     gomod://github.com/vmihailenco/msgpack;version=v4.0.4+incompatible;sha256sum=918f7dd7883105b9c55728c704a3bc54c80568b2b09583890b51508c03391356 \
-    gomod://github.com/wasilibs/go-re2;version=v1.12.0;sha256sum=5176f4611a3a5466e575070c0c2e6ebdddd328a8c13eae121ab72471feab55a3 \
-    gomod://github.com/wasilibs/wazero-helpers;version=v0.0.0-20250123031827-cd30c44769bb;mod=1;sha256sum=49ca46dffde7100373e17172bfb5217cddbd98e9e24898e6367ebb764abf270f \
+    gomod://github.com/wasilibs/go-re2;version=v1.13.0;sha256sum=6c60350ed26a4f1f51fb81249644687105f4da0d64cac6bb5ad7dfe5bb5b2844 \
     gomod://github.com/x448/float16;version=v0.8.4;sha256sum=73b24a41037ea999ab66851e3798a0973dbb1f214925915b01f0820f7b2f1500 \
     gomod://github.com/xdg-go/scram;version=v1.2.0;mod=1;sha256sum=6f032e4589e3660c7438543f499166c4190de48dc486b15ac1dda0ae392f47fc \
     gomod://github.com/xhit/go-simple-mail/v2;version=v2.16.0;sha256sum=dd5f49b91c868268619085df3330bb797ad423a2473dd4d8efc783fffb67d229 \
@@ -359,7 +362,7 @@ SRC_URI += "\
     gomod://github.com/zclconf/go-cty-yaml;version=v1.2.0;sha256sum=84cd48191428a94ab2fc4f7b06d9826538e970d0a3ac3ef62c54088b161cbf8f \
     gomod://github.com/zenazn/goji;version=v0.9.0;mod=1;sha256sum=2e5435768eeb0ffb1593111093fbc436916d5c85b97cda404f77aa56643e79b7 \
     gomod://go.opentelemetry.io/auto/sdk;version=v1.2.1;sha256sum=a08a16fc0a7041cdb875f47a260a56000632212c85f65a302a043c76380c8335 \
-    gomod://go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp;version=v0.68.0;sha256sum=84a5f546bebf91ebebe431b04f13230e0bd189a0eefcc6652f523e4c29ae12ba \
+    gomod://go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp;version=v0.69.0;sha256sum=6f2e1d300fe09d55ef13886efa33b06e9bcbd4d5f04f0014b0a2871402a28a28 \
     gomod://go.opentelemetry.io/otel;version=v1.44.0;sha256sum=4b7ef50caaf3dc6fc1a058f9ce2ccda6aad2ab3e8657acc4c8bb3102f79c53bc \
     gomod://go.opentelemetry.io/otel/metric;version=v1.44.0;sha256sum=4442ba5f269f81251f549acb14ac16176f23967f4a0706163440b0df91592f96 \
     gomod://go.opentelemetry.io/otel/trace;version=v1.44.0;sha256sum=cd1abf8dcec62fe9788fae9105760db1711e6e994d2e31cdda57ccb467e7ceec \
@@ -391,11 +394,11 @@ SRC_URI += "\
     gomod://golang.org/x/crypto;version=v0.0.0-20210921155107-089bfa567519;mod=1;sha256sum=cd6311612a2aa4d0d7e03c41b3aa1fbc2d5f895ab3f61089fab80bfe9f8f5485 \
     gomod://golang.org/x/crypto;version=v0.19.0;mod=1;sha256sum=f8b595e5c961093c6877b96af679f43322254a53087b11fd2645642e693befd5 \
     gomod://golang.org/x/crypto;version=v0.20.0;mod=1;sha256sum=d8536991eb61062128778a081f729b52e279ed1eb4d76ce180bda420bf87a100 \
-    gomod://golang.org/x/crypto;version=v0.55.0;sha256sum=0660bba47b3643fe1beb1b97af93b6a4d2bf2ed069d9e52a2b1bdf6f17cf3e79 \
+    gomod://golang.org/x/crypto;version=v0.58.0;sha256sum=b0a45594cda20ddb4264d84aeff9b588b8570bf6a2833c51a0b821734a298d95 \
     gomod://golang.org/x/lint;version=v0.0.0-20190930215403-16217165b5de;mod=1;sha256sum=79df4350b922a8d193782e5600f88280a2b9d41781bfb3760c09bf52ad3023bf \
     gomod://golang.org/x/mod;version=v0.0.0-20190513183733-4bf6d317e70e;mod=1;sha256sum=ac221647647b0b59618b2e312ba252fc36d6e5cf33d0f2ca64f1fac65a1d6034 \
     gomod://golang.org/x/mod;version=v0.1.1-0.20191105210325-c90efee705ee;mod=1;sha256sum=d76bbdea81d196d09858967a67ac805dacecdd1fb30c5001a187d24c129b1597 \
-    gomod://golang.org/x/mod;version=v0.40.0;sha256sum=a191080b1494c194059ae71aa1d300741a8e24dfb6e28cd32580dbdcc52a0598 \
+    gomod://golang.org/x/mod;version=v0.42.0;sha256sum=2770e372e42c30dd498d63bb094fe257edfad6882c611f8e0d82925feac159f3 \
     gomod://golang.org/x/mod;version=v0.6.0-dev.0.20220419223038-86c51ed26bb4;mod=1;sha256sum=42d19023ff8f2eae700bc5495f371ecd998a22d19ba985d0af5f69900b254083 \
     gomod://golang.org/x/mod;version=v0.8.0;mod=1;sha256sum=624567459c6e9947ac4abde0b7034ee61dcbb6a9373f5970094c0bb3e8121964 \
     gomod://golang.org/x/net;version=v0.0.0-20190311183353-d8887717615a;mod=1;sha256sum=f7046769daac02beb57cbcc481280df59fb403c96fe8262282aba858c7f7fa4d \
@@ -407,13 +410,13 @@ SRC_URI += "\
     gomod://golang.org/x/net;version=v0.0.0-20220722155237-a158d28d115b;mod=1;sha256sum=b315c52647d2da2f76e5cdb9d367e1d6727784236a9bffb612192b19b10a128d \
     gomod://golang.org/x/net;version=v0.10.0;mod=1;sha256sum=d3b7e236ff09e6322be489170216e018d3221862f1a053dcb63e53eab8533c17 \
     gomod://golang.org/x/net;version=v0.21.0;mod=1;sha256sum=0eef3e9fe7f668be5b4d24c8f1251c6c502d1168953c8081ac9dc3f399c64f06 \
-    gomod://golang.org/x/net;version=v0.58.0;sha256sum=aa78bbf8d55db3e6995630165e2bcd7dce6d0b8831c166fa03b80ac94fb650e7 \
     gomod://golang.org/x/net;version=v0.6.0;mod=1;sha256sum=41ec76ea2172f3ee3031e38f9a535939a584d6bb35ef480854fdcb8c2026701b \
-    gomod://golang.org/x/oauth2;version=v0.36.0;sha256sum=15bf65ff103e5dafc809d78cd037a1d1e88ccb8451824e851156002a13304504 \
+    gomod://golang.org/x/net;version=v0.61.0;sha256sum=f6843a98d608298e48a6ca287292c9a6fae066284050ce174d5ffb781c9b3dcf \
+    gomod://golang.org/x/oauth2;version=v0.37.0;sha256sum=82b0472ff31d57867bfb95e28c2906acd54764949a215b6a01bda40f4ae4c3bd \
     gomod://golang.org/x/sync;version=v0.0.0-20190423024810-112230192c58;mod=1;sha256sum=421f6139686d5891f3dc5a563d0995780d3279f65cad4d225cea52686794161c \
     gomod://golang.org/x/sync;version=v0.0.0-20220722155255-886fb9371eb4;mod=1;sha256sum=421f6139686d5891f3dc5a563d0995780d3279f65cad4d225cea52686794161c \
     gomod://golang.org/x/sync;version=v0.1.0;mod=1;sha256sum=421f6139686d5891f3dc5a563d0995780d3279f65cad4d225cea52686794161c \
-    gomod://golang.org/x/sync;version=v0.22.0;sha256sum=4bc67d258ce7867cfc1a43765c43d98b4c49b90c46dd0b86f896a5a4909fade0 \
+    gomod://golang.org/x/sync;version=v0.24.0;sha256sum=ca3fcf3ea8259e75891f7947e1a816a5b89402c542d45d8bbbd9e061b0c58019 \
     gomod://golang.org/x/sys;version=v0.0.0-20180905080454-ebe1bf3edb33;mod=1;sha256sum=8969115e4a39108848324e79a1bd8a8445230e6e3aaccbe9f8057fb50fffc8c1 \
     gomod://golang.org/x/sys;version=v0.0.0-20190215142949-d0b11bdaac8a;mod=1;sha256sum=8969115e4a39108848324e79a1bd8a8445230e6e3aaccbe9f8057fb50fffc8c1 \
     gomod://golang.org/x/sys;version=v0.0.0-20190222072716-a9d3bda3a223;mod=1;sha256sum=8969115e4a39108848324e79a1bd8a8445230e6e3aaccbe9f8057fb50fffc8c1 \
@@ -437,14 +440,14 @@ SRC_URI += "\
     gomod://golang.org/x/sys;version=v0.0.0-20220908164124-27713097b956;mod=1;sha256sum=f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024 \
     gomod://golang.org/x/sys;version=v0.1.0;mod=1;sha256sum=f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024 \
     gomod://golang.org/x/sys;version=v0.17.0;mod=1;sha256sum=d227b325f621f4ebe28d39ba773ea99b870f393b7c09c34592c365b16dd560de \
-    gomod://golang.org/x/sys;version=v0.47.0;sha256sum=cdac013ddced0262926ec29ffcda645da39670e61c7e5b761e572b6b1809bb1b \
+    gomod://golang.org/x/sys;version=v0.49.0;sha256sum=e73a06591ca0d7016ce3ccb45c36a8ed7128468aecc1a357f94d815c760c6b31 \
     gomod://golang.org/x/sys;version=v0.5.0;mod=1;sha256sum=f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024 \
     gomod://golang.org/x/sys;version=v0.8.0;mod=1;sha256sum=f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024 \
     gomod://golang.org/x/term;version=v0.0.0-20201117132131-f5c789dd3221;mod=1;sha256sum=be95e45a793860e61e60b5d4373946d73b25d6e1d42e4455a8acdef6c665ef84 \
     gomod://golang.org/x/term;version=v0.0.0-20201126162022-7de9c90e9dd1;mod=1;sha256sum=4cbab14f7706771b271d995a1b3cc131fe5a246aadc7ee6d1ba6f0bd894781fa \
     gomod://golang.org/x/term;version=v0.0.0-20210927222741-03fcf44c2211;mod=1;sha256sum=740794e2914f5cc87e25656c5843222b2c65665821205f45632a0477c8d3f79b \
     gomod://golang.org/x/term;version=v0.17.0;mod=1;sha256sum=dbea02254aac2cf3fd0f72c7c602e543c5fbad2d00dafc2f819c28a935258199 \
-    gomod://golang.org/x/term;version=v0.45.0;sha256sum=b3a3af689728b43012ae1b21482571a35c033c545e98e021606bd4fcf1f79108 \
+    gomod://golang.org/x/term;version=v0.47.0;sha256sum=d990d5ab94dfa41ba980645b721bba7490064337a01bb03e6cacace70e8df0bf \
     gomod://golang.org/x/term;version=v0.5.0;mod=1;sha256sum=0d6f58228aadc1a6528e6755da018516566e3ae5c5201f7ade1773f56fa8d934 \
     gomod://golang.org/x/term;version=v0.8.0;mod=1;sha256sum=5d362d6a83453f7024725e824c05c5949624ef8f4cb13f5d7e3d4b7f1ca0b327 \
     gomod://golang.org/x/text;version=v0.14.0;mod=1;sha256sum=971579f17e9abc5926ab76214f533bd517cf4925c885243ac4755a1a0a7c69ef \
@@ -456,7 +459,7 @@ SRC_URI += "\
     gomod://golang.org/x/text;version=v0.3.7;mod=1;sha256sum=c45d669089427bc4635d07b185f9b9680332d1c48c75b3c49cb715b81a04a5b0 \
     gomod://golang.org/x/text;version=v0.3.8;mod=1;sha256sum=0c06e8d4bc0c4eddce0f9ca01ad87dd9ff74cad7fa8ba166fe97d97d1deb27ae \
     gomod://golang.org/x/text;version=v0.4.0;mod=1;sha256sum=15929e76fce04aea4c92a354426bb43370684645a4ee03f2e75d0c2eb1466304 \
-    gomod://golang.org/x/text;version=v0.41.0;sha256sum=e63f35daaae749d0ffff97a295ad8f4837a662938a46b7a87f18a88e85a5cbf9 \
+    gomod://golang.org/x/text;version=v0.43.0;sha256sum=b75131f628f6e2e4892fd638d33127e952a5027775e0162b94ba069cb4e13863 \
     gomod://golang.org/x/text;version=v0.7.0;mod=1;sha256sum=15929e76fce04aea4c92a354426bb43370684645a4ee03f2e75d0c2eb1466304 \
     gomod://golang.org/x/text;version=v0.9.0;mod=1;sha256sum=436f592e77b593b02fbea374e23ad3369c8623ff0d29c91de7de1e6672db9a41 \
     gomod://golang.org/x/tools;version=v0.0.0-20180917221912-90fa682c2a6e;mod=1;sha256sum=a0e02f0678fe62dc3c4b4bc77fa912c9b70de10fa9f7cf2f7aad0337392b52af \
@@ -469,7 +472,7 @@ SRC_URI += "\
     gomod://golang.org/x/tools;version=v0.0.0-20191119224855-298f0cb1881e;mod=1;sha256sum=88d479265f886f5e598d76c003d0f257b42dbf1b895d820a12b5ab0b3501aca1 \
     gomod://golang.org/x/tools;version=v0.0.0-20200103221440-774c71fcf114;mod=1;sha256sum=5ea469c803b6ef8d41d1561b9e301a003fdd93976468bda5574b26b056ea7f49 \
     gomod://golang.org/x/tools;version=v0.1.12;mod=1;sha256sum=2a8b9365898f0822face65ba089a1353e68a65d342f300ca317cceccde6421f3 \
-    gomod://golang.org/x/tools;version=v0.49.0;mod=1;sha256sum=86e34efea35b8aa52aabff0ea18c0ef217f074dff67ef7b4c700ae833968cf62 \
+    gomod://golang.org/x/tools;version=v0.51.0;mod=1;sha256sum=9b1d543349c9346f85900c656a566d1780d59ff479cf0d888b9516d21ec7df7b \
     gomod://golang.org/x/tools;version=v0.6.0;mod=1;sha256sum=830ed78dcd3e9927c412e2641230308447749d513d31024d276e2443b2016609 \
     gomod://golang.org/x/xerrors;version=v0.0.0-20190410155217-1f06c39b4373;mod=1;sha256sum=aa5e3ec9bb7b9f681609efac019d9de1a7ba7719248ff1eaa27e78882db3d7f5 \
     gomod://golang.org/x/xerrors;version=v0.0.0-20190513163551-3ee3066db522;mod=1;sha256sum=aa5e3ec9bb7b9f681609efac019d9de1a7ba7719248ff1eaa27e78882db3d7f5 \
@@ -479,8 +482,8 @@ SRC_URI += "\
     gomod://golang.org/x/xerrors;version=v0.0.0-20200804184101-5ec99f83aff1;mod=1;sha256sum=aa5e3ec9bb7b9f681609efac019d9de1a7ba7719248ff1eaa27e78882db3d7f5 \
     gomod://google.golang.org/appengine;version=v1.6.6;mod=1;sha256sum=476fc776d2906c32b6d6f30691df098cd4a70ad57967b3818faa444319cd9294 \
     gomod://google.golang.org/appengine;version=v1.6.8;mod=1;sha256sum=ef17709123a95906e09d1318b71489fd455bd6efbf6d404083b3137256df2423 \
-    gomod://google.golang.org/genproto/googleapis/rpc;version=v0.0.0-20260526163538-3dc84a4a5aaa;sha256sum=55f932b106d6f4f8cb76ae869e44f5d6d8400965fa441ee3532d09c96d64aac1 \
-    gomod://google.golang.org/grpc;version=v1.83.0;sha256sum=74f959ac1f70dc56b80f39b8001abe5b4af5d325d72d38dd65d3b9a8d380011b \
+    gomod://google.golang.org/genproto/googleapis/rpc;version=v0.0.0-20260706201446-f0a921348800;sha256sum=42a0902eda416f038ae29a247e12a8932a566d8b18682ca8cd2d333a40c0f407 \
+    gomod://google.golang.org/grpc;version=v1.84.0;sha256sum=a14bebefbac1ec115d9e1f8042006c185d65adf43a91644f3e58df0688831b95 \
     gomod://google.golang.org/protobuf;version=v1.26.0;mod=1;sha256sum=08ec2e20f38efcb651462800069ece4891e252a261007fa9d5a1b157f516ee5f \
     gomod://google.golang.org/protobuf;version=v1.26.0-rc.1;mod=1;sha256sum=b2c4fe1a66ff5be6eb7c0c5388f080d08821c327ac5cf975dee51d8b0fb49e9f \
     gomod://google.golang.org/protobuf;version=v1.36.12;sha256sum=68f8a3174aff42950fd9bd02c11b45c6986eb8060508d124d1c3dd6bf86b9be6 \
@@ -498,20 +501,20 @@ SRC_URI += "\
     gomod://gopkg.in/yaml.v3;version=v3.0.0-20200313102051-9f266ea9e77c;mod=1;sha256sum=21579860a20306fcf43b1bd234d1fba319499c77611b71c05f9bf3ba90dab939 \
     gomod://gopkg.in/yaml.v3;version=v3.0.1;sha256sum=aab8fbc4e6300ea08e6afe1caea18a21c90c79f489f52c53e2f20431f1a9a015 \
     gomod://honnef.co/go/tools;version=v0.0.1-2019.2.3;mod=1;sha256sum=592e9c55bb272525a46900c55469feb97adae507e7649beab4dc1350d735f64f \
-    gomod://k8s.io/api;version=v0.36.3;sha256sum=95f7a42e06dbd40d12aaf3e970bf14444a439e1d64b96dfad936070793bdff21 \
-    gomod://k8s.io/apimachinery;version=v0.36.3;sha256sum=23ab7303b43f39c7275a56b44b3f4e38ed9f77db0296a711ab2324ef3cf81297 \
-    gomod://k8s.io/apiserver;version=v0.36.3;sha256sum=0d227bfb8ee65a5ac90796b179180534bffd9581e5045debb9076836f910c07c \
-    gomod://k8s.io/client-go;version=v0.36.3;sha256sum=6747e6664289daae7f310b54e594b56e91edd252d607cfcd8cdccbb5a59f45b7 \
+    gomod://k8s.io/api;version=v0.37.1;sha256sum=a599830bb9480afbbbf0b8cdc0954d68a8f8271f9d8e31e9dc5c2a1fdb88406a \
+    gomod://k8s.io/apimachinery;version=v0.37.1;sha256sum=35ac0650a8182926b34823991f08d98b869a06720bdbe09cea79b3d6db0156e5 \
+    gomod://k8s.io/apiserver;version=v0.37.1;sha256sum=2afd1b1772b594f7a8ac2838fd75e823885a3fe8e25af6b1497f9eb211b36c26 \
+    gomod://k8s.io/client-go;version=v0.37.1;sha256sum=6058950813d4923d7c56c5ea1551e45c6521a204d0fb2270a5efd67c82b8c3ce \
     gomod://k8s.io/klog/v2;version=v2.140.0;sha256sum=46fab8686139b04c42f1b44e84c5a162667fbf22628216d5061d95206625a886 \
-    gomod://k8s.io/kube-openapi;version=v0.0.0-20260330154417-16be699c7b31;sha256sum=41eef64b5efc175ae1f174812e622fc1674f1f1848ee156e95a8ec40a5006a82 \
-    gomod://k8s.io/utils;version=v0.0.0-20260319190234-28399d86e0b5;sha256sum=5d87a7ffd5c0ba5381c1af420a421938a4bff87badf2d002c17013feee978a54 \
-    gomod://modernc.org/libc;version=v1.74.4;mod=1;sha256sum=2904d69c00aef038bbe75d81a30f01ae2891d5f6ebd814be6a8221255483dfff \
+    gomod://k8s.io/kube-openapi;version=v0.0.0-20260721132016-d427ff9ee9ad;sha256sum=d49441d035de2e04140f634bc3e4055d0ac59a05cd095cbb0717c3e36e16ed4c \
+    gomod://k8s.io/utils;version=v0.0.0-20260626114624-be93311217bd;sha256sum=11b292d2a6f02494c4d543c726426c307ad3901a7a781ab3fabeae40fd647840 \
+    gomod://modernc.org/libc;version=v1.77.1;mod=1;sha256sum=eeeb66d6d1e0bfd058a004b4a3f99827dee70c6d65e58e2bc9e8385c5bc362fd \
     gomod://modernc.org/mathutil;version=v1.7.1;mod=1;sha256sum=68683385203fe0204d853bae60003c336716d2526e7149bf58f51815a2479fd8 \
-    gomod://modernc.org/memory;version=v1.11.0;mod=1;sha256sum=e9890d3b9794d40a3703aa9809edc4e131cbb55a2831b602314076e91c5ace97 \
-    gomod://modernc.org/sqlite;version=v1.56.0;mod=1;sha256sum=16d48f22c12f295bdb2b457473223bfa96c2b480d0bfb3243e8ecc577f49f10a \
+    gomod://modernc.org/memory;version=v1.12.1;mod=1;sha256sum=e9890d3b9794d40a3703aa9809edc4e131cbb55a2831b602314076e91c5ace97 \
+    gomod://modernc.org/sqlite;version=v1.60.1;mod=1;sha256sum=249a9230a78e49f8648b2f722371085b2b77505dc417e7e680824882a9e2b89b \
     gomod://rsc.io/binaryregexp;version=v0.2.0;sha256sum=b3e706aa278fa7f880d32fa1cc40ef8282d1fc7d6e00356579ed0db88f3b0047 \
     gomod://sigs.k8s.io/json;version=v0.0.0-20250730193827-2d320260d730;sha256sum=7cec6eae3e4e4c9c1e0a009eef200740990fafbcb9cab081eb18ce32f6e7a7b9 \
     gomod://sigs.k8s.io/randfill;version=v1.0.0;sha256sum=31dbbfc44ce12f78f1b68d6bbeed8526aa73c53243353d44d50b2532c828f5f1 \
-    gomod://sigs.k8s.io/structured-merge-diff/v6;version=v6.3.3;sha256sum=cc7604660434c50e1ca34529ea9b395af5333ba4521bfd463161d6db838e8966 \
+    gomod://sigs.k8s.io/structured-merge-diff/v6;version=v6.4.2;sha256sum=9af2aa83a0a0ddb17f658ee8aad2a1b187450b8c0cac5687f7cc94d27d63112d \
     gomod://sigs.k8s.io/yaml;version=v1.6.0;sha256sum=cf88648a471581817b00a42ee8d24fd73eb0e3503998cf46d8e63787e11e5052 \
 "
diff --git a/recipes-ids/crowdsec/crowdsec-licenses.inc b/recipes-ids/crowdsec/crowdsec-licenses.inc
index f72da45..27aaee5 100644
--- a/recipes-ids/crowdsec/crowdsec-licenses.inc
+++ b/recipes-ids/crowdsec/crowdsec-licenses.inc
@@ -4,10 +4,10 @@
 # Do not modify it by hand, as the contents will be replaced when
 # running the update-modules task.
 
-LICENSE += "AND Apache-2.0 AND BSD-2-Clause AND BSD-3-Clause AND ISC AND MIT AND MPL-2.0 AND WTFPL"
+LICENSE += "AND Apache-2.0 AND BSD-2-Clause AND BSD-3-Clause AND ISC AND MIT AND MPL-2.0 AND Unicode-3.0"
 
 LIC_FILES_CHKSUM += "\
-    file://pkg/mod/ariga.io/atlas@v1.1.0/LICENSE;md5=175792518e4ac015ab6696d16c4f607e;spdx=Apache-2.0 \
+    file://pkg/mod/ariga.io/atlas@v1.3.0/LICENSE;md5=175792518e4ac015ab6696d16c4f607e;spdx=Apache-2.0 \
     file://pkg/mod/dario.cat/mergo@v1.0.2/LICENSE;md5=ff13e03bb57bf9c52645f2f942afa28b;spdx=BSD-3-Clause \
     file://pkg/mod/entgo.io/ent@v0.14.6/LICENSE;md5=175792518e4ac015ab6696d16c4f607e;spdx=Apache-2.0 \
     file://pkg/mod/filippo.io/edwards25519@v1.2.0/LICENSE;md5=5d4950ecb7b26d2c5e4e7b4e0dd74707;spdx=BSD-3-Clause \
@@ -20,34 +20,35 @@ LIC_FILES_CHKSUM += "\
     file://pkg/mod/github.com/alexliesenfeld/health@v0.8.1/LICENSE;md5=77aecb31b0bf38e6c2c292463604c338;spdx=MIT \
     file://pkg/mod/github.com/apparentlymart/go-textseg/v15@v15.0.0/LICENSE;beginline=1;endline=19;md5=d57e691f661895b6e63c173405869a37;spdx=MIT \
     file://pkg/mod/github.com/apparentlymart/go-textseg/v15@v15.0.0/LICENSE;beginline=25;endline=34;md5=c37d99507ac95d0eace7ccc51bf683f2;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/apparentlymart/go-textseg/v15@v15.0.0/LICENSE;beginline=65;md5=aed6f1c844d036b1ec630879c0856cf0;spdx=MIT \
+    file://pkg/mod/github.com/apparentlymart/go-textseg/v15@v15.0.0/LICENSE;beginline=65;md5=aed6f1c844d036b1ec630879c0856cf0;spdx=Unicode-3.0 \
     file://pkg/mod/github.com/appleboy/gin-jwt/v2@v2.10.3/LICENSE;md5=c4620316ae1fb3b746e5cee94986dfd2;spdx=MIT \
-    file://pkg/mod/github.com/aws/aws-lambda-go@v1.54.0/LICENSE;md5=b1e01b26bacfc2232046c90a330332b3;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/aws/protocol/eventstream@v1.7.18/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/config@v1.32.37/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/credentials@v1.19.36/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/feature/ec2/imds@v1.18.37/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/feature/s3/manager@v1.22.43/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/internal/configsources@v1.4.37/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/internal/endpoints/v2@v2.7.37/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/internal/v4a@v1.4.38/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/cloudwatchlogs@v1.82.2/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding@v1.13.17/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/internal/checksum@v1.9.30/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/internal/presigned-url@v1.13.37/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/internal/s3shared@v1.19.38/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/kinesis@v1.46.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/s3@v1.107.2/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/signin@v1.5.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/sqs@v1.46.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/sso@v1.33.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/ssooidc@v1.38.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/sts@v1.45.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2@v1.43.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/aws-sdk-go-v2@v1.43.6/internal/sync/singleflight/LICENSE;md5=bdc234595bc2fe370918f5de5077c8e9;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/aws/smithy-go@v1.27.8/LICENSE;md5=34400b68072d710fecd0a2940a0d1658;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/aws/smithy-go@v1.27.8/internal/sync/singleflight/LICENSE;md5=bdc234595bc2fe370918f5de5077c8e9;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/beevik/etree@v1.7.1/LICENSE;md5=5220faf6133cbaef3cb62eee4bc0e09e;spdx=BSD-2-Clause \
+    file://pkg/mod/github.com/aws/aws-lambda-go@v1.55.1/LICENSE;md5=b1e01b26bacfc2232046c90a330332b3;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/aws/protocol/eventstream@v1.7.22/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/config@v1.33.9/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/credentials@v1.20.9/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/feature/ec2/imds@v1.20.3/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/feature/s3/manager@v1.23.14/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/internal/configsources@v1.5.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/internal/endpoints/v2@v2.8.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/internal/v4a@v1.5.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/cloudwatchlogs@v1.90.0/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding@v1.13.21/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/internal/checksum@v1.11.7/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/internal/presigned-url@v1.14.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/internal/s3shared@v1.20.6/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/kinesis@v1.56.5/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/s3@v1.114.3/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/signin@v1.10.4/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/sqs@v1.52.5/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/sso@v1.38.4/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/ssooidc@v1.43.4/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2/service/sts@v1.51.4/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2@v1.47.3/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/aws-sdk-go-v2@v1.47.3/internal/sync/singleflight/LICENSE;md5=bdc234595bc2fe370918f5de5077c8e9;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/aws/smithy-go@v1.28.5/LICENSE;md5=34400b68072d710fecd0a2940a0d1658;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/aws/smithy-go@v1.28.5/internal/sync/singleflight/LICENSE;md5=bdc234595bc2fe370918f5de5077c8e9;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/aws/smithy-go@v1.28.5/transport/http/protocol/internal/json/internal/stdlib/LICENSE;md5=5d4950ecb7b26d2c5e4e7b4e0dd74707;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/beevik/etree@v1.8.1/LICENSE;md5=5220faf6133cbaef3cb62eee4bc0e09e;spdx=BSD-2-Clause \
     file://pkg/mod/github.com/beorn7/perks@v1.0.1/LICENSE;md5=0d0738f37ee8dc0b5f88a32e83c60198;spdx=MIT \
     file://pkg/mod/github.com/bluele/gcache@v0.0.2/LICENSE;md5=f16f1a674492e15d2ad50ab1acc0ba7a;spdx=MIT \
     file://pkg/mod/github.com/bmatcuk/doublestar@v1.3.4/LICENSE;md5=2a0ed06d3f9d0a3be066dc72088ae2ed;spdx=MIT \
@@ -57,29 +58,28 @@ LIC_FILES_CHKSUM += "\
     file://pkg/mod/github.com/clipperhouse/uax29/v2@v2.7.0/LICENSE;md5=39b00daa69674119df37aadf8ab34aeb;spdx=MIT \
     file://pkg/mod/github.com/containerd/errdefs/pkg@v0.3.0/LICENSE;md5=1269f40c0d099c21a871163984590d89;spdx=Apache-2.0 \
     file://pkg/mod/github.com/containerd/errdefs@v1.0.0/LICENSE;md5=1269f40c0d099c21a871163984590d89;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/corazawaf/libinjection-go@v0.3.2/LICENSE;md5=8d2cfb1b0d35fea175f7d3f201dec57e;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/corazawaf/libinjection-go@v0.3.5/LICENSE;md5=8d2cfb1b0d35fea175f7d3f201dec57e;spdx=BSD-3-Clause \
     file://pkg/mod/github.com/coreos/go-systemd/v22@v22.7.0/LICENSE;md5=19cbd64715b51267a47bf3750cc6a8a5;spdx=Apache-2.0 \
     file://pkg/mod/github.com/cpuguy83/go-md2man/v2@v2.0.7/LICENSE.md;md5=80794f9009df723bbc6fe19234c9f517;spdx=MIT \
-    file://pkg/mod/github.com/crowdsecurity/coraza/v3@v3.7.0-crowdsec.20260730/LICENSE;md5=c7d40d02b84931ff4d1b0d0242868943;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/crowdsecurity/coraza/v3@v3.8.0-crowdsec.20261001/LICENSE;md5=c7d40d02b84931ff4d1b0d0242868943;spdx=Apache-2.0 \
     file://pkg/mod/github.com/crowdsecurity/dlog@v0.0.2/LICENSE;md5=5371b61f7962ad1b1222e74e7f06c138;spdx=Apache-2.0 \
     file://pkg/mod/github.com/crowdsecurity/go-cs-lib@v0.0.25/LICENSE;md5=1e58fe4126ce0b50677f3aa6ba8e13c2;spdx=MIT \
-    file://pkg/mod/github.com/crowdsecurity/grokky@v0.2.2/LICENSE;md5=6c80118ac2c1c95b011c5040454d0af9;spdx=WTFPL \
     file://pkg/mod/github.com/crowdsecurity/machineid@v1.0.3/LICENSE.md;md5=6243912f756442acbdcf80af3bc76aae;spdx=MIT \
     file://pkg/mod/github.com/crowdsecurity/time@v0.13.0-crowdsec.20250912/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
     file://pkg/mod/github.com/davecgh/go-spew@v1.1.2-0.20180830191138-d8f796af33cc/LICENSE;md5=c06795ed54b2a35ebeeb543cd3a73e56;spdx=ISC \
     file://pkg/mod/github.com/distribution/reference@v0.6.0/LICENSE;md5=d2794c0df5b907fdace235a619d80314;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/docker/go-connections@v0.7.0/LICENSE;md5=04424bc6f5a5be60691b9824d65c2ad8;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/docker/go-connections@v0.8.2/LICENSE;md5=04424bc6f5a5be60691b9824d65c2ad8;spdx=Apache-2.0 \
     file://pkg/mod/github.com/docker/go-units@v0.5.0/LICENSE;md5=04424bc6f5a5be60691b9824d65c2ad8;spdx=Apache-2.0 \
     file://pkg/mod/github.com/emicklei/go-restful/v3@v3.13.0/LICENSE;md5=2ebc1c12a0f4eae5394522e31961e1de;spdx=MIT \
     file://pkg/mod/github.com/evanw/esbuild@v0.28.2/LICENSE.md;md5=46b907b175628fe6d2a5258b252970fa;spdx=MIT \
     file://pkg/mod/github.com/evanw/esbuild@v0.28.2/internal/xxhash/LICENSE.txt;md5=802da049c92a99b4387d3f3d91b00fa9;spdx=MIT \
     file://pkg/mod/github.com/expr-lang/expr@v1.17.8/LICENSE;md5=1cad8446548a7b361129ccfca629db1a;spdx=MIT \
     file://pkg/mod/github.com/fatih/color@v1.19.0/LICENSE.md;md5=316e6d590bdcde7993fb175662c0dd5a;spdx=MIT \
-    file://pkg/mod/github.com/felixge/httpsnoop@v1.0.4/LICENSE.txt;md5=684da2bf3eed8fc8860e75ad84638225;spdx=MIT \
+    file://pkg/mod/github.com/felixge/httpsnoop@v1.1.0/LICENSE.txt;md5=684da2bf3eed8fc8860e75ad84638225;spdx=MIT \
     file://pkg/mod/github.com/fsnotify/fsnotify@v1.10.1/LICENSE;md5=8bae8b116e2cfd723492b02d9a212fe2;spdx=BSD-3-Clause \
     file://pkg/mod/github.com/fxamacker/cbor/v2@v2.9.1/LICENSE;md5=827f5a2fa861382d35a3943adf9ebb86;spdx=MIT \
     file://pkg/mod/github.com/gabriel-vasile/mimetype@v1.4.13/LICENSE;md5=df3ca1fbe5632f81387306d9558a61c4;spdx=MIT \
-    file://pkg/mod/github.com/getkin/kin-openapi@v0.147.0/LICENSE;md5=cc9b47b0408dc7dc785675c4e1566da6;spdx=MIT \
+    file://pkg/mod/github.com/getkin/kin-openapi@v0.151.0/LICENSE;md5=cc9b47b0408dc7dc785675c4e1566da6;spdx=MIT \
     file://pkg/mod/github.com/gin-contrib/gzip@v1.2.3/LICENSE;md5=b4a9ad063c97e6fe4a23e1b81f761e60;spdx=MIT \
     file://pkg/mod/github.com/gin-contrib/sse@v1.1.1/LICENSE;md5=2e674b99ec94fcbd735f85c03ab8d74f;spdx=MIT \
     file://pkg/mod/github.com/gin-gonic/gin@v1.11.0/LICENSE;md5=2e674b99ec94fcbd735f85c03ab8d74f;spdx=MIT \
@@ -87,31 +87,31 @@ LIC_FILES_CHKSUM += "\
     file://pkg/mod/github.com/go-json-experiment/json@v0.0.0-20260214004413-d219187c3433/LICENSE;md5=9d210c7471ce08e3db5261f33bf8fce6;spdx=BSD-3-Clause \
     file://pkg/mod/github.com/go-logr/logr@v1.4.3/LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e;spdx=Apache-2.0 \
     file://pkg/mod/github.com/go-logr/stdr@v1.2.2/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/analysis@v0.26.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/errors@v0.22.8/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/analysis@v1.0.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/errors@v0.22.9/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
     file://pkg/mod/github.com/go-openapi/inflect@v0.21.5/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/jsonpointer@v1.0.0/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/jsonreference@v1.0.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/loads@v0.25.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/spec@v0.22.9/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/strfmt@v0.27.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/swag/cmdutils@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/swag/conv@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/swag/fileutils@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/swag/jsonutils@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/swag/loading@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/swag/mangling@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/swag/netutils@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/swag/pools@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/swag/stringutils@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/swag/typeutils@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/swag/yamlutils@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/swag@v0.28.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/go-openapi/validate@v0.26.3/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/jsonpointer@v1.0.1/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/jsonreference@v1.0.1/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/loads@v0.25.2/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/spec@v1.0.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/strfmt@v0.27.4/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/cmdutils@v0.29.2/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/conv@v0.29.2/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/fileutils@v0.29.2/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/jsonutils@v0.29.2/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/loading@v0.29.2/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/mangling@v0.29.2/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/netutils@v0.29.2/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/pools@v0.29.2/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/stringutils@v0.29.2/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/typeutils@v0.29.2/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag/yamlutils@v0.29.2/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/swag@v0.29.2/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/go-openapi/validate@v1.0.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
     file://pkg/mod/github.com/go-playground/locales@v0.14.1/LICENSE;md5=3ccbda375ee345400ad1da85ba522301;spdx=MIT \
     file://pkg/mod/github.com/go-playground/universal-translator@v0.18.1/LICENSE;md5=2e2b21ef8f61057977d27c727c84bef1;spdx=MIT \
     file://pkg/mod/github.com/go-playground/validator/v10@v10.30.2/LICENSE;md5=a718a0f318d76f7c5d510cbae84f0b60;spdx=MIT \
-    file://pkg/mod/github.com/go-sql-driver/mysql@v1.10.0/LICENSE;md5=815ca599c9df247a0c7f619bab123dad;spdx=MPL-2.0 \
+    file://pkg/mod/github.com/go-sql-driver/mysql@v1.10.1/LICENSE;md5=815ca599c9df247a0c7f619bab123dad;spdx=MPL-2.0 \
     file://pkg/mod/github.com/go-viper/mapstructure/v2@v2.5.0/LICENSE;md5=3f7765c3d4f58e1f84c4313cecf0f5bd;spdx=MIT \
     file://pkg/mod/github.com/goccy/go-yaml@v1.19.2/LICENSE;md5=346470d8ac0a6ffe1eb8635a452cec2b;spdx=MIT \
     file://pkg/mod/github.com/golang/protobuf@v1.5.4/LICENSE;md5=939cce1ec101726fa754e698ac871622;spdx=BSD-3-Clause \
@@ -147,11 +147,11 @@ LIC_FILES_CHKSUM += "\
     file://pkg/mod/github.com/kaptinlin/jsonschema@v0.7.7/LICENSE;md5=e3b2d8cc7672cf690c51b9d067795763;spdx=MIT \
     file://pkg/mod/github.com/kaptinlin/messageformat-go@v0.4.19/LICENSE;md5=3261cc78e02c58c0eed7ae2ed7a8bdc9;spdx=MIT \
     file://pkg/mod/github.com/kballard/go-shellquote@v0.0.0-20180428030007-95032a82bc51/LICENSE;md5=9d95d1ad917c814c23909addb8692eeb;spdx=MIT \
-    file://pkg/mod/github.com/klauspost/compress@v1.19.1/LICENSE;md5=d0fd9ebda39468b51ff4539c9fbb13a8;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/klauspost/compress@v1.19.1/internal/snapref/LICENSE;md5=b8b79c7d4cda128290b98c6a21f9aac6;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/klauspost/compress@v1.19.1/s2/LICENSE;md5=2460814a2b25a7277556c2d89de915d1;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/klauspost/compress@v1.19.1/snappy/LICENSE;md5=b8b79c7d4cda128290b98c6a21f9aac6;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/klauspost/compress@v1.19.1/zstd/internal/xxhash/LICENSE.txt;md5=802da049c92a99b4387d3f3d91b00fa9;spdx=MIT \
+    file://pkg/mod/github.com/klauspost/compress@v1.20.1/LICENSE;md5=d0fd9ebda39468b51ff4539c9fbb13a8;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/klauspost/compress@v1.20.1/internal/snapref/LICENSE;md5=b8b79c7d4cda128290b98c6a21f9aac6;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/klauspost/compress@v1.20.1/s2/LICENSE;md5=2460814a2b25a7277556c2d89de915d1;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/klauspost/compress@v1.20.1/snappy/LICENSE;md5=b8b79c7d4cda128290b98c6a21f9aac6;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/klauspost/compress@v1.20.1/zstd/internal/xxhash/LICENSE.txt;md5=802da049c92a99b4387d3f3d91b00fa9;spdx=MIT \
     file://pkg/mod/github.com/leodido/go-urn@v1.4.0/LICENSE;md5=8f50db5538ec1148a9b3d14ed96c3418;spdx=MIT \
     file://pkg/mod/github.com/mattn/go-colorable@v0.1.14/LICENSE;md5=24ce168f90aec2456a73de1839037245;spdx=MIT \
     file://pkg/mod/github.com/mattn/go-isatty@v0.0.24/LICENSE;md5=f509beadd5a11227c27b5d2ad6c9f2c6;spdx=MIT \
@@ -162,8 +162,8 @@ LIC_FILES_CHKSUM += "\
     file://pkg/mod/github.com/mitchellh/go-wordwrap@v1.0.1/LICENSE.md;md5=56da355a12d4821cda57b8f23ec34bc4;spdx=MIT \
     file://pkg/mod/github.com/mitchellh/reflectwalk@v1.0.2/LICENSE;md5=3f7765c3d4f58e1f84c4313cecf0f5bd;spdx=MIT \
     file://pkg/mod/github.com/moby/docker-image-spec@v1.3.1/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/moby/moby/api@v1.55.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/moby/moby/client@v0.5.1/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/moby/moby/api@v1.56.1/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/moby/moby/client@v0.6.2/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
     file://pkg/mod/github.com/modern-go/concurrent@v0.0.0-20180306012644-bacd9c7ef1dd/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
     file://pkg/mod/github.com/modern-go/reflect2@v1.0.3-0.20250322232337-35a7c28c31ee/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
     file://pkg/mod/github.com/mohae/deepcopy@v0.0.0-20170929034955-c48cc78d4826/LICENSE;md5=268dc9c546e3de67a93c1d12a039d702;spdx=MIT \
@@ -172,7 +172,7 @@ LIC_FILES_CHKSUM += "\
     file://pkg/mod/github.com/oasdiff/yaml3@v0.0.14/LICENSE;md5=3c91c17266710e16afdbb2b6d15c761c;spdx=Apache-2.0 \
     file://pkg/mod/github.com/oasdiff/yaml@v0.1.1/LICENSE;md5=0ceb9ff3b27d3a8cf451ca3785d73c71;spdx=MIT \
     file://pkg/mod/github.com/oklog/run@v1.2.0/LICENSE;md5=c19dbea2f4885137f8d45fede9891755;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/oklog/ulid/v2@v2.1.1/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/oklog/ulid/v2@v2.1.2/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
     file://pkg/mod/github.com/opencontainers/go-digest@v1.0.0/LICENSE;md5=2d6fc0e85c3f118af64c85a78d56d3cf;spdx=Apache-2.0 \
     file://pkg/mod/github.com/opencontainers/image-spec@v1.1.1/LICENSE;md5=27ef03aa2da6e424307f102e8b42621d;spdx=Apache-2.0 \
     file://pkg/mod/github.com/oschwald/geoip2-golang@v1.13.0/LICENSE;md5=7ff10cf9f9802aa6a69c6a73d03742c4;spdx=ISC \
@@ -181,11 +181,11 @@ LIC_FILES_CHKSUM += "\
     file://pkg/mod/github.com/petar-dambovaliev/aho-corasick@v0.0.0-20250424160509-463d218d4745/LICENSE;md5=79da2eab36bdb4ea5e3b7ef4e5d19825;spdx=MIT \
     file://pkg/mod/github.com/pierrec/lz4/v4@v4.1.26/LICENSE;md5=09ece85f3c312a63b522bfc6ebd44943;spdx=BSD-3-Clause \
     file://pkg/mod/github.com/pmezard/go-difflib@v1.0.1-0.20181226105442-5d4384ee4fb2/LICENSE;md5=e9a2ebb8de779a07500ddecca806145e;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/prometheus/client_golang@v1.24.1/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/prometheus/client_golang@v1.24.1/internal/github.com/golang/gddo/LICENSE;md5=4c728948788b1a02f33ae4e906546eef;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/prometheus/client_model@v0.6.2/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/prometheus/common@v0.70.1/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
-    file://pkg/mod/github.com/prometheus/procfs@v0.21.1/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/prometheus/client_golang@v1.25.0/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/prometheus/client_golang@v1.25.0/internal/github.com/golang/gddo/LICENSE;md5=4c728948788b1a02f33ae4e906546eef;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/prometheus/client_model@v0.6.3/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/prometheus/common@v0.72.1/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/prometheus/procfs@v0.22.0/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
     file://pkg/mod/github.com/quic-go/qpack@v0.6.0/LICENSE.md;md5=d670bcd1510d5f6c013032947d36132b;spdx=MIT \
     file://pkg/mod/github.com/quic-go/quic-go@v0.59.1/LICENSE;md5=357080a3c7c0a7c4e23100893c301235;spdx=MIT \
     file://pkg/mod/github.com/r3labs/diff/v2@v2.15.1/LICENSE;md5=9741c346eef56131163e13b9db1241b3;spdx=MPL-2.0 \
@@ -194,10 +194,10 @@ LIC_FILES_CHKSUM += "\
     file://pkg/mod/github.com/sanity-io/litter@v1.5.8/LICENSE;md5=a1cb9e8d77e4fbf4cf17a15a53cfb72b;spdx=MIT \
     file://pkg/mod/github.com/santhosh-tekuri/jsonschema/v6@v6.0.3/LICENSE;md5=3eb31626add6ada64ff9ac772bd3c653;spdx=Apache-2.0 \
     file://pkg/mod/github.com/segmentio/kafka-go@v0.4.51/LICENSE;md5=245177e51c68aa2071d537392357ab87;spdx=MIT \
-    file://pkg/mod/github.com/shirou/gopsutil/v4@v4.26.7/LICENSE;md5=ae6de3dee02712a1e55b280671be53bf;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/shirou/gopsutil/v4@v4.26.9/LICENSE;md5=ae6de3dee02712a1e55b280671be53bf;spdx=BSD-3-Clause \
     file://pkg/mod/github.com/shopspring/decimal@v1.4.0/LICENSE;md5=d21d25475326cf7f1b36eef8c9789801;spdx=MIT \
-    file://pkg/mod/github.com/sirupsen/logrus@v1.10.0/LICENSE;md5=8dadfef729c08ec4e631c4f6fc5d43a0;spdx=MIT \
-    file://pkg/mod/github.com/slack-go/slack@v0.29.0/LICENSE;md5=5be3e17d84b16d39bb01b55af9d8a913;spdx=BSD-2-Clause \
+    file://pkg/mod/github.com/sirupsen/logrus@v1.10.2/LICENSE;md5=8dadfef729c08ec4e631c4f6fc5d43a0;spdx=MIT \
+    file://pkg/mod/github.com/slack-go/slack@v0.30.1/LICENSE;md5=5be3e17d84b16d39bb01b55af9d8a913;spdx=BSD-2-Clause \
     file://pkg/mod/github.com/spf13/cast@v1.10.0/LICENSE;md5=67fac7567cbf6ba946e5576d590b1ed4;spdx=MIT \
     file://pkg/mod/github.com/spf13/cobra@v1.10.2/LICENSE.txt;md5=920d76114a32b0fb75b3f2718c5a91be;spdx=Apache-2.0 \
     file://pkg/mod/github.com/spf13/pflag@v1.0.10/LICENSE;md5=1e8b7dc8b906737639131047a590f21d;spdx=BSD-3-Clause \
@@ -205,36 +205,36 @@ LIC_FILES_CHKSUM += "\
     file://pkg/mod/github.com/tidwall/gjson@v1.18.0/LICENSE;md5=f1ccda76a282fada49760e27335f1c28;spdx=MIT \
     file://pkg/mod/github.com/tidwall/match@v1.2.0/LICENSE;md5=f1ccda76a282fada49760e27335f1c28;spdx=MIT \
     file://pkg/mod/github.com/tidwall/pretty@v1.2.1/LICENSE;md5=898bc94f87439245e8cf1c5797098e90;spdx=MIT \
-    file://pkg/mod/github.com/tklauser/go-sysconf@v0.3.16/LICENSE;md5=d4eb2084b3083d2c275ec52ef4ba9ac1;spdx=BSD-3-Clause \
-    file://pkg/mod/github.com/tklauser/numcpus@v0.11.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/github.com/tklauser/go-sysconf@v0.4.0/LICENSE;md5=d4eb2084b3083d2c275ec52ef4ba9ac1;spdx=BSD-3-Clause \
+    file://pkg/mod/github.com/tklauser/numcpus@v0.12.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
     file://pkg/mod/github.com/toorop/go-dkim@v0.0.0-20250226130143-9025cce95817/LICENSE;md5=c1f71ecc29f9b25806e07f9f45ce9089;spdx=MIT \
     file://pkg/mod/github.com/ugorji/go/codec@v1.3.1/LICENSE;md5=f39cb00aceeac4bc5f861dc07456d5d5;spdx=MIT \
     file://pkg/mod/github.com/umahmood/haversine@v0.0.0-20151105152445-808ab04add26/LICENSE.md;md5=878ae7dec555c1bf7626a69eaa5eeed1;spdx=MIT \
     file://pkg/mod/github.com/valllabh/ocsf-schema-golang@v1.0.3/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
     file://pkg/mod/github.com/vmihailenco/msgpack@v4.0.4+incompatible/LICENSE;md5=5de50b60705d666cd9542dd48d5e4b56;spdx=BSD-2-Clause \
-    file://pkg/mod/github.com/wasilibs/go-re2@v1.12.0/LICENSE;md5=7cce3e5a10534670a924d9206dd18716;spdx=MIT \
+    file://pkg/mod/github.com/wasilibs/go-re2@v1.13.0/LICENSE;md5=7cce3e5a10534670a924d9206dd18716;spdx=MIT \
     file://pkg/mod/github.com/x448/float16@v0.8.4/LICENSE;md5=de8f8e025d57fe7ee0b67f30d571323b;spdx=MIT \
     file://pkg/mod/github.com/xhit/go-simple-mail/v2@v2.16.0/LICENSE;md5=2f9ea4621bcff112a477b70f86730128;spdx=MIT \
     file://pkg/mod/github.com/youmark/pkcs8@v0.0.0-20240726163527-a2c0da244d78/LICENSE;md5=7e949f736d1222f15e83233702459f41;spdx=MIT \
     file://pkg/mod/github.com/zclconf/go-cty-yaml@v1.2.0/LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e;spdx=Apache-2.0 \
     file://pkg/mod/github.com/zclconf/go-cty@v1.18.0/LICENSE;md5=5fa044db97ab139f0b76ceeca0e5a3d5;spdx=MIT \
     file://pkg/mod/go.opentelemetry.io/auto/sdk@v1.2.1/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327;spdx=Apache-2.0 \
-    file://pkg/mod/go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp@v0.68.0/LICENSE;md5=24dad3abbe7a8f390afc8ab967bfefa7;spdx=Apache-2.0 \
+    file://pkg/mod/go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp@v0.69.0/LICENSE;md5=24dad3abbe7a8f390afc8ab967bfefa7;spdx=Apache-2.0 \
     file://pkg/mod/go.opentelemetry.io/otel/metric@v1.44.0/LICENSE;md5=24dad3abbe7a8f390afc8ab967bfefa7;spdx=Apache-2.0 \
     file://pkg/mod/go.opentelemetry.io/otel/trace@v1.44.0/LICENSE;md5=24dad3abbe7a8f390afc8ab967bfefa7;spdx=Apache-2.0 \
     file://pkg/mod/go.opentelemetry.io/otel@v1.44.0/LICENSE;md5=24dad3abbe7a8f390afc8ab967bfefa7;spdx=Apache-2.0 \
     file://pkg/mod/go.yaml.in/yaml/v2@v2.4.4/LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e;spdx=Apache-2.0 \
     file://pkg/mod/go.yaml.in/yaml/v3@v3.0.5/LICENSE;md5=3c91c17266710e16afdbb2b6d15c761c;spdx=Apache-2.0 \
-    file://pkg/mod/golang.org/x/crypto@v0.55.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
-    file://pkg/mod/golang.org/x/mod@v0.40.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
-    file://pkg/mod/golang.org/x/net@v0.58.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
-    file://pkg/mod/golang.org/x/oauth2@v0.36.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
-    file://pkg/mod/golang.org/x/sync@v0.22.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
-    file://pkg/mod/golang.org/x/sys@v0.47.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
-    file://pkg/mod/golang.org/x/term@v0.45.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
-    file://pkg/mod/golang.org/x/text@v0.41.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
-    file://pkg/mod/google.golang.org/genproto/googleapis/rpc@v0.0.0-20260526163538-3dc84a4a5aaa/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/google.golang.org/grpc@v1.83.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/golang.org/x/crypto@v0.58.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
+    file://pkg/mod/golang.org/x/mod@v0.42.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
+    file://pkg/mod/golang.org/x/net@v0.61.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
+    file://pkg/mod/golang.org/x/oauth2@v0.37.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
+    file://pkg/mod/golang.org/x/sync@v0.24.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
+    file://pkg/mod/golang.org/x/sys@v0.49.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
+    file://pkg/mod/golang.org/x/term@v0.47.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
+    file://pkg/mod/golang.org/x/text@v0.43.0/LICENSE;md5=7998cb338f82d15c0eff93b7004d272a;spdx=BSD-3-Clause \
+    file://pkg/mod/google.golang.org/genproto/googleapis/rpc@v0.0.0-20260706201446-f0a921348800/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/google.golang.org/grpc@v1.84.0/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
     file://pkg/mod/google.golang.org/protobuf@v1.36.12/LICENSE;md5=02d4002e9171d41a8fad93aa7faf3956;spdx=BSD-3-Clause \
     file://pkg/mod/gopkg.in/evanphx/json-patch.v4@v4.13.0/LICENSE;md5=96ae735ca1b4dcdb6b26f4ca4b8ba645;spdx=BSD-3-Clause \
     file://pkg/mod/gopkg.in/inf.v0@v0.9.1/LICENSE;md5=13cea479df204c85485b5db6eb1bc9d5;spdx=BSD-3-Clause \
@@ -243,20 +243,20 @@ LIC_FILES_CHKSUM += "\
     file://pkg/mod/gopkg.in/tomb.v2@v2.0.0-20161208151619-d5d1b5820637/LICENSE;md5=95d4102f39f26da9b66fee5d05ac597b;spdx=BSD-3-Clause \
     file://pkg/mod/gopkg.in/yaml.v2@v2.4.0/LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e;spdx=Apache-2.0 \
     file://pkg/mod/gopkg.in/yaml.v3@v3.0.1/LICENSE;md5=3c91c17266710e16afdbb2b6d15c761c;spdx=Apache-2.0 \
-    file://pkg/mod/k8s.io/api@v0.36.3/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/k8s.io/apimachinery@v0.36.3/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/k8s.io/apimachinery@v0.36.3/third_party/forked/golang/LICENSE;md5=5d4950ecb7b26d2c5e4e7b4e0dd74707;spdx=BSD-3-Clause \
-    file://pkg/mod/k8s.io/apiserver@v0.36.3/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/k8s.io/client-go@v0.36.3/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/k8s.io/api@v0.37.1/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/k8s.io/apimachinery@v0.37.1/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/k8s.io/apimachinery@v0.37.1/third_party/forked/golang/LICENSE;md5=5d4950ecb7b26d2c5e4e7b4e0dd74707;spdx=BSD-3-Clause \
+    file://pkg/mod/k8s.io/apiserver@v0.37.1/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/k8s.io/client-go@v0.37.1/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
     file://pkg/mod/k8s.io/klog/v2@v2.140.0/LICENSE;md5=19cbd64715b51267a47bf3750cc6a8a5;spdx=Apache-2.0 \
-    file://pkg/mod/k8s.io/kube-openapi@v0.0.0-20260330154417-16be699c7b31/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/k8s.io/kube-openapi@v0.0.0-20260330154417-16be699c7b31/pkg/internal/third_party/go-json-experiment/json/LICENSE;md5=9d210c7471ce08e3db5261f33bf8fce6;spdx=BSD-3-Clause \
-    file://pkg/mod/k8s.io/kube-openapi@v0.0.0-20260330154417-16be699c7b31/pkg/validation/spec/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/k8s.io/utils@v0.0.0-20260319190234-28399d86e0b5/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
-    file://pkg/mod/k8s.io/utils@v0.0.0-20260319190234-28399d86e0b5/internal/third_party/forked/golang/LICENSE;md5=591778525c869cdde0ab5a1bf283cd81;spdx=BSD-3-Clause \
+    file://pkg/mod/k8s.io/kube-openapi@v0.0.0-20260721132016-d427ff9ee9ad/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/k8s.io/kube-openapi@v0.0.0-20260721132016-d427ff9ee9ad/pkg/internal/third_party/go-json-experiment/json/LICENSE;md5=9d210c7471ce08e3db5261f33bf8fce6;spdx=BSD-3-Clause \
+    file://pkg/mod/k8s.io/kube-openapi@v0.0.0-20260721132016-d427ff9ee9ad/pkg/validation/spec/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/k8s.io/utils@v0.0.0-20260626114624-be93311217bd/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57;spdx=Apache-2.0 \
+    file://pkg/mod/k8s.io/utils@v0.0.0-20260626114624-be93311217bd/internal/third_party/forked/golang/LICENSE;md5=591778525c869cdde0ab5a1bf283cd81;spdx=BSD-3-Clause \
     file://pkg/mod/rsc.io/binaryregexp@v0.2.0/LICENSE;md5=5d4950ecb7b26d2c5e4e7b4e0dd74707;spdx=BSD-3-Clause \
     file://pkg/mod/sigs.k8s.io/json@v0.0.0-20250730193827-2d320260d730/LICENSE;md5=545d3f23616dee7495323aeb0b098df3;spdx=Apache-2.0 \
     file://pkg/mod/sigs.k8s.io/randfill@v1.0.0/LICENSE;md5=8f245a894b7d4f5880176fafd88faad8;spdx=Apache-2.0 \
-    file://pkg/mod/sigs.k8s.io/structured-merge-diff/v6@v6.3.3/LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e;spdx=Apache-2.0 \
+    file://pkg/mod/sigs.k8s.io/structured-merge-diff/v6@v6.4.2/LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e;spdx=Apache-2.0 \
     file://pkg/mod/sigs.k8s.io/yaml@v1.6.0/LICENSE;md5=b5d30dd5bc47d1b56b678ac06dead1c7;spdx=MIT \
 "
diff --git a/recipes-ids/crowdsec/crowdsec_1.8.1.bb b/recipes-ids/crowdsec/crowdsec_1.8.2.bb
similarity index 96%
rename from recipes-ids/crowdsec/crowdsec_1.8.1.bb
rename to recipes-ids/crowdsec/crowdsec_1.8.2.bb
index 1ea794a..357d4bf 100644
--- a/recipes-ids/crowdsec/crowdsec_1.8.1.bb
+++ b/recipes-ids/crowdsec/crowdsec_1.8.2.bb
@@ -13,7 +13,7 @@ LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=1e58fe4126ce0b50677f3aa6
 CROWDSEC_BRANCH_VERSION = "${@'.'.join(d.getVar('PV').split('.')[0:2])}"
 SRC_URI = "gitsm://${GO_IMPORT};protocol=https;branch=releases/${CROWDSEC_BRANCH_VERSION}.x;tag=v${PV};destsuffix=${GO_SRCURI_DESTSUFFIX}"
 
-SRCREV = "909b5157986a2b2c2163300fdaef5ed01289f7d2"
+SRCREV = "3d369d64eb3e9ba770ed39aedc83ffd3170aef4c"
 
 require ${BPN}-licenses.inc
 require ${BPN}-go-mods.inc
-- 
2.47.3

