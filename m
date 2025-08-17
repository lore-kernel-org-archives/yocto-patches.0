Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F47CA0EF2
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 17:29:51 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.web11.56797.1755451790355304193
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 10:29:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=VN8FgaK8;
 spf=pass (domain: konsulko.com, ip: 209.85.160.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b1219f25aeso13641961cf.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755451789; x=1756056589; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBQhBsIyxqUnRBWRmelv6Dv+W3GIx3qQx2uDojchQNs=;
        b=VN8FgaK8+SuILqa7ZCwHLZF1jlmHueniWM74bX0WNYmbB+PpfTGPIqRvdnrnsNLQwU
         5aR+hp7Y9BvPN+JkTJ45m+xgPs6t+EOHvNcym+Wcw0ULEEhiMKHf51LkkRB21s3jaRiv
         1L+ioBaDWSpoqTyWjNvBakCzoyGRaVMAT26Ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755451789; x=1756056589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBQhBsIyxqUnRBWRmelv6Dv+W3GIx3qQx2uDojchQNs=;
        b=ebTtk05uzE89/M2tH/idJUC6PUb7jGMO4iUJmMUCxE2AF32YiNuLyJYWvuML0avi2r
         h+e2R95LWUIgyTmgmuHLppGc0JtgEO8Odx/x1qJl7JT1QgSiNBZgmEuiXLqA+GjLH49j
         vl5AojIpZSOb3xajLSMK8lV9Mlauw0NgZBRgKVn4cds6/U8bD7svIBvEapga4wN25VaB
         YeC4jm5u6hHs/LXch/nSA2ey+ArzMAmv2BuHXV6TNAwRv93u6x3AXtIkScedftbgOFNh
         A8oIW0ayBBEBvq7aa+FO7H5x74PryoKSMbOts1BNm70/i5Lnp0gSBfiQTqW1HEF6U06W
         ebtw==
X-Gm-Message-State: AOJu0Yw6JEh/GrOoZxJcQJS707+09bPpJPO1nHm1He/9iEdmV4HHgZsm
	aI9CurIITNjJ4iwExtVSxTyPzx7pBBplyVpLLLWebTvrK7gLxW/4p7H1PxLXOAbHl0+eNZ61343
	pDOOF
X-Gm-Gg: ASbGncuT/lbz36al3zwLBV7SFKl9qvViEmbFV4DXWJUVtu11fCZHKxYAzHBl238QUDm
	ywaEG8INDwBAB4n4x3bkGaSayL4U3EkvVdz6ejLVu+4V6x2D5PLSG4wRMVaIyHR8sM1JZXI2BBN
	glaPu6MPWfAyRJUD3EXBA5NsDRYo5kkzMtHUVeirFMJO3hO1TSLPBg3nXbKeI20lT5lSWS15uLS
	mQnF0eqjEz1MiGALlgPJ0P+lFIydBKaU9t5UpvDqYl+w+glk+tz9WAFVwgFF6uc2FpY8Mnirqxx
	jPmwK6J7cRpz5vCRzodcfMoSPOrTGxM7Q6pVCi9s4krdEY0Zk1a9xRSEY6tLYlqqXxq60pzfWsV
	c4ygdYwLBzEGf3Tz02opCZl0nLDtMVdM+sqijKnNbI23F3KtJpWJp+PAKjcyqNd8kEdIIZCZTTw
	==
X-Google-Smtp-Source: AGHT+IHOBIhEGO+NLvjfPz7qA+Wzxg0wrYG7WaDIIXeE5KMs7zfwdVwOa0SAluQkadBKhNz1l/XSRw==
X-Received: by 2002:a05:622a:6:b0:4b0:7d41:df7a with SMTP id d75a77b69052e-4b12a79e7a1mr78709731cf.56.1755451788507;
        Sun, 17 Aug 2025 10:29:48 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc18a0esm39626271cf.9.2025.08.17.10.29.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 10:29:48 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 4/7] libstd-rs: Fix build regression on rv32
Date: Sun, 17 Aug 2025 13:29:28 -0400
Message-ID: <409009f530bd331a9e5b93e2e3a7105f9d988e74.1755451486.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755451486.git.scott.murray@konsulko.com>
References: <cover.1755451486.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 17:29:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2008

From: Khem Raj <raj.khem@gmail.com>

This started to fail with rust 1.88, due to rust libc
upgrade

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit f9145bc8bec77e1f454f80c4e5576567daa99ac8)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...lain-syscalls-as-their-time64-varian.patch | 49 +++++++++++++++++++
 recipes-devtools/rust/rust-source.inc         |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 recipes-devtools/rust/files/0001-riscv32-Define-plain-s=
yscalls-as-their-time64-varian.patch

diff --git a/recipes-devtools/rust/files/0001-riscv32-Define-plain-syscalls=
-as-their-time64-varian.patch b/recipes-devtools/rust/files/0001-riscv32-De=
fine-plain-syscalls-as-their-time64-varian.patch
new file mode 100644
index 0000000..933b7ad
--- /dev/null
+++ b/recipes-devtools/rust/files/0001-riscv32-Define-plain-syscalls-as-the=
ir-time64-varian.patch
@@ -0,0 +1,49 @@
+From fa39d5b1ba475d4ffed59e3eb14d21df24cc4a3a Mon Sep 17 00:00:00 2001
+From: Khem Raj <raj.khem@gmail.com>
+Date: Sat, 2 Aug 2025 12:49:42 -0700
+Subject: [PATCH] riscv32: Define plain syscalls as their time64 variants
+
+RISCV32 is "time64-only" from the beginning on the kernel side.
+
+Based on musl change [1]
+
+[1] https://git.musl-libc.org/cgit/musl/commit/?id=3D4bbd7baea7c8538b3fb8e=
30f7b022a1eee071450
+
+Upstream-Status: Submitted [https://github.com/rust-lang/libc/pull/4612]
+Signed-off-by: Khem Raj <raj.khem@gmail.com>
+---
+ .../linux_like/linux/musl/b32/riscv32/mod.rs  | 19 +++++++++++++++++++
+ 1 file changed, 19 insertions(+)
+
+--- a/vendor/libc-0.2.172/src/unix/linux_like/linux/musl/b32/riscv32/mod.rs
++++ b/vendor/libc-0.2.172/src/unix/linux_like/linux/musl/b32/riscv32/mod.rs
+@@ -633,3 +633,23 @@ pub const SYS_faccessat2: c_long =3D 439;
+ pub const SYS_process_madvise: c_long =3D 440;
+ pub const SYS_epoll_pwait2: c_long =3D 441;
+ pub const SYS_mount_setattr: c_long =3D 442;
++
++// Plain syscalls aliased their time64 variants
++pub const SYS_clock_gettime: c_long =3D SYS_clock_gettime64;
++pub const SYS_clock_settime: c_long =3D SYS_clock_settime64;
++pub const SYS_clock_adjtime: c_long =3D SYS_clock_adjtime64;
++pub const SYS_clock_getres: c_long =3D SYS_clock_getres_time64;
++pub const SYS_clock_nanosleep: c_long =3D SYS_clock_nanosleep_time64;
++pub const SYS_timer_gettime: c_long =3D SYS_timer_gettime64;
++pub const SYS_timer_settime: c_long =3D SYS_timer_settime64;
++pub const SYS_timerfd_gettime: c_long =3D SYS_timerfd_gettime64;
++pub const SYS_timerfd_settime: c_long =3D SYS_timerfd_settime64;
++pub const SYS_utimensat: c_long =3D SYS_utimensat_time64;
++pub const SYS_pselect6: c_long =3D SYS_pselect6_time64;
++pub const SYS_ppoll: c_long =3D SYS_ppoll_time64;
++pub const SYS_recvmmsg: c_long =3D SYS_recvmmsg_time64;
++pub const SYS_mq_timedsend: c_long =3D SYS_mq_timedsend_time64;
++pub const SYS_mq_timedreceive: c_long =3D SYS_mq_timedreceive_time64;
++pub const SYS_rt_sigtimedwait: c_long =3D SYS_rt_sigtimedwait_time64;
++pub const SYS_futex: c_long =3D SYS_futex_time64;
++pub const SYS_sched_rr_get_interval: c_long =3D SYS_sched_rr_get_interval=
_time64;
+--- a/vendor/libc-0.2.172/.cargo-checksum.json
++++ b/vendor/libc-0.2.172/.cargo-checksum.json
+@@ -1 +1 @@
+-{"files":{"CHANGELOG.md":"346dd2531ef95edd4f55cdbd1bae011599905025ccb8c49=
9ab2f0906a7e1e9f4","CONTRIBUTING.md":"155e7f4e96fafe9ee5c8adb5068be27a22de8=
9a95ca9bfc7baf517b9850d20d6","Cargo.lock":"56c4dfee156428a661f3351c2c7c91bb=
499b79f7a37617b3735d2d4a34d0e92a","Cargo.toml":"56ad89d6913657901ac241f5d2f=
f433e1f7aabc5e565494b8dea2970101fd4d4","LICENSE-APACHE":"62c7a1e35f56406896=
d7aa7ca52d0cc0d272ac022b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca2=
56f56a8932dba07660672dbfe3004257ca8de708aac1415937a1","README.md":"a198be44=
4453fe0b24d4fb6a8b732eb9e6dc77ebcfd119fca95b97b45c77c77a","build.rs":"e7d33=
b16dfe94388f70255bd0d009ca43fbdfd83981c09b58b6b776202f52a8a","rustfmt.toml"=
:"e9321ff995242e8cb0a4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fu=
chsia/aarch64.rs":"9cd032304a54321a8926cf3157194c5d79a2491b1b974a05fe71729f=
a43b5738","src/fuchsia/mod.rs":"e27680db23fa506e379a86033b42813ea1f6c8f6b01=
d97a9a880d9d7be6d9f7f","src/fuchsia/riscv64.rs":"f2aba92cb88480bd72a9eb7a41=
aafc63c5db293b93113fa973fe5ab1fd819e29","src/fuchsia/x86_64.rs":"66c6ae7d3f=
81b1d7c962671aa074d709c39069e3b5830621a26d94c15caf588f","src/hermit.rs":"f1=
50c2882a4d8e510259697ff7685899e74bfabf84e5d37103c54b4387093775","src/lib.rs=
":"d65975abfeac27f8dbef348fa7afa0b2b761a0a7073f4621c1bbff41334983cd","src/m=
acros.rs":"076f328df1d51017bac70456e7b8290bee1b07390328fff48102e05048ada56a=
","src/primitives.rs":"0096ec3f32454a630fd1e78fa5aaaa033f107c1394a0d7b8dfe9=
2594339a547b","src/psp.rs":"b88f5659011db6a189bd06de3a365c35a34cec6b7ab5477=
19b8ae2b371f9cb21","src/sgx.rs":"964d6af358f5c85f948275090e5a7854e0169c43b5=
c338070b6a4cd156ebc9e6","src/solid/aarch64.rs":"4d4236500f98858fc249f3b6858=
af5009851c8c582031926b8195b2646f7da5e","src/solid/arm.rs":"4d4236500f98858f=
c249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/solid/mod.rs":"a2045=
b6089af91bd533a666773d3b99fcfaf03da7a06869382969eed059b0e4c","src/switch.rs=
":"bfdcaf0268d79652ee52c1a2837959b8253e6a4124fd94dda82727ecc442a758","src/t=
eeos/mod.rs":"2cca695904dacb13c063fb6463a6e0b2bb47ed86be0fdc9476938297441d7=
795","src/trusty.rs":"c5012aeefc4307c11374f062ad1d530e2ec556e7069e375de326a=
49c77f65e22","src/unix/aix/mod.rs":"fa3fa1f33e381f9492321e47f683300460d02fa=
230f14965ee808eeab2884408","src/unix/aix/powerpc64.rs":"c2315d638bad020e75e=
f15f85989f8feffb4f38bac4b7e70642031c6ae1fb65d","src/unix/bsd/apple/b32/mod.=
rs":"39a7f5cf92cf2d26ca50f54182fe57028cf24147ec12cb89d251301d65862138","src=
/unix/bsd/apple/b64/aarch64/mod.rs":"3ce904e72d78e6465ca52fd3905208fbb8cbc4=
9a1695a708b12dff2ee01f4d36","src/unix/bsd/apple/b64/mod.rs":"a77ef659cd2eda=
db39db562e655ea5efdb102ed0dfb872d8d004b38d1a0e9e49","src/unix/bsd/apple/b64=
/x86_64/mod.rs":"71bad5c051368805146168c4063534b010afcb358477c1f164712bb015=
bf3fb6","src/unix/bsd/apple/mod.rs":"39216bfe363384709f0b38df6b333206ad8536=
1e6b1389f699b2b88d46aa3e1f","src/unix/bsd/freebsdlike/dragonfly/errno.rs":"=
07b19390b9ae8f541ac35fd4e14685d639b95152d6d7a33814bb749b8b927298","src/unix=
/bsd/freebsdlike/dragonfly/mod.rs":"9681882d03a9cc7e00db0d9f0be797426ce4e9f=
7584d3fe4ab43bc7967dd0e4e","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"9=
e8e5a9f1de648b248f257aab6e1bc8ccfe9e481554a52bdef06aefd262a15a2","src/unix/=
bsd/freebsdlike/freebsd/arm.rs":"36158ac5a31d86a919d8e477a9ba64467d38b57bc3=
910e19b082130811c2f289","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs"=
:"8d9bef35f3e490d04755a59a99ad054ef20498beff979ae8b14acbec1097318a","src/un=
ix/bsd/freebsdlike/freebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14af=
ae7261827ec4838d26719290466efc4f023","src/unix/bsd/freebsdlike/freebsd/free=
bsd11/mod.rs":"0f7a9de19f343c4370352df77c4d6a6a5458e17ea5ca4da5e18c53674aa3=
6b10","src/unix/bsd/freebsdlike/freebsd/freebsd12/mod.rs":"0b3272b2a05fd59e=
f486aeb4d97effa5800ac4240fddc1123cd9a78a75cce3d3","src/unix/bsd/freebsdlike=
/freebsd/freebsd12/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa=
14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":"=
b55b4a4953da9240b243edc31863b395e2d9b271517d609e19d6d4038c9ad373","src/unix=
/bsd/freebsdlike/freebsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fce=
28de7d1b0743bfaa14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/fre=
ebsd14/mod.rs":"05a9cdf865fab149ec928b376714620a1056a76148dbc5f0b83cdf9c95d=
28357","src/unix/bsd/freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e109=
dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsd=
like/freebsd/freebsd15/mod.rs":"2875230f93fc3597cc9d05f1695ad79a0ff75e4dd80=
8ab81ee9422ef2d506cc7","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.r=
s":"d6e66809e109dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/=
unix/bsd/freebsdlike/freebsd/mod.rs":"4d778397e727c3aec520feff75c023d7e5b7e=
dc83b45ff4efac750a8c79f8857","src/unix/bsd/freebsdlike/freebsd/powerpc.rs":=
"36a03b20551864c92852e967ebf91c6a8105fd520e41a35273e2dc6487590267","src/uni=
x/bsd/freebsdlike/freebsd/powerpc64.rs":"3de9344db84572975b5965ac4292cf475e=
3c96854c58b7a478b9972407ffd1fd","src/unix/bsd/freebsdlike/freebsd/riscv64.r=
s":"3dfdc394922c2cb66790309c76913576a7235513ad3bf9d8bd86b8671e284ff0","src/=
unix/bsd/freebsdlike/freebsd/x86.rs":"2521db73acc14867b2e16aa05dd55cc48a765=
0d2773a009b269bbceafd819fac","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.r=
s":"85b4b6118ef4e08a74b8cc17d364b22949b2e05e642e3240e14f2651a2126d18","src/=
unix/bsd/freebsdlike/mod.rs":"eda51316ba108b78c3f6c383cb047855dbd04f5b4bb59=
d04e0f2978722c68101","src/unix/bsd/mod.rs":"c69855551561c4beeaed5ada823404c=
9b9d27e9e21c0e4bafb6f1b52ad09ad2b","src/unix/bsd/netbsdlike/mod.rs":"ef9b61=
7c42084db1bd3aa4f5d5d1a75ce1963b23945c117b6076400905ff75ec","src/unix/bsd/n=
etbsdlike/netbsd/aarch64.rs":"bd36c92099db501350fb8617414d1fea89a6bb1286749=
8e1821167813ab70a02","src/unix/bsd/netbsdlike/netbsd/arm.rs":"237beaefcb12e=
7be9ccd4fef6e3be7db79ee63d4fc714e5eaf6084d4826d6fa2","src/unix/bsd/netbsdli=
ke/netbsd/mips.rs":"d1ff114b268358e5d35e7b83d85f414d16b81ef39eeb1802682ff44=
24b102bc7","src/unix/bsd/netbsdlike/netbsd/mod.rs":"204060e49293270f8201672=
2f1e5d8de35635b4ee745830319583f8f79bb0973","src/unix/bsd/netbsdlike/netbsd/=
powerpc.rs":"94494f348f011c6135d301944696c5b5a09979f5892abee4c8fdee1056388b=
94","src/unix/bsd/netbsdlike/netbsd/riscv64.rs":"f3778a9bd2ba923220537d167c=
fb10b91580ffbf583100789a46d2807f7a1e3e","src/unix/bsd/netbsdlike/netbsd/spa=
rc64.rs":"d50816e830225779ac9e9a55a7e3e097882153d72987061d76a96ee736c8af9c"=
,"src/unix/bsd/netbsdlike/netbsd/x86.rs":"307a9aba68071b0589e459269ef10845c=
302599b0fd2b0ee7b5c480177904e89","src/unix/bsd/netbsdlike/netbsd/x86_64.rs"=
:"4ced76b3640d465f6dead8beb5e947b3ce8297884260fb943d5f417d985dbafc","src/un=
ix/bsd/netbsdlike/openbsd/aarch64.rs":"8be46bc5151ec1081feaf7685c18507f766f=
2501a2b5d35107db3babb896395a","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f81=
c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3a30d68691d71c7449","src/unix/bs=
d/netbsdlike/openbsd/mips64.rs":"bee7664d88f8451ae22552fc0721b6b6a6dee2493c=
c42bcb9829c1e47e4b05f5","src/unix/bsd/netbsdlike/openbsd/mod.rs":"dd9e56c95=
e324e90e3a7c8905c593025f65c36e98c9f95eb0e033ea04e6d949f","src/unix/bsd/netb=
sdlike/openbsd/powerpc.rs":"f81c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3=
a30d68691d71c7449","src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"9bd3813f=
e2fd7ca66ee8d70d13887b4595fb8c9e819691a657ddf108ed9cafbf","src/unix/bsd/net=
bsdlike/openbsd/riscv64.rs":"7fb322e9f5425456dd53eb07de9fc84097ef35295802e8=
f50a7fb3c7e1f89ac6","src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"8d4c5a4ca=
e63e09e1c156164ddc82e0fc77926841d4d4e419dd2e7a7b7145f58","src/unix/bsd/netb=
sdlike/openbsd/x86.rs":"26c1b7e7f7799c5e434126c6c0ddd45f40939cae4151f8ce0a7=
a1836f83ac56a","src/unix/bsd/netbsdlike/openbsd/x86_64.rs":"312b77a50ee47f1=
07e9cfd8e7e7e0d4945675a859d7286fedbf192840f8a4c34","src/unix/cygwin/mod.rs"=
:"8f122bd9fd1fa155045ceddf59eca1b0d221b0616932dd0c32241fc68190c32a","src/un=
ix/haiku/b32.rs":"c3f8678ceee65a3094d8133b0d1a94470860e0b1867977f0569c52c5a=
20e039f","src/unix/haiku/b64.rs":"f97ce9225f4710893dab03ab3e13bc62152cc84f9=
0c597ec88f6dc1f4c27d242","src/unix/haiku/mod.rs":"991e5ab02e8607ece273e66ab=
8303dc7604488bf7e0b7533fdb69ea9adef83df","src/unix/haiku/native.rs":"fafc7d=
aab134d37ed260373f9c3a8177cc0fd88ba147c1001b9867eb9bd0799b","src/unix/haiku=
/x86_64.rs":"4480c0423eac3f288202df587b54025292633869a868bd0ac2767cd40afb51=
73","src/unix/hurd/b32.rs":"501f426f7aeb60acf4119064100dd94bbdfebff2cec7854=
28708059d853dc123","src/unix/hurd/b64.rs":"b9b2082e721a5ec89ba55fd5a16bbffc=
c8a05ca7cef6dbfbd78aff0806cb931f","src/unix/hurd/mod.rs":"4bc76f612d215300d=
01bd36bb5e6541cddbe62858571328a03c6b7bb8a208262","src/unix/linux_like/andro=
id/b32/arm.rs":"06dfde862400151e3a667650d73c8ac8ea9c3c44c5401ef2b2406b2cca4=
a8672","src/unix/linux_like/android/b32/mod.rs":"2df9e7337f299a12890bccca59=
d65619aa5a53991aa2c0c33b4fc49b64c3c93d","src/unix/linux_like/android/b32/x8=
6/mod.rs":"ad5942e15c6603469e82144076c4837e9daebb40d0195865e7d574e6433136d0=
","src/unix/linux_like/android/b64/aarch64/mod.rs":"5ae558c8af8187155fa0ae8=
b8776459a60c08ce152f25d137f845d8371673b7e","src/unix/linux_like/android/b64=
/mod.rs":"f92637aaf3edb4612d178789d76245cec213cfaaaed3903fcc96814cfc1bb0b5"=
,"src/unix/linux_like/android/b64/riscv64/mod.rs":"d826b0e4f078b8ea228f2244=
659fc700b95aa8a7ba87caef0bc34f54c9defd2c","src/unix/linux_like/android/b64/=
x86_64/mod.rs":"cab0e8cc6895e7af9e631196b2484e7ccb3bdf5b0a134ab14abb626eef8=
b2a3e","src/unix/linux_like/android/mod.rs":"aaa1ec4759870e9be989cc1dde94fa=
8b0faf88b914b938c86ddbcc7146515220","src/unix/linux_like/emscripten/lfs64.r=
s":"3a1d1779bcf16525a578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/=
unix/linux_like/emscripten/mod.rs":"356db0bbc7ee5c23cc79fc15add48febaf2976b=
0780a3c430b2f098715e4153a","src/unix/linux_like/linux/arch/generic/mod.rs":=
"ecfca2e786d13fd5971a851bdafffade5b4236e82fe50b91451f29b9c30bc07a","src/uni=
x/linux_like/linux/arch/mips/mod.rs":"ade92c3257971feb2e2fe201586c7ad7459dc=
1fd9db2b6aa525db11764d20f94","src/unix/linux_like/linux/arch/mod.rs":"8bc58=
98b03760a95dd4f124ac76ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linu=
x_like/linux/arch/powerpc/mod.rs":"ca5e83ce5f0e6c7ef7f575dcc27a5669b64b759a=
e0871c13b91fce43ad152351","src/unix/linux_like/linux/arch/sparc/mod.rs":"97=
35216185ae78271e8333f8e8199480244d1a269b27b430f480a7b75c219c50","src/unix/l=
inux_like/linux/gnu/b32/arm/mod.rs":"2a1f81db43e602471526a72bf8c28cd3aa58f8=
fa8bd7a4e49bf0e143a8d87649","src/unix/linux_like/linux/gnu/b32/csky/mod.rs"=
:"e1c53b84e1c13d91d94a44da0c3f120788c135d4253834782db57cccf0a39db4","src/un=
ix/linux_like/linux/gnu/b32/m68k/mod.rs":"4e8eaf62fefaaa57842259b47b21f02e2=
1f299975a6d82a64729506781259e43","src/unix/linux_like/linux/gnu/b32/mips/mo=
d.rs":"7b70846d26c4daef8d35504dcbd4e4fec03ec9aa875f5898812e1913e7d3456f","s=
rc/unix/linux_like/linux/gnu/b32/mod.rs":"5cd2b221f9c5bafb6c8bb741c42df8281=
f53c32c042a33f94a4a33391a595ab7","src/unix/linux_like/linux/gnu/b32/powerpc=
.rs":"27fe942d85f2a22b09994fd6bc0b3b4c80f1deeb01b1c06b6e83718ae59e01eb","sr=
c/unix/linux_like/linux/gnu/b32/riscv32/mod.rs":"e5882e019997612fac4fe83991=
5dbef9b2bcc1bea5484efa4a2664a339fa5e14","src/unix/linux_like/linux/gnu/b32/=
sparc/mod.rs":"1589a8a4b55ef4924378fb12b91bc964f076dafbf0abef7dfa71b0f48721=
8ba4","src/unix/linux_like/linux/gnu/b32/x86/mod.rs":"cf5ba28b6ddf0c5a46310=
d51eebd386e12e8595874e99fd9ee0e5df86e8933d6","src/unix/linux_like/linux/gnu=
/b64/aarch64/ilp32.rs":"638b2d717dcf5b59a0058c3dabab43edd84de9d1d7da6e16ad0=
c58e863000417","src/unix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"28c11e7=
0467b2f00735d3a04c369e96e04fd44d0587ee33359f38328b0677ee6","src/unix/linux_=
like/linux/gnu/b64/aarch64/mod.rs":"335b220e43cd07c3f6a262fe161fb057dea6324=
ab8ad41cd419bc596e16cd640","src/unix/linux_like/linux/gnu/b64/loongarch64/m=
od.rs":"425047046086c6be01d35b6c630f70c560a58be772704329e0aae23102f7db51","=
src/unix/linux_like/linux/gnu/b64/mips64/mod.rs":"05c9fa18fb781f775d7fba891=
6b756752612590168ddc127315a0fcbbd5d8ad3","src/unix/linux_like/linux/gnu/b64=
/mod.rs":"d1d38f4a25d885be350bc6fdfa4a633a180717d60392010c40ec2c3899fc4d42"=
,"src/unix/linux_like/linux/gnu/b64/powerpc64/mod.rs":"8ea4a284cfb48c23ffa1=
a5dba69ac2e6433109ec00260dc3ffb241aec5219473","src/unix/linux_like/linux/gn=
u/b64/riscv64/mod.rs":"c20634c01c22d0d618d0f6d555f35eb339f4e75fd6491cb4a773=
92b48e1b2265","src/unix/linux_like/linux/gnu/b64/s390x.rs":"67cad067e292b4d=
8cc0743adb4506f02c53bdf3c2e935fbfc1467a88451c645b","src/unix/linux_like/lin=
ux/gnu/b64/sparc64/mod.rs":"8cbfa0d9c67893b18e836a7e9b70076dcbcb06386575fc2=
61f2b8a9fefd2caa7","src/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"10fcc=
444c2550be09ccf7a4231024b8af4acd6024de81da110ad932b62707698","src/unix/linu=
x_like/linux/gnu/b64/x86_64/not_x32.rs":"07240332eaf44996d86e37b12d71b519b4=
99c9c9b57898441c58ac2e8c0cb6f7","src/unix/linux_like/linux/gnu/b64/x86_64/x=
32.rs":"914898b781dfe6b2f755730d6000223d1beea177731e180ccbfdd84a0b8b3bd9","=
src/unix/linux_like/linux/gnu/mod.rs":"2e5d89b25f1e29e24702bfd2c2032ca3f571=
4c5b8a01fea7ba3b5781cbe4421e","src/unix/linux_like/linux/mod.rs":"4c2ba076e=
cf8c14e6f07659cfbc5e49ba7063da8201b7af657a7cb8a00e56b4a","src/unix/linux_li=
ke/linux/musl/b32/arm/mod.rs":"6368f45ada05676c98a394194e715756760eabff9721=
0d2d65a1c6e7104d63ce","src/unix/linux_like/linux/musl/b32/hexagon.rs":"4004=
57049bad619da3accbca2c841206d1cd2673d670baf7210bf17427510271","src/unix/lin=
ux_like/linux/musl/b32/mips/mod.rs":"fa47a3a9614ec2a964e99d30cde2d2dd4f0401=
5e6c4dcf3b3e3061a7538bd7c7","src/unix/linux_like/linux/musl/b32/mod.rs":"e0=
f53df7ca1dbe9b0b25ccecf1adf664227995e58d67a222a8d046d2a879dfc8","src/unix/l=
inux_like/linux/musl/b32/powerpc.rs":"e850aef52e8e4c9a807fd356d38fd54e4072b=
126bddea758cb01854d49fb7ea7","src/unix/linux_like/linux/musl/b32/riscv32/mo=
d.rs":"13335be149517d72bacf8cb4cc1a54a17217f2436daeca4f9646379d40bd6c6a","s=
rc/unix/linux_like/linux/musl/b32/x86/mod.rs":"1c9a0687f6aa318ce59882314718=
aff0bfe01967fe3bf1fde5e5e38b7363c153","src/unix/linux_like/linux/musl/b64/a=
arch64/mod.rs":"ef117d729a168607bc7ddbf6fa1289e62233b50cf154237151ba1ee8422=
08178","src/unix/linux_like/linux/musl/b64/loongarch64/mod.rs":"3075639f373=
78774f3991f05971a9b725766105e5884b1e97b3889b079f95514","src/unix/linux_like=
/linux/musl/b64/mips64.rs":"abf1eb14fff4dd1bdf081672ab92858e99c09666583d8f9=
952112da13036e50e","src/unix/linux_like/linux/musl/b64/mod.rs":"be9250db1c0=
1bc412b3e13a0d41102e58a3de28d0f59786c6cc6c2da8849bbea","src/unix/linux_like=
/linux/musl/b64/powerpc64.rs":"606be7895a1578916b2b1f1d01518307d46b79a9c64d=
239a37dc8693af697466","src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"=
a76a7a24d52f2fc3811d72f69e9a369d0547bdee166a5a943b94396e320b077c","src/unix=
/linux_like/linux/musl/b64/s390x.rs":"ffbfdefb58d27d6463757a256b1480b83e53b=
19fc0f9c7fc1af461be33fae359","src/unix/linux_like/linux/musl/b64/wasm32/mod=
.rs":"f44f7b2ade822aa468f4abd6ba3f1ce86d6ffd307c4b4eb50684156458abd137","sr=
c/unix/linux_like/linux/musl/b64/wasm32/wali.rs":"69e0d06289f1c86898ef3ab50=
5e397af2acce146accb62efff654fe458b6af02","src/unix/linux_like/linux/musl/b6=
4/x86_64/mod.rs":"a317282fb504c35a83e0de335caa01c09f8f9b2649d1250dbcedb1ebf=
0f75e7f","src/unix/linux_like/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2=
d02946f84ae83e8f5cb0e789d8d3e76c1923a5d31","src/unix/linux_like/linux/musl/=
mod.rs":"f5dfcb0b4bc2a2290004d292dfc867b0cffbb315cfb27fffe6b033da6e7b8fb1",=
"src/unix/linux_like/linux/uclibc/arm/mod.rs":"32d3701fa086b2a98589b4ae4842=
ce62b295bc0bd9eaf1b5f9792e442b681090","src/unix/linux_like/linux/uclibc/mip=
s/mips32/mod.rs":"59493f1ab84ddbcf9dc5881c9cfc26e28d4fb5322d63f60eb7de5f9e8=
e329580","src/unix/linux_like/linux/uclibc/mips/mips64/mod.rs":"a35532d5ae3=
76f403873aa566f37bff99c6c323d334f3201667e5f7200b04643","src/unix/linux_like=
/linux/uclibc/mips/mod.rs":"ead3f9c05e3bdd5d5b52f25dd4a2d154471555a6bae2d4c=
bd5c07e976513dcea","src/unix/linux_like/linux/uclibc/mod.rs":"b9c04b66adfae=
4c03c41038c43b374847e2109673b92a6cdbab8c157d6c53561","src/unix/linux_like/l=
inux/uclibc/x86_64/l4re.rs":"059d1f15bf84e2226be6b842dc9466fc5f5bf55cdeed7a=
8742658ff25f05361c","src/unix/linux_like/linux/uclibc/x86_64/mod.rs":"c3775=
2975c173aeb1641bae0e743ff2e7600976620bcb6e9ee8e74a40355d186","src/unix/linu=
x_like/linux/uclibc/x86_64/other.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf=
3da0619436169c12cadc4093def","src/unix/linux_like/mod.rs":"183cd281f404e8d6=
4563383343216e90f604c0250f501cd994352eef843ebf43","src/unix/mod.rs":"77a977=
37d394fa7b293068fffa1554e08a8a484a40de985a865e61b6f694cab8","src/unix/newli=
b/aarch64/mod.rs":"ec594c54dc0e7784668d02ef737fd194dcc3f1e6ee23328d810fd245=
3bcb6f20","src/unix/newlib/arm/mod.rs":"a1fb6caa077c2ed69adf12da07c814ffab4=
c1311579f23bae2b26a40cf180665","src/unix/newlib/espidf/mod.rs":"77e8ad5b7db=
027b8b0b5aa5126f15bc0e35b6f3deb2339acf403c961f13df26f","src/unix/newlib/gen=
eric.rs":"182e584f14e0984934130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd"=
,"src/unix/newlib/horizon/mod.rs":"ae4e76ef8c04fa8580578e33037bcf1888a8e4d6=
88aa6f115713f644b8a11313","src/unix/newlib/mod.rs":"2f3e9c6217994ec34b0e3b4=
9bf5ebe1335f3b12146f7f55a797ea7041cb1f44c","src/unix/newlib/powerpc/mod.rs"=
:"4e5f804a13e907e17ebb66dcbf3b0fe6e1a611f91876aad8d8a0a69c7df0a7e8","src/un=
ix/newlib/rtems/mod.rs":"239c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4=
a22b861f82713a","src/unix/newlib/vita/mod.rs":"66765c20482f03c3fcb57d57dd3f=
31eeeab9729e1bb188191ad53a8fc124fc5f","src/unix/nto/aarch64.rs":"73ad54ebca=
13454a75c7b0815e853175070a8ac2eefa338012a03e8b59f01e0c","src/unix/nto/mod.r=
s":"9cfcdbb158f3c9b86b49b7dd09a455fbeca63033c3613cf308d591491b4a2379","src/=
unix/nto/neutrino.rs":"039ab7b1ed702d515f3e06d7f3536709704715a49905024b6c52=
0696a65086f9","src/unix/nto/x86_64.rs":"8da99138e210516a95d49c8c0265eada4c5=
f7b93d59be86224844410f5e7929b","src/unix/nuttx/mod.rs":"8cecb644d89e7808c0a=
a3adcce005021018db93f814be34fd4f8823e26cdd22e","src/unix/redox/mod.rs":"a5a=
fadfc34e33ace8bd4154e471fa5ee0fc9b5f10f3942ded4f2c1488cea1c4e","src/unix/so=
larish/compat.rs":"dd69c8e180a9472e4800d27f725f2baee8de2b7e1575fa5323b55fe4=
d20b676c","src/unix/solarish/illumos.rs":"d2a2e13e9859c8b85fa1d076fc1b56e6f=
be1f94c2d5c5c26d634e38bbb81004b","src/unix/solarish/mod.rs":"ec4c1dce83e853=
1df71b89e4aee1ab4d3b3b18d1b6d34b03d94573144c40e7c5","src/unix/solarish/sola=
ris.rs":"ffc34e8c4049588195ddd6b7471ac2fb2c3ce3eee8fe66e7bc30e4ce84bd0c43",=
"src/unix/solarish/x86.rs":"44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515=
b9820c9421cff7427","src/unix/solarish/x86_64.rs":"1601309baae50ccfd51b5d188=
668e6ac5dabc4e8d2ffde103592922ec15295ef","src/unix/solarish/x86_common.rs":=
"4ae02d88622f7f080f5e8cd328f13187edbc5e124fb3e05e4cf212597f6cce48","src/vxw=
orks/aarch64.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b264=
6f7da5e","src/vxworks/arm.rs":"4d4236500f98858fc249f3b6858af5009851c8c58203=
1926b8195b2646f7da5e","src/vxworks/mod.rs":"3c76cbae4e7da4026cc0790b1be230c=
f4cad6637c45a4022af297a1056e9c192","src/vxworks/powerpc.rs":"4d4236500f9885=
8fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks/powerpc64.=
rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src=
/vxworks/riscv32.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09=
a277dc3302a","src/vxworks/riscv64.rs":"b1f933205800f0da00f975d53b18fe0035e0=
75cc4613acf110a09a277dc3302a","src/vxworks/x86.rs":"b1f933205800f0da00f975d=
53b18fe0035e075cc4613acf110a09a277dc3302a","src/vxworks/x86_64.rs":"b1f9332=
05800f0da00f975d53b18fe0035e075cc4613acf110a09a277dc3302a","src/wasi/mod.rs=
":"cac5127894b50bd1880e87b54ae0cbc9afe98f99ee739f74aec04172c14bcc1a","src/w=
asi/p2.rs":"feecc0485eabd2c32bc5d800df6ad1b9b4d282741342fb08792f2635204e1e0=
8","src/windows/gnu/mod.rs":"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb3=
9f6514c28dffd8ac9f","src/windows/mod.rs":"6be16eea8c7319c35e7efc6a70da8a04f=
9ab25d68173c51d561f37a0935de47c","src/windows/msvc/mod.rs":"7bc0f1e7e738152=
96cd6b63b2700e12624e9f47b5c4113a1a87fae8e64549c00","src/xous.rs":"1a83621c4=
0248ad4d0c08e1fd4c1107d5efcbc2f4f0169538b7b4a885abedbfa","tests/const_fn.rs=
":"8ac3171d7bced3576a4e93f48570b3e00c553d7510ab85a7473ae3b716a812dc"},"pack=
age":"d750af042f7ef4f724306de029d18836c26c1765a54a6a3f094cbd23a7267ffa"}
+\ No newline at end of file
++{"files":{"CHANGELOG.md":"346dd2531ef95edd4f55cdbd1bae011599905025ccb8c49=
9ab2f0906a7e1e9f4","CONTRIBUTING.md":"155e7f4e96fafe9ee5c8adb5068be27a22de8=
9a95ca9bfc7baf517b9850d20d6","Cargo.lock":"56c4dfee156428a661f3351c2c7c91bb=
499b79f7a37617b3735d2d4a34d0e92a","Cargo.toml":"56ad89d6913657901ac241f5d2f=
f433e1f7aabc5e565494b8dea2970101fd4d4","LICENSE-APACHE":"62c7a1e35f56406896=
d7aa7ca52d0cc0d272ac022b5d2796e7d6905db8a3636a","LICENSE-MIT":"a8d47ff51ca2=
56f56a8932dba07660672dbfe3004257ca8de708aac1415937a1","README.md":"a198be44=
4453fe0b24d4fb6a8b732eb9e6dc77ebcfd119fca95b97b45c77c77a","build.rs":"e7d33=
b16dfe94388f70255bd0d009ca43fbdfd83981c09b58b6b776202f52a8a","rustfmt.toml"=
:"e9321ff995242e8cb0a4984254f0748ef11a89ca4618cab8f047ee59a88768e7","src/fu=
chsia/aarch64.rs":"9cd032304a54321a8926cf3157194c5d79a2491b1b974a05fe71729f=
a43b5738","src/fuchsia/mod.rs":"e27680db23fa506e379a86033b42813ea1f6c8f6b01=
d97a9a880d9d7be6d9f7f","src/fuchsia/riscv64.rs":"f2aba92cb88480bd72a9eb7a41=
aafc63c5db293b93113fa973fe5ab1fd819e29","src/fuchsia/x86_64.rs":"66c6ae7d3f=
81b1d7c962671aa074d709c39069e3b5830621a26d94c15caf588f","src/hermit.rs":"f1=
50c2882a4d8e510259697ff7685899e74bfabf84e5d37103c54b4387093775","src/lib.rs=
":"d65975abfeac27f8dbef348fa7afa0b2b761a0a7073f4621c1bbff41334983cd","src/m=
acros.rs":"076f328df1d51017bac70456e7b8290bee1b07390328fff48102e05048ada56a=
","src/primitives.rs":"0096ec3f32454a630fd1e78fa5aaaa033f107c1394a0d7b8dfe9=
2594339a547b","src/psp.rs":"b88f5659011db6a189bd06de3a365c35a34cec6b7ab5477=
19b8ae2b371f9cb21","src/sgx.rs":"964d6af358f5c85f948275090e5a7854e0169c43b5=
c338070b6a4cd156ebc9e6","src/solid/aarch64.rs":"4d4236500f98858fc249f3b6858=
af5009851c8c582031926b8195b2646f7da5e","src/solid/arm.rs":"4d4236500f98858f=
c249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/solid/mod.rs":"a2045=
b6089af91bd533a666773d3b99fcfaf03da7a06869382969eed059b0e4c","src/switch.rs=
":"bfdcaf0268d79652ee52c1a2837959b8253e6a4124fd94dda82727ecc442a758","src/t=
eeos/mod.rs":"2cca695904dacb13c063fb6463a6e0b2bb47ed86be0fdc9476938297441d7=
795","src/trusty.rs":"c5012aeefc4307c11374f062ad1d530e2ec556e7069e375de326a=
49c77f65e22","src/unix/aix/mod.rs":"fa3fa1f33e381f9492321e47f683300460d02fa=
230f14965ee808eeab2884408","src/unix/aix/powerpc64.rs":"c2315d638bad020e75e=
f15f85989f8feffb4f38bac4b7e70642031c6ae1fb65d","src/unix/bsd/apple/b32/mod.=
rs":"39a7f5cf92cf2d26ca50f54182fe57028cf24147ec12cb89d251301d65862138","src=
/unix/bsd/apple/b64/aarch64/mod.rs":"3ce904e72d78e6465ca52fd3905208fbb8cbc4=
9a1695a708b12dff2ee01f4d36","src/unix/bsd/apple/b64/mod.rs":"a77ef659cd2eda=
db39db562e655ea5efdb102ed0dfb872d8d004b38d1a0e9e49","src/unix/bsd/apple/b64=
/x86_64/mod.rs":"71bad5c051368805146168c4063534b010afcb358477c1f164712bb015=
bf3fb6","src/unix/bsd/apple/mod.rs":"39216bfe363384709f0b38df6b333206ad8536=
1e6b1389f699b2b88d46aa3e1f","src/unix/bsd/freebsdlike/dragonfly/errno.rs":"=
07b19390b9ae8f541ac35fd4e14685d639b95152d6d7a33814bb749b8b927298","src/unix=
/bsd/freebsdlike/dragonfly/mod.rs":"9681882d03a9cc7e00db0d9f0be797426ce4e9f=
7584d3fe4ab43bc7967dd0e4e","src/unix/bsd/freebsdlike/freebsd/aarch64.rs":"9=
e8e5a9f1de648b248f257aab6e1bc8ccfe9e481554a52bdef06aefd262a15a2","src/unix/=
bsd/freebsdlike/freebsd/arm.rs":"36158ac5a31d86a919d8e477a9ba64467d38b57bc3=
910e19b082130811c2f289","src/unix/bsd/freebsdlike/freebsd/freebsd11/b32.rs"=
:"8d9bef35f3e490d04755a59a99ad054ef20498beff979ae8b14acbec1097318a","src/un=
ix/bsd/freebsdlike/freebsd/freebsd11/b64.rs":"45f718f556a8368f282944d9a14af=
ae7261827ec4838d26719290466efc4f023","src/unix/bsd/freebsdlike/freebsd/free=
bsd11/mod.rs":"0f7a9de19f343c4370352df77c4d6a6a5458e17ea5ca4da5e18c53674aa3=
6b10","src/unix/bsd/freebsdlike/freebsd/freebsd12/mod.rs":"0b3272b2a05fd59e=
f486aeb4d97effa5800ac4240fddc1123cd9a78a75cce3d3","src/unix/bsd/freebsdlike=
/freebsd/freebsd12/x86_64.rs":"64c4bd82eaf30a2681417f982fce28de7d1b0743bfaa=
14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/freebsd13/mod.rs":"=
b55b4a4953da9240b243edc31863b395e2d9b271517d609e19d6d4038c9ad373","src/unix=
/bsd/freebsdlike/freebsd/freebsd13/x86_64.rs":"64c4bd82eaf30a2681417f982fce=
28de7d1b0743bfaa14004692a56cee44be21","src/unix/bsd/freebsdlike/freebsd/fre=
ebsd14/mod.rs":"05a9cdf865fab149ec928b376714620a1056a76148dbc5f0b83cdf9c95d=
28357","src/unix/bsd/freebsdlike/freebsd/freebsd14/x86_64.rs":"d6e66809e109=
dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/unix/bsd/freebsd=
like/freebsd/freebsd15/mod.rs":"2875230f93fc3597cc9d05f1695ad79a0ff75e4dd80=
8ab81ee9422ef2d506cc7","src/unix/bsd/freebsdlike/freebsd/freebsd15/x86_64.r=
s":"d6e66809e109dc779efe5584b79d34fcd6fdba91973a415d64ae66f481f45940","src/=
unix/bsd/freebsdlike/freebsd/mod.rs":"4d778397e727c3aec520feff75c023d7e5b7e=
dc83b45ff4efac750a8c79f8857","src/unix/bsd/freebsdlike/freebsd/powerpc.rs":=
"36a03b20551864c92852e967ebf91c6a8105fd520e41a35273e2dc6487590267","src/uni=
x/bsd/freebsdlike/freebsd/powerpc64.rs":"3de9344db84572975b5965ac4292cf475e=
3c96854c58b7a478b9972407ffd1fd","src/unix/bsd/freebsdlike/freebsd/riscv64.r=
s":"3dfdc394922c2cb66790309c76913576a7235513ad3bf9d8bd86b8671e284ff0","src/=
unix/bsd/freebsdlike/freebsd/x86.rs":"2521db73acc14867b2e16aa05dd55cc48a765=
0d2773a009b269bbceafd819fac","src/unix/bsd/freebsdlike/freebsd/x86_64/mod.r=
s":"85b4b6118ef4e08a74b8cc17d364b22949b2e05e642e3240e14f2651a2126d18","src/=
unix/bsd/freebsdlike/mod.rs":"eda51316ba108b78c3f6c383cb047855dbd04f5b4bb59=
d04e0f2978722c68101","src/unix/bsd/mod.rs":"c69855551561c4beeaed5ada823404c=
9b9d27e9e21c0e4bafb6f1b52ad09ad2b","src/unix/bsd/netbsdlike/mod.rs":"ef9b61=
7c42084db1bd3aa4f5d5d1a75ce1963b23945c117b6076400905ff75ec","src/unix/bsd/n=
etbsdlike/netbsd/aarch64.rs":"bd36c92099db501350fb8617414d1fea89a6bb1286749=
8e1821167813ab70a02","src/unix/bsd/netbsdlike/netbsd/arm.rs":"237beaefcb12e=
7be9ccd4fef6e3be7db79ee63d4fc714e5eaf6084d4826d6fa2","src/unix/bsd/netbsdli=
ke/netbsd/mips.rs":"d1ff114b268358e5d35e7b83d85f414d16b81ef39eeb1802682ff44=
24b102bc7","src/unix/bsd/netbsdlike/netbsd/mod.rs":"204060e49293270f8201672=
2f1e5d8de35635b4ee745830319583f8f79bb0973","src/unix/bsd/netbsdlike/netbsd/=
powerpc.rs":"94494f348f011c6135d301944696c5b5a09979f5892abee4c8fdee1056388b=
94","src/unix/bsd/netbsdlike/netbsd/riscv64.rs":"f3778a9bd2ba923220537d167c=
fb10b91580ffbf583100789a46d2807f7a1e3e","src/unix/bsd/netbsdlike/netbsd/spa=
rc64.rs":"d50816e830225779ac9e9a55a7e3e097882153d72987061d76a96ee736c8af9c"=
,"src/unix/bsd/netbsdlike/netbsd/x86.rs":"307a9aba68071b0589e459269ef10845c=
302599b0fd2b0ee7b5c480177904e89","src/unix/bsd/netbsdlike/netbsd/x86_64.rs"=
:"4ced76b3640d465f6dead8beb5e947b3ce8297884260fb943d5f417d985dbafc","src/un=
ix/bsd/netbsdlike/openbsd/aarch64.rs":"8be46bc5151ec1081feaf7685c18507f766f=
2501a2b5d35107db3babb896395a","src/unix/bsd/netbsdlike/openbsd/arm.rs":"f81=
c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3a30d68691d71c7449","src/unix/bs=
d/netbsdlike/openbsd/mips64.rs":"bee7664d88f8451ae22552fc0721b6b6a6dee2493c=
c42bcb9829c1e47e4b05f5","src/unix/bsd/netbsdlike/openbsd/mod.rs":"dd9e56c95=
e324e90e3a7c8905c593025f65c36e98c9f95eb0e033ea04e6d949f","src/unix/bsd/netb=
sdlike/openbsd/powerpc.rs":"f81c71e1cfe436b8f32cfe064991019cce0c83627f0d9c3=
a30d68691d71c7449","src/unix/bsd/netbsdlike/openbsd/powerpc64.rs":"9bd3813f=
e2fd7ca66ee8d70d13887b4595fb8c9e819691a657ddf108ed9cafbf","src/unix/bsd/net=
bsdlike/openbsd/riscv64.rs":"7fb322e9f5425456dd53eb07de9fc84097ef35295802e8=
f50a7fb3c7e1f89ac6","src/unix/bsd/netbsdlike/openbsd/sparc64.rs":"8d4c5a4ca=
e63e09e1c156164ddc82e0fc77926841d4d4e419dd2e7a7b7145f58","src/unix/bsd/netb=
sdlike/openbsd/x86.rs":"26c1b7e7f7799c5e434126c6c0ddd45f40939cae4151f8ce0a7=
a1836f83ac56a","src/unix/bsd/netbsdlike/openbsd/x86_64.rs":"312b77a50ee47f1=
07e9cfd8e7e7e0d4945675a859d7286fedbf192840f8a4c34","src/unix/cygwin/mod.rs"=
:"8f122bd9fd1fa155045ceddf59eca1b0d221b0616932dd0c32241fc68190c32a","src/un=
ix/haiku/b32.rs":"c3f8678ceee65a3094d8133b0d1a94470860e0b1867977f0569c52c5a=
20e039f","src/unix/haiku/b64.rs":"f97ce9225f4710893dab03ab3e13bc62152cc84f9=
0c597ec88f6dc1f4c27d242","src/unix/haiku/mod.rs":"991e5ab02e8607ece273e66ab=
8303dc7604488bf7e0b7533fdb69ea9adef83df","src/unix/haiku/native.rs":"fafc7d=
aab134d37ed260373f9c3a8177cc0fd88ba147c1001b9867eb9bd0799b","src/unix/haiku=
/x86_64.rs":"4480c0423eac3f288202df587b54025292633869a868bd0ac2767cd40afb51=
73","src/unix/hurd/b32.rs":"501f426f7aeb60acf4119064100dd94bbdfebff2cec7854=
28708059d853dc123","src/unix/hurd/b64.rs":"b9b2082e721a5ec89ba55fd5a16bbffc=
c8a05ca7cef6dbfbd78aff0806cb931f","src/unix/hurd/mod.rs":"4bc76f612d215300d=
01bd36bb5e6541cddbe62858571328a03c6b7bb8a208262","src/unix/linux_like/andro=
id/b32/arm.rs":"06dfde862400151e3a667650d73c8ac8ea9c3c44c5401ef2b2406b2cca4=
a8672","src/unix/linux_like/android/b32/mod.rs":"2df9e7337f299a12890bccca59=
d65619aa5a53991aa2c0c33b4fc49b64c3c93d","src/unix/linux_like/android/b32/x8=
6/mod.rs":"ad5942e15c6603469e82144076c4837e9daebb40d0195865e7d574e6433136d0=
","src/unix/linux_like/android/b64/aarch64/mod.rs":"5ae558c8af8187155fa0ae8=
b8776459a60c08ce152f25d137f845d8371673b7e","src/unix/linux_like/android/b64=
/mod.rs":"f92637aaf3edb4612d178789d76245cec213cfaaaed3903fcc96814cfc1bb0b5"=
,"src/unix/linux_like/android/b64/riscv64/mod.rs":"d826b0e4f078b8ea228f2244=
659fc700b95aa8a7ba87caef0bc34f54c9defd2c","src/unix/linux_like/android/b64/=
x86_64/mod.rs":"cab0e8cc6895e7af9e631196b2484e7ccb3bdf5b0a134ab14abb626eef8=
b2a3e","src/unix/linux_like/android/mod.rs":"aaa1ec4759870e9be989cc1dde94fa=
8b0faf88b914b938c86ddbcc7146515220","src/unix/linux_like/emscripten/lfs64.r=
s":"3a1d1779bcf16525a578a68237f9854090eae4c9819e18ffb5a288f39be4afbe","src/=
unix/linux_like/emscripten/mod.rs":"356db0bbc7ee5c23cc79fc15add48febaf2976b=
0780a3c430b2f098715e4153a","src/unix/linux_like/linux/arch/generic/mod.rs":=
"ecfca2e786d13fd5971a851bdafffade5b4236e82fe50b91451f29b9c30bc07a","src/uni=
x/linux_like/linux/arch/mips/mod.rs":"ade92c3257971feb2e2fe201586c7ad7459dc=
1fd9db2b6aa525db11764d20f94","src/unix/linux_like/linux/arch/mod.rs":"8bc58=
98b03760a95dd4f124ac76ad92e5ae36b2d0644203d752ef2b37e487c3a","src/unix/linu=
x_like/linux/arch/powerpc/mod.rs":"ca5e83ce5f0e6c7ef7f575dcc27a5669b64b759a=
e0871c13b91fce43ad152351","src/unix/linux_like/linux/arch/sparc/mod.rs":"97=
35216185ae78271e8333f8e8199480244d1a269b27b430f480a7b75c219c50","src/unix/l=
inux_like/linux/gnu/b32/arm/mod.rs":"2a1f81db43e602471526a72bf8c28cd3aa58f8=
fa8bd7a4e49bf0e143a8d87649","src/unix/linux_like/linux/gnu/b32/csky/mod.rs"=
:"e1c53b84e1c13d91d94a44da0c3f120788c135d4253834782db57cccf0a39db4","src/un=
ix/linux_like/linux/gnu/b32/m68k/mod.rs":"4e8eaf62fefaaa57842259b47b21f02e2=
1f299975a6d82a64729506781259e43","src/unix/linux_like/linux/gnu/b32/mips/mo=
d.rs":"7b70846d26c4daef8d35504dcbd4e4fec03ec9aa875f5898812e1913e7d3456f","s=
rc/unix/linux_like/linux/gnu/b32/mod.rs":"5cd2b221f9c5bafb6c8bb741c42df8281=
f53c32c042a33f94a4a33391a595ab7","src/unix/linux_like/linux/gnu/b32/powerpc=
.rs":"27fe942d85f2a22b09994fd6bc0b3b4c80f1deeb01b1c06b6e83718ae59e01eb","sr=
c/unix/linux_like/linux/gnu/b32/riscv32/mod.rs":"e5882e019997612fac4fe83991=
5dbef9b2bcc1bea5484efa4a2664a339fa5e14","src/unix/linux_like/linux/gnu/b32/=
sparc/mod.rs":"1589a8a4b55ef4924378fb12b91bc964f076dafbf0abef7dfa71b0f48721=
8ba4","src/unix/linux_like/linux/gnu/b32/x86/mod.rs":"cf5ba28b6ddf0c5a46310=
d51eebd386e12e8595874e99fd9ee0e5df86e8933d6","src/unix/linux_like/linux/gnu=
/b64/aarch64/ilp32.rs":"638b2d717dcf5b59a0058c3dabab43edd84de9d1d7da6e16ad0=
c58e863000417","src/unix/linux_like/linux/gnu/b64/aarch64/lp64.rs":"28c11e7=
0467b2f00735d3a04c369e96e04fd44d0587ee33359f38328b0677ee6","src/unix/linux_=
like/linux/gnu/b64/aarch64/mod.rs":"335b220e43cd07c3f6a262fe161fb057dea6324=
ab8ad41cd419bc596e16cd640","src/unix/linux_like/linux/gnu/b64/loongarch64/m=
od.rs":"425047046086c6be01d35b6c630f70c560a58be772704329e0aae23102f7db51","=
src/unix/linux_like/linux/gnu/b64/mips64/mod.rs":"05c9fa18fb781f775d7fba891=
6b756752612590168ddc127315a0fcbbd5d8ad3","src/unix/linux_like/linux/gnu/b64=
/mod.rs":"d1d38f4a25d885be350bc6fdfa4a633a180717d60392010c40ec2c3899fc4d42"=
,"src/unix/linux_like/linux/gnu/b64/powerpc64/mod.rs":"8ea4a284cfb48c23ffa1=
a5dba69ac2e6433109ec00260dc3ffb241aec5219473","src/unix/linux_like/linux/gn=
u/b64/riscv64/mod.rs":"c20634c01c22d0d618d0f6d555f35eb339f4e75fd6491cb4a773=
92b48e1b2265","src/unix/linux_like/linux/gnu/b64/s390x.rs":"67cad067e292b4d=
8cc0743adb4506f02c53bdf3c2e935fbfc1467a88451c645b","src/unix/linux_like/lin=
ux/gnu/b64/sparc64/mod.rs":"8cbfa0d9c67893b18e836a7e9b70076dcbcb06386575fc2=
61f2b8a9fefd2caa7","src/unix/linux_like/linux/gnu/b64/x86_64/mod.rs":"10fcc=
444c2550be09ccf7a4231024b8af4acd6024de81da110ad932b62707698","src/unix/linu=
x_like/linux/gnu/b64/x86_64/not_x32.rs":"07240332eaf44996d86e37b12d71b519b4=
99c9c9b57898441c58ac2e8c0cb6f7","src/unix/linux_like/linux/gnu/b64/x86_64/x=
32.rs":"914898b781dfe6b2f755730d6000223d1beea177731e180ccbfdd84a0b8b3bd9","=
src/unix/linux_like/linux/gnu/mod.rs":"2e5d89b25f1e29e24702bfd2c2032ca3f571=
4c5b8a01fea7ba3b5781cbe4421e","src/unix/linux_like/linux/mod.rs":"4c2ba076e=
cf8c14e6f07659cfbc5e49ba7063da8201b7af657a7cb8a00e56b4a","src/unix/linux_li=
ke/linux/musl/b32/arm/mod.rs":"6368f45ada05676c98a394194e715756760eabff9721=
0d2d65a1c6e7104d63ce","src/unix/linux_like/linux/musl/b32/hexagon.rs":"4004=
57049bad619da3accbca2c841206d1cd2673d670baf7210bf17427510271","src/unix/lin=
ux_like/linux/musl/b32/mips/mod.rs":"fa47a3a9614ec2a964e99d30cde2d2dd4f0401=
5e6c4dcf3b3e3061a7538bd7c7","src/unix/linux_like/linux/musl/b32/mod.rs":"e0=
f53df7ca1dbe9b0b25ccecf1adf664227995e58d67a222a8d046d2a879dfc8","src/unix/l=
inux_like/linux/musl/b32/powerpc.rs":"e850aef52e8e4c9a807fd356d38fd54e4072b=
126bddea758cb01854d49fb7ea7","src/unix/linux_like/linux/musl/b32/riscv32/mo=
d.rs":"b076c7f32ef6137e96c50a6e6b45fe4ba0f84ef4505b0094a2afbe0a7b2d92f2","s=
rc/unix/linux_like/linux/musl/b32/x86/mod.rs":"1c9a0687f6aa318ce59882314718=
aff0bfe01967fe3bf1fde5e5e38b7363c153","src/unix/linux_like/linux/musl/b64/a=
arch64/mod.rs":"ef117d729a168607bc7ddbf6fa1289e62233b50cf154237151ba1ee8422=
08178","src/unix/linux_like/linux/musl/b64/loongarch64/mod.rs":"3075639f373=
78774f3991f05971a9b725766105e5884b1e97b3889b079f95514","src/unix/linux_like=
/linux/musl/b64/mips64.rs":"abf1eb14fff4dd1bdf081672ab92858e99c09666583d8f9=
952112da13036e50e","src/unix/linux_like/linux/musl/b64/mod.rs":"be9250db1c0=
1bc412b3e13a0d41102e58a3de28d0f59786c6cc6c2da8849bbea","src/unix/linux_like=
/linux/musl/b64/powerpc64.rs":"606be7895a1578916b2b1f1d01518307d46b79a9c64d=
239a37dc8693af697466","src/unix/linux_like/linux/musl/b64/riscv64/mod.rs":"=
a76a7a24d52f2fc3811d72f69e9a369d0547bdee166a5a943b94396e320b077c","src/unix=
/linux_like/linux/musl/b64/s390x.rs":"ffbfdefb58d27d6463757a256b1480b83e53b=
19fc0f9c7fc1af461be33fae359","src/unix/linux_like/linux/musl/b64/wasm32/mod=
.rs":"f44f7b2ade822aa468f4abd6ba3f1ce86d6ffd307c4b4eb50684156458abd137","sr=
c/unix/linux_like/linux/musl/b64/wasm32/wali.rs":"69e0d06289f1c86898ef3ab50=
5e397af2acce146accb62efff654fe458b6af02","src/unix/linux_like/linux/musl/b6=
4/x86_64/mod.rs":"a317282fb504c35a83e0de335caa01c09f8f9b2649d1250dbcedb1ebf=
0f75e7f","src/unix/linux_like/linux/musl/lfs64.rs":"308c5b5c9b2f4b1ad17e5c2=
d02946f84ae83e8f5cb0e789d8d3e76c1923a5d31","src/unix/linux_like/linux/musl/=
mod.rs":"f5dfcb0b4bc2a2290004d292dfc867b0cffbb315cfb27fffe6b033da6e7b8fb1",=
"src/unix/linux_like/linux/uclibc/arm/mod.rs":"32d3701fa086b2a98589b4ae4842=
ce62b295bc0bd9eaf1b5f9792e442b681090","src/unix/linux_like/linux/uclibc/mip=
s/mips32/mod.rs":"59493f1ab84ddbcf9dc5881c9cfc26e28d4fb5322d63f60eb7de5f9e8=
e329580","src/unix/linux_like/linux/uclibc/mips/mips64/mod.rs":"a35532d5ae3=
76f403873aa566f37bff99c6c323d334f3201667e5f7200b04643","src/unix/linux_like=
/linux/uclibc/mips/mod.rs":"ead3f9c05e3bdd5d5b52f25dd4a2d154471555a6bae2d4c=
bd5c07e976513dcea","src/unix/linux_like/linux/uclibc/mod.rs":"b9c04b66adfae=
4c03c41038c43b374847e2109673b92a6cdbab8c157d6c53561","src/unix/linux_like/l=
inux/uclibc/x86_64/l4re.rs":"059d1f15bf84e2226be6b842dc9466fc5f5bf55cdeed7a=
8742658ff25f05361c","src/unix/linux_like/linux/uclibc/x86_64/mod.rs":"c3775=
2975c173aeb1641bae0e743ff2e7600976620bcb6e9ee8e74a40355d186","src/unix/linu=
x_like/linux/uclibc/x86_64/other.rs":"12f8d4049862fc0c4d94b770f2d0341c1c7bf=
3da0619436169c12cadc4093def","src/unix/linux_like/mod.rs":"183cd281f404e8d6=
4563383343216e90f604c0250f501cd994352eef843ebf43","src/unix/mod.rs":"77a977=
37d394fa7b293068fffa1554e08a8a484a40de985a865e61b6f694cab8","src/unix/newli=
b/aarch64/mod.rs":"ec594c54dc0e7784668d02ef737fd194dcc3f1e6ee23328d810fd245=
3bcb6f20","src/unix/newlib/arm/mod.rs":"a1fb6caa077c2ed69adf12da07c814ffab4=
c1311579f23bae2b26a40cf180665","src/unix/newlib/espidf/mod.rs":"77e8ad5b7db=
027b8b0b5aa5126f15bc0e35b6f3deb2339acf403c961f13df26f","src/unix/newlib/gen=
eric.rs":"182e584f14e0984934130425dd2be0781ca2c131449b3ae1734a07c72c3d43cd"=
,"src/unix/newlib/horizon/mod.rs":"ae4e76ef8c04fa8580578e33037bcf1888a8e4d6=
88aa6f115713f644b8a11313","src/unix/newlib/mod.rs":"2f3e9c6217994ec34b0e3b4=
9bf5ebe1335f3b12146f7f55a797ea7041cb1f44c","src/unix/newlib/powerpc/mod.rs"=
:"4e5f804a13e907e17ebb66dcbf3b0fe6e1a611f91876aad8d8a0a69c7df0a7e8","src/un=
ix/newlib/rtems/mod.rs":"239c90d1daf783ff95168a3fcbc5a0c3d1f9c4b5a0ef32a0e4=
a22b861f82713a","src/unix/newlib/vita/mod.rs":"66765c20482f03c3fcb57d57dd3f=
31eeeab9729e1bb188191ad53a8fc124fc5f","src/unix/nto/aarch64.rs":"73ad54ebca=
13454a75c7b0815e853175070a8ac2eefa338012a03e8b59f01e0c","src/unix/nto/mod.r=
s":"9cfcdbb158f3c9b86b49b7dd09a455fbeca63033c3613cf308d591491b4a2379","src/=
unix/nto/neutrino.rs":"039ab7b1ed702d515f3e06d7f3536709704715a49905024b6c52=
0696a65086f9","src/unix/nto/x86_64.rs":"8da99138e210516a95d49c8c0265eada4c5=
f7b93d59be86224844410f5e7929b","src/unix/nuttx/mod.rs":"8cecb644d89e7808c0a=
a3adcce005021018db93f814be34fd4f8823e26cdd22e","src/unix/redox/mod.rs":"a5a=
fadfc34e33ace8bd4154e471fa5ee0fc9b5f10f3942ded4f2c1488cea1c4e","src/unix/so=
larish/compat.rs":"dd69c8e180a9472e4800d27f725f2baee8de2b7e1575fa5323b55fe4=
d20b676c","src/unix/solarish/illumos.rs":"d2a2e13e9859c8b85fa1d076fc1b56e6f=
be1f94c2d5c5c26d634e38bbb81004b","src/unix/solarish/mod.rs":"ec4c1dce83e853=
1df71b89e4aee1ab4d3b3b18d1b6d34b03d94573144c40e7c5","src/unix/solarish/sola=
ris.rs":"ffc34e8c4049588195ddd6b7471ac2fb2c3ce3eee8fe66e7bc30e4ce84bd0c43",=
"src/unix/solarish/x86.rs":"44261c1f1b300dac9fa0dab93ec85d0c3b3c48b15bc4515=
b9820c9421cff7427","src/unix/solarish/x86_64.rs":"1601309baae50ccfd51b5d188=
668e6ac5dabc4e8d2ffde103592922ec15295ef","src/unix/solarish/x86_common.rs":=
"4ae02d88622f7f080f5e8cd328f13187edbc5e124fb3e05e4cf212597f6cce48","src/vxw=
orks/aarch64.rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b264=
6f7da5e","src/vxworks/arm.rs":"4d4236500f98858fc249f3b6858af5009851c8c58203=
1926b8195b2646f7da5e","src/vxworks/mod.rs":"3c76cbae4e7da4026cc0790b1be230c=
f4cad6637c45a4022af297a1056e9c192","src/vxworks/powerpc.rs":"4d4236500f9885=
8fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src/vxworks/powerpc64.=
rs":"4d4236500f98858fc249f3b6858af5009851c8c582031926b8195b2646f7da5e","src=
/vxworks/riscv32.rs":"b1f933205800f0da00f975d53b18fe0035e075cc4613acf110a09=
a277dc3302a","src/vxworks/riscv64.rs":"b1f933205800f0da00f975d53b18fe0035e0=
75cc4613acf110a09a277dc3302a","src/vxworks/x86.rs":"b1f933205800f0da00f975d=
53b18fe0035e075cc4613acf110a09a277dc3302a","src/vxworks/x86_64.rs":"b1f9332=
05800f0da00f975d53b18fe0035e075cc4613acf110a09a277dc3302a","src/wasi/mod.rs=
":"cac5127894b50bd1880e87b54ae0cbc9afe98f99ee739f74aec04172c14bcc1a","src/w=
asi/p2.rs":"feecc0485eabd2c32bc5d800df6ad1b9b4d282741342fb08792f2635204e1e0=
8","src/windows/gnu/mod.rs":"320ddf761f731c24a27e061438ddbacb0630e3ad6f3bb3=
9f6514c28dffd8ac9f","src/windows/mod.rs":"6be16eea8c7319c35e7efc6a70da8a04f=
9ab25d68173c51d561f37a0935de47c","src/windows/msvc/mod.rs":"7bc0f1e7e738152=
96cd6b63b2700e12624e9f47b5c4113a1a87fae8e64549c00","src/xous.rs":"1a83621c4=
0248ad4d0c08e1fd4c1107d5efcbc2f4f0169538b7b4a885abedbfa","tests/const_fn.rs=
":"8ac3171d7bced3576a4e93f48570b3e00c553d7510ab85a7473ae3b716a812dc"},"pack=
age":"d750af042f7ef4f724306de029d18836c26c1765a54a6a3f094cbd23a7267ffa"}
diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/=
rust-source.inc
index cc8e47b..c664baa 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -10,6 +10,7 @@ SRC_URI +=3D "https://static.rust-lang.org/dist/rustc-${R=
UST_VERSION}-src.tar.xz;n
             file://0001-libunwind-Use-gcs-instead-of-gcs-target-attribute.=
patch;patchdir=3D${RUSTSRC} \
             file://0001-Disable-libunwind-cross-architecture-unwinding.pat=
ch;patchdir=3D${RUSTSRC} \
             file://triagebot.patch;patchdir=3D${RUSTSRC} \
+            file://0001-riscv32-Define-plain-syscalls-as-their-time64-vari=
an.patch;patchdir=3D${RUSTSRC} \
 "
 SRC_URI[rust.sha256sum] =3D "0c1dcbb4f762513d021e1a282c0ac58c0a423642b3a6b=
f581cafb5414df4193e"
=20
--=20
2.50.1


