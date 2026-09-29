Return-Path: <floss@jetm.me>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2493CA5FA7
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 21:46:02 +0000 (UTC)
Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.85.1790718361543465344
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 29 Sep 2026 14:46:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@peridio.com header.s=google header.b=FPuOu/Qy;
 spf=pass (domain: peridio.com, ip: 74.125.231.205, mailfrom: javier@peridio.com)
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b375b957e0so338422b6e.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 29 Sep 2026 14:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=peridio.com; s=google; t=1790718361; x=1791323161; darn=lists.yoctoproject.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:feedback-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VjibRAb4gprlRf84C8lLT3PWR2akR5g3CV3uEgZ64YY=;
        b=FPuOu/QyqZVbNcgM7JRFhkeFwl4SGV5gWCnueYN61BEE7DUWzmGd+DCgDorxrusGHd
         u2k3OW3YlKuBsyAEknWiNIzbq40Wn3EFMPFM0xxykPG8bW7R3wKg7hlNKpjki4hz8SXq
         iPntyuCizxUzvOACbWMdi7sXMe0R+u+baOqmLVhRW+URUqZ1vS19c+Q3pBltec4WizaE
         qxEvwRUyFvrmWQKyAAoLgN9rY8Xow4f5nA7Q2JOk6VhfSMdah6iiS92+RwjESkAlyGG8
         7J0+oMQ2ziyRuxlqvFOT9aI3ALwsxlp1Ow17l77nwH+Qrd+y2bkg1pWRE7P8DpEsbCiG
         3weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790718361; x=1791323161;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:feedback-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VjibRAb4gprlRf84C8lLT3PWR2akR5g3CV3uEgZ64YY=;
        b=Ude1cBbh6l5V2nOeVVEPQ9hfIwQrJBIJjEj943CatCX6t5LkpY4iJo8a2EqGTgptWo
         fBcTxrsjMKORFUMV36eQCoPgrtgt7lz32QjdUsGqfFVutTjq2wukPhbaouwwCMnmngo5
         XDjp+O3tUJdduzNPiTY5ZRfIcWUPquBKicVHBxFvU+AbxnL2FQ50n7xKIATpYIn/OlAC
         mLPOImgz0hVIDzvd3TN0rEgmqOUVhcseI8kZrwxU7i+de955gyAqfMetsxVkxvmhUV8/
         GgHOwmikTQI1ZE4ovUZU1cTmMxbsyJnXkA7z2Foa+xgEobIZRTjRP9WIgSWdEbviQ4pJ
         gq7w==
X-Gm-Message-State: AFuF++kfMk9n0ELGFczYdDoT/JeoRLwAkGvWWh8aOhK88fCRt9ogfeV5
	O6YnEV0bgfOBu6riCep2Fho/F2jEMTizZ+kgO0xs/YLlVtpOGdi4FWQC7Uo6pRq+cNt3E71AGDa
	40Whj64Q=
X-Gm-Gg: AYBFou1BZKA1wBvKsrp9oYsQwU5wE4drYnO/AMrErhJz9RPHWAW6ollgFCdfpNiGLIY
	7uDEY9RHnFdH+sncydSN387ji1nroVZBORJfzcVvRYHQtTg+GCq35z/18iDMKgoy7hFzHZNrcGt
	RN4xGLZvSW1nd/Fh/rJoT6DRoxyNHZhNCXlnmpqcE1s7IgG9wyjKnvhKnoHhrQovX4k/7fQWcQQ
	G55+Uj06aBi/Fi/NQB2Z0aODJJBR2jW6Wf6Ygs9hNfZHKxmFZeAPQN5LY8kAXYUM9etID28+Z4I
	neR79Cf7JDnA39WJyQWkzNGC7AC43p3m2lgrHBh+ru64l5G9R9A2Bb1iHppNqXQ7h6yfGxR/p28
	lyVUvPDmUPZ5TIMOipuzwt62o049x5TRIJH87K31WFSputvcBHQAe1qkapzSf+RYGwcgGfD/RZG
	1mSPjGmi1kqwWVVJZjPCqZlkzEB2VJVr6X1AdMZBEQjWtztzJVjYLwTOFy/txUtFKuVarnOCKjc
	X83J8tnPX6xjMdg4K+/7WgpiQJlmBguffsSy0MVKFsoFVDY3SmUN0lUbAFv3v/0cb3Op7M=
X-Received: by 2002:a05:6808:23c1:b0:4a3:f036:f3bf with SMTP id 5614622812f47-4f064084a45mr1416145b6e.1.1790718360625;
        Tue, 29 Sep 2026 14:46:00 -0700 (PDT)
Received: from fauth-b1-smtp.messagingengine.com (fauth-b1-smtp.messagingengine.com. [202.12.124.200])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f0ad2537d8sm542148b6e.6.2026.09.29.14.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 14:45:59 -0700 (PDT)
Received: from stl-compute-03.internal (stl-compute-03.internal [10.204.2.63])
	by mailfauth.stl.internal (Postfix) with ESMTP id 70E4C780043;
	Tue, 29 Sep 2026 17:45:58 -0400 (EDT)
Received: from stl-imap-04 ([10.204.2.95])
  by stl-compute-03.internal (MEProxy); Tue, 29 Sep 2026 17:45:58 -0400
X-ME-Sender: <xms:ljG8akkiWgqCK-3jH6sZMX7L9TUvd72eM1anQVN_HtPSqV8UQhSHng>
    <xme:ljG8auoCCSg3r4M3oo6Qwn-2UGFCMn7SDSn1VbhyMZafWtHZHQqyanMoClU8dyE9C
    zQrQphf15JPWWyYf1Rb13rRcnnEQ3ZM5ikJ8prTmyncitWOGtGl>
X-ME-Proxy-Cause: dmFkZTEItdoMDo9JjJ2+Vp4TXKX8+yTtAf19JcFdjLTeLgzfvjwzkIta5S+Gz1bTG7bPTJ
    p1/4IqG2Apm8hunhM8NHznYwXbYE/l5eP1171ydalU0vxjSZLecV1fLNoJbtBrSoQoADLz
    kaawMg7mIAGzMavOe/V4KbPfsZFkN6QQny0ixPTGLWcUJH6NJzB0mDzbFsWSfPxAxRtmdH
    d4gx0FpDlE9JnpNLMCWxPbCtIQoMNf38Sf975qPmCXyqye/CkynnSLp8eGpDtxLRwtsW6s
    byRgX5fpU3yqT1FTG90wR9DK9J5L0a4sYzgC+nvztfAXwiaqIX1Q8AN5rwnKD6HGnVG6KS
    XwLwxB8yq/QeCp2m8hYmCFDnGp3Bo3ATp/LMP3eynWTvYNyJxivBUoGDxHSVOmmprEzUIJ
    QRKRdo2lNo5kiiM/0Uv3DScBWDpoIwtdKAlRQ3GnIW+Hq+iNEfWdBkEvp3e7KzsULWmWbG
    8q0Dmy146ID0KAsFriyVVaLDyqeAelEtlHRpYNnVKPx28bviwiv/H2xVD3P84a6WaMxXU9
    bacVnD+ogOzsTlen17P/pywtlMhdHwlhJKRCQBErYY+1VGz4WfqzF0H+Rb2Ltp2fBQzlSY
    zsL+gakdiA5UFqFcz0duGgSB8kFefm8kRkR+4TbsNMjceASiE4xj1gRDH6/g
X-ME-Proxy: <xmx:ljG8arSthTnKAtTKK8ZCgavZBPlg4KHXdC-OIK-5WKceSlSRhRYVMg>
    <xmx:ljG8aqv2xPm3YcEokLL97R1Ywl1oiFV5nnlZIO_vzvMyKl74Vw8uvQ>
    <xmx:ljG8aoYm5efHcFCpTCw5QyAXGAGGf6ge4ZUE6uIjCZp1xEyiZ1LVcA>
    <xmx:ljG8anu2TfJ7LPF0SgnOyx8FCRbQGnQofDifJVdKAst3xEY92VLp6Q>
    <xmx:ljG8aiHnAbwLjHOhnKGUnJBMo2RXfx4OpGsAlEJEpLFuWLVxUVC1MZVj>
Feedback-ID: if7264b73:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id 19BEE80066; Tue, 29 Sep 2026 17:45:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <javier@peridio.com>
Subject: [PATCH pseudo 0/2] Fix an unbounded recursion in pseudo's own init
 path
Date: Tue, 29 Sep 2026 15:45:54 -0600
Message-Id: <20260929-pseudo-init-recursion-fix-v1-0-34e30f4c5349@peridio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrCMBAFf6Xs2YU1B2n8FfGgyWtdD2nZbUQo/
 XdTe5yBmZUcpnC6disZPuo6lQbnU0fp9SgjWHNjChIuEkPk2VHzxFp0YUOqthc86JdFJCbE0Oc
 e1PrZ0PT/faMjo/vhvT7fSMs+pm37AcD1kqyFAAAA
X-Change-ID: 20260929-pseudo-init-recursion-fix-0009ce928d8e
To: yocto-patches@lists.yoctoproject.org
Cc: Javier Tia <javier@peridio.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3186; i=javier@peridio.com;
 h=from:subject:message-id; bh=0R9aCmC1LrWCX0gHcd2rQg3xy1PYurc7eYnDTMGP5D4=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBqvDGS1eyVvn5ih+wt2cWWMnAcdfsxFfGBJcQAR
 lPsu4ToGdSJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCarwxkgAKCRC17sMLqGd3
 HylSC/9WNyU/HlHtrXW5KTFxn0PLUdVSAR5CJ3aSukclPdlTbqSwNBdPIEYHrl6Z4qSPzaZGsvL
 SdNtnmJECme7uFwAFA66lFbskTEFt3S4v1uA0zJ92VjWKTeb1VyNHUhuSYjzcTnE9QG2HQ1bYp3
 sN8NYcWQr3QM51NPxap+YC8ugD8YWvbfYZ+k1nZVab1Ne0dtlAYo5eaO3Mud7c6mBZcnv6z953H
 YKDVnPq6rUBMvNaDvY5XqL9cnohUxVYSpkDvksnvb5j7M+DqL+k45gE0eEcv+ftAmHW9GgbHvV0
 J40Jij31C5+OMP+IFobrwytjFEcOryaGbScaIwayspIZIHUzRlhdS8Wqrojt4jGYCGPHNpLpKY2
 ed4RsoM+XQiyuL1cBdlmzNDt1lSBZfMEQ6E+Vc9VWl72enaq0hnuwQW55XRUluSXFqOCZY2RsKT
 5bKBZxhT9nOOhFq5dLBiQRBF3bU8p6b4YLp2G9t/qJNaecpSAO7TeDO5hRT+VhJsoxbjk=
X-Developer-Key: i=javier@peridio.com; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 29 Sep 2026 21:46:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4966

I hit this building with mold 2.42.1 under bitbake's fakeroot (pseudo)
task: mold links segfault, and pseudo's diagnostic log fills with
millions of "failed to save new value" lines before the stack
overflows.

mold statically links mimalloc and overrides malloc/strdup process-wide.
Under pseudo's LD_PRELOAD interception, mimalloc's own lazy process init
calls syscall() to probe /proc/sys/vm/overcommit_memory. pseudo's
syscall() wrapper reenters _libpseudo_init(), which allocates via
strdup() - landing back in mimalloc, still mid-init, which can
legitimately fail that allocation this early. pseudo_set_value() handles
a failed strdup() by logging a warning and moving on, which is fine on
its own. The problem is that pseudo_get_value()'s recovery path
unconditionally calls pseudo_init_util() again whenever a lookup comes
back empty but the environment variable is actually set - and
pseudo_init_util() itself performs exactly such a lookup at its own
tail, while its init-guard has already been cleared. If the value could
not be cached, that recovery path re-enters init, which fails the same
allocation again, and recurses without bound.

Patch 1 closes the recursion in pseudo_util.c: it moves the init-guard
reset to the end of pseudo_init_util() and gates the recovery re-init on
it, so a value that still cannot be cached surfaces through the existing
diagnostic instead of recursing.

Patch 2 removes the trigger for this specific caller: pseudo's
syscall()/prctl() wrappers reach _libpseudo_init() before real_syscall/
real_prctl are resolved, in two overlapping windows - before the
constructor runs, and from inside it, before pseudo_init_wrappers() has
run. Forwarding a pre-resolution call straight to the real libc function
(for every number/option this port does not itself rewrite) means an
allocator's own process init no longer re-enters pseudo's init through
these two wrappers. It does not cover every other generated wrapper,
which still calls pseudo_check_wrappers() on first use; an allocator
whose first touch is a different wrapped libc call would still hit the
same recursion through that path.

Verified against pseudo's own test suite: no change to the 18/45 tests
that pass in this sandbox (which lacks chroot/openat2/renameat2 support -
confirmed identical to pristine master). Verified end to end: a real
`gcc -fuse-ld=mold` build, run under pseudo with PSEUDO_DEBUG set
(matching what bitbake exports for every fakeroot task), links and runs,
and a subsequent `chown 0:0` on the output is correctly tracked by
pseudo.

Signed-off-by: Javier Tia <javier@peridio.com>
---
Javier Tia (2):
      pseudo_util: bound pseudo_get_value()'s recovery re-init
      ports/linux/pseudo_wrappers: forward pre-init syscall/prctl to the real function

 ports/linux/pseudo_wrappers.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 pseudo_util.c                 | 11 +++++++---
 2 files changed, 56 insertions(+), 3 deletions(-)
---
base-commit: ba8887e5f1e922f866681ec7dec1a00b602a9328
change-id: 20260929-pseudo-init-recursion-fix-0009ce928d8e

Best regards,
--  
Javier Tia <javier@peridio.com>


