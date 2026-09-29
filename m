Return-Path: <floss@jetm.me>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC4DCA5FA5
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 21:46:12 +0000 (UTC)
Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.80.1790718363914525998
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 29 Sep 2026 14:46:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@peridio.com header.s=google header.b=V0Xmilyt;
 spf=pass (domain: peridio.com, ip: 74.125.231.167, mailfrom: javier@peridio.com)
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-81c01f53a3fso284900a34.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 29 Sep 2026 14:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=peridio.com; s=google; t=1790718363; x=1791323163; darn=lists.yoctoproject.org;
        h=references:in-reply-to:cc:to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:feedback-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cTBHeMqeKq3J/zCD2xBuZKrb33yUGBLuUp3vEj7Fc3w=;
        b=V0XmilytlV8/vfJlCB1XCQJ7Bgo7k0BnO5eLeD8d9KW6U3BcKl+mu6NaNLSQxaPdye
         N51cJcz1KSAsRo8fx39IjSttwdLxNu9PxiKDTGQEpDB2y2era2VRbefan99MBnOTZhMN
         PNWE40r5ObqNCF8pLNRE3ccZQs4Y+Dvg1C0UeeC7EMPhLWEALWkxf3PLb310NAMOHY/Q
         PjLok4eFI1zKP5v+6sIPRFR5xzHZVjVcylh5bAev7mRLbgKxLW9sveorYN9G24riZQpf
         ez8u6WBoioKeqcDp5fDpmLrfuDomkij1QJCmhF7c5El0z0nJUB70x1d5TCZ7ghlSGLPb
         kAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790718363; x=1791323163;
        h=references:in-reply-to:cc:to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:feedback-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cTBHeMqeKq3J/zCD2xBuZKrb33yUGBLuUp3vEj7Fc3w=;
        b=E3bVKFX8cCPavJvg/xzSUC4zVh8+85Yw1S/iQwN3E6nTxRKcFl4o9nCDQryNynKrYa
         1W5maWJTUsoki5pNpoO4gJ6rjkE7ELCV57Xc3IntGo09ZvEE0PP756UaJ0+VNiS0ClHy
         KQY8boj140voJ3TYp658zy/Gp7biVGVvrF7AokHVNEtfcsCNWRCjsPv+VFNCeObiAZqw
         IhEn0jRegb3jGMsbAMEKVDz9hHJCK6eJvVbkRRKZu6TA0JnBrdA4c4sXM76umEbXhLbB
         kKKLiprMj31XOo6uBdnrLcJSkIHCVHx7O44bJC0vqygDV7duDfL7c01Nf6wtn0ns/ti+
         JVeA==
X-Gm-Message-State: AFuF++l2ejnTwY7Wd4MGNjnMM1lHBTz59NArf1ya/E0Ns5LlHEDiOLs8
	oXtVlt969Yc0u1lLGlM6KB5hVq6a89cRT/jUXoY8iWv0u+sy0Y/VrmKhrpPU0d9beRfOJlGGohX
	H+yHZYKY=
X-Gm-Gg: AYBFou27wTQFhZRA4858YoW55mcbExrj2MmzUw7udI2DP7aZbn4mp6J8sIt82sA/X5F
	qV+3YcUXFrjczE03JJQKF6NipFQl54UOCpj6GwsyfKdiEupsg4GTwwGe9VTByJFipUVQ8Jgmkm6
	0nFOSHw8zdlzBSkp05m+HiHkvPFzqXre3leUSNi02gfKcfnNV0G/H96EmdrLslAQpjuKoTUbEzU
	UVwg1VkFtJlO5S4k7xBR4yu3aAuk3fsHXyxG00VBR5aV5bOUabVqR1l4ZXoWJxbq0d7zYRfaT4M
	MdiBenax20Cj/bP1cfzS3iwnXXuPYodUn+Mdk8yvdY0NAXHuXDIhgG+vyVmSmcYzA/ffkXNTNBJ
	UtrJX+0MhHxb+QcdQHXUyPdYczOKfpm6dF1IlDtthKHvm0n9jVE2IQQwWbnM2upczzhZ5PcaFoS
	5DTpdmFsblhj4UTViGgkkhJrtvJ//rjYbT0LqLajgRtBCnlBnEnH6WCvSybC66wT8A8NATUilm9
	qk42Ow4DCgyNiIVX/KSujhqZoEvikCBkpjOkviPu9lmUq2ekVi5/42K56xpTA==
X-Received: by 2002:a05:6830:398c:b0:7e6:6ced:992f with SMTP id 46e09a7af769-81fd5a600cbmr1008105a34.2.1790718363003;
        Tue, 29 Sep 2026 14:46:03 -0700 (PDT)
Received: from fauth-b1-smtp.messagingengine.com (fauth-b1-smtp.messagingengine.com. [202.12.124.200])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81faed3199dsm1151086a34.9.2026.09.29.14.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 14:46:02 -0700 (PDT)
Received: from stl-compute-03.internal (stl-compute-03.internal [10.204.2.63])
	by mailfauth.stl.internal (Postfix) with ESMTP id 088DE780043;
	Tue, 29 Sep 2026 17:46:01 -0400 (EDT)
Received: from stl-imap-04 ([10.204.2.95])
  by stl-compute-03.internal (MEProxy); Tue, 29 Sep 2026 17:46:01 -0400
X-ME-Sender: <xms:mDG8aohGcs2L6UjJXz_lmd2FwCBu0Hbi1qBRXwjaLlLhvaGkak8dDg>
    <xme:mDG8ar0L9fWd5r0m9Ouq4tQYiHHEAUsHQvBvVKUQSjTGlUllo6brI08Fe8DIoDXtM
    PUnp1hnR8PmyQ-fs9jrMNX0wJMa_tSB5ge6yacMsSnZEqnAsgF8>
X-ME-Proxy-Cause: dmFkZTGa5CrvXvhhM/mXgH3Hf1R2F5WeiSGjImguoHeOG39Bnu6TN+UPBtp9pAvINIwNkg
    NcTBw8Sg/il44qTqueRdk13IzY7zUrlBHUtLzCQlYUzd20Atru4JZ2XJ6tY95uPgARoY/t
    ayepiIwR614EkwwVlo7dTxUJtSjkzj3uFhMC+P60PZRsgJzqUDQ8+f494xIi5teuAJiAir
    is4PR492Bbx8HPJ5HibPPhNyjyLd8Y//Mqabwl719/ogh0LsgNPOqxxIvMHP2ObtjRzJUP
    H04ZD8YRRYwG+NiSfVuwznkKVTMydjQ6vX6tJB7/1j4jW1Ly7tlRWQ+f7sxqIePHqPeQnD
    Rl7hhZP82eFJt7C7blBnRsfV/wl5PoImG5GQ4sdFnZ/0Ve5tEhRKjbVskMcNU8tQz/qIOC
    v4emK43UoYSqRPaXL7VUry4oH0o2D2PLaf1a6ZDAd1M3NuqLYW39JMfSDascNLd9Z7QEdM
    rX7iLBanmrzOVVFoZicWUK6H8zmhneD0Aw+v8MBkpZXKVH75X9e5Tx3N4kvvUuhqc7V9ej
    1t9dv6RptpYWCIEmwPCvcnPtuxzw2/jlW54MszWVbxNvfJX0UNFqOYqLQoiauBgQrctZy/
    iTyIOORO9K2w0+u7QGrbdR0QsVl/2f93bmOXy5pF0zqozNmLKhqELzt67WTw
X-ME-Proxy: <xmx:mTG8arNfe__DL6cnvVxaMscM3dxKAfEPa4ZaozNsXbRt7na-ASLb0w>
    <xmx:mTG8aj7aYDr4u0yM0uAxg3iETAKWq76CUb63cOPtVPAz6VFLb9sNSQ>
    <xmx:mTG8ah0eP75rMlYJRaNu2UG6kBSny1c6pBRfL4Re8WVxLu3h4_kN8Q>
    <xmx:mTG8asbLQTy9QoJnk7QztwGSLFIK9qQLXis96OO7VKN7SWwRQ6fKkA>
    <xmx:mTG8ahBaNC_-EXDVlNUAb0AWRiuyI2IB6t1qYtDkBtlhHoe-Nmu_RkGZ>
Feedback-ID: if7264b73:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id B94C380066; Tue, 29 Sep 2026 17:46:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <javier@peridio.com>
Date: Tue, 29 Sep 2026 15:45:56 -0600
Subject: [PATCH pseudo 2/2] ports/linux/pseudo_wrappers: forward pre-init
 syscall/prctl to the real function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-pseudo-init-recursion-fix-v1-2-34e30f4c5349@peridio.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Javier Tia <javier@peridio.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5874; i=javier@peridio.com;
 h=from:subject:message-id; bh=9A+zGhmk2SJOE7xZjQANwTi9uPUbFWC4YmCJ5AhS4kY=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBqvDGSkfq7nchIIoy1hdUvj0AdibWaMyKrWrRdV
 FWkn/Xa5P6JAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCarwxkgAKCRC17sMLqGd3
 H39tDACNVcMTjPzJ8jDvorHVH/B0YXUARogUuP74e0jxs80li4rJKyPFfLctrZaGIumGowmJfdv
 q00aT/kLT8Ch7meu4//XHaPsqdwRqzv2djHcmyLrAuW12yS6VCrfDFpRuYgHTJSOxjSQZHp68dT
 ilJVU6itdt/8aCIf3IQjLxj7ec8I+nvE6hkgbKVg/JVRbH3x2cjPjjeYDaIrwYsE2TISmyhKAsU
 YrZzLhfwUfHkDqYC//jYmgU7VuGDOID2qEM6qWoxCPhVpuNpVA3eZgX3UmLyNOBkn6cKdBZg3ij
 vRcTS7nN0OY/y9yBDqQIKGysomuuN18HiZZ0RYhyWPHJSG8SuGsx7PMiYtg1ZPLmeHtYYatKcEl
 5y04yB50e4YV0yYlRMMHGllUlGsYA02LKaPeJ60njWg0zcYdNMaczznO8fEcgqk0EZQ5qFqUeun
 7veiQntZcA4hSgAzxYo5q1WBtOj86TCmqsyNmLsiQ2wZW/0nyt0YswzjwtV7lyGt5dZ0E=
X-Developer-Key: i=javier@peridio.com; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260929-pseudo-init-recursion-fix-v1-0-34e30f4c5349@peridio.com>
References: <20260929-pseudo-init-recursion-fix-v1-0-34e30f4c5349@peridio.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 29 Sep 2026 21:46:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4968

pseudo's syscall() and prctl() wrappers both call pseudo_check_wrappers(),
which runs _libpseudo_init() when _libpseudo_initted is still 0. That is
correct for a wrapped call pseudo actually needs to look at, but init
itself allocates (pseudo_init_util()'s pseudo_set_value() calls
strdup()), and an allocator that statically overrides the process's
global malloc/strdup and uses syscall()/prctl() during its own
not-yet-complete process init re-enters pseudo's own init on the same
thread, before that allocator has anywhere safe to return an allocation
from. Observed with mold 2.42.1's bundled mimalloc, which does exactly
this under pseudo's LD_PRELOAD interception: mi_process_init() calls
syscall(SYS_open, ...) to probe /proc/sys/vm/overcommit_memory.

Forward a pre-init syscall()/prctl() straight to the real libc function
via dlsym(RTLD_NEXT, ...) instead, for every number/option this port
does not itself rewrite (openat2, renameat2, seccomp stay on the
existing path so their behavior is unchanged; PR_SET_SECCOMP is guarded
with #ifdef the same way the syscall() side already guards SYS_renameat2
and SYS_seccomp, since this is now the first unconditional reference to
it - previously it only appeared inside the existing
`#ifdef SECCOMP_SET_MODE_FILTER` block below). The guard is
`!_libpseudo_initted || !real_syscall` rather than just the first half:
_libpseudo_init() sets _libpseudo_initted before it resolves real_syscall
via pseudo_init_wrappers(), so an allocator whose first touch happens
from inside the constructor itself, rather than before it runs, would
otherwise still reach pseudo_enosys() and get ENOSYS instead of a real
result. The resolved pointer is stored directly into real_syscall/
real_prctl, the same globals pseudo_init_wrappers() would otherwise
populate, and pseudo_init_one_wrapper() already skips re-resolving a
wrapper whose real pointer is non-NULL, so this path and the normal init
path cannot race to different results.

This removes the re-entrant call into _libpseudo_init() for the caller
that triggers it before pseudo has any state of its own to protect,
without touching behavior once pseudo is initialized. It covers only
syscall()/prctl(); every other generated wrapper still calls
pseudo_check_wrappers() on first use (templates/wrapfuncs.c), so an
allocator whose first touch is a different wrapped libc call (open(),
readlink(), etc.) would still re-enter init through that path. On glibc
before 2.34, dlsym() itself can allocate on a thread's first
dynamic-linker call (the lazy dlerror() result struct), which would
re-enter the same allocator this patch is trying to protect; this is
not fixed here.

Verified against pseudo's own test suite (no change to the 18/45 tests
that pass in this sandbox, which lacks chroot/openat2/renameat2 support -
confirmed identical to pristine master) and against a real
`gcc -fuse-ld=mold` build, plus a subsequent `chown 0:0` on the output,
run under pseudo with PSEUDO_DEBUG set, matching what bitbake exports
for every fakeroot task.

Signed-off-by: Javier Tia <javier@peridio.com>
---
 ports/linux/pseudo_wrappers.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/ports/linux/pseudo_wrappers.c b/ports/linux/pseudo_wrappers.c
index b920cb2..63912c6 100644
--- a/ports/linux/pseudo_wrappers.c
+++ b/ports/linux/pseudo_wrappers.c
@@ -59,6 +59,31 @@ syscall(long number, ...) {
 	long rc = -1;
 	va_list ap;
 
+	/* Reached before real_syscall is resolved: the caller may be a malloc
+	 * implementation initializing itself, and pseudo_check_wrappers()
+	 * would run _libpseudo_init() -> pseudo_init_util(), which allocates.
+	 * Forward the numbers pseudo never rewrites without running that path.
+	 *
+	 * The !real_syscall half of the guard covers a narrower window than
+	 * !_libpseudo_initted alone would: _libpseudo_init() (below) sets
+	 * _libpseudo_initted before it resolves real_syscall via
+	 * pseudo_init_wrappers(), so an allocator whose first touch happens
+	 * from inside the constructor itself - rather than before it runs -
+	 * would otherwise still fall through to pseudo_enosys() below. */
+	if ((!_libpseudo_initted || !real_syscall) && number != SYS_openat2
+#ifdef SYS_renameat2
+	    && number != SYS_renameat2
+#endif
+#ifdef SYS_seccomp
+	    && number != SYS_seccomp
+#endif
+	    ) {
+		if (!real_syscall)
+			real_syscall = (long (*)(long, ...)) dlsym(RTLD_NEXT, "syscall");
+		if (real_syscall)
+			goto call_syscall;
+	}
+
 	if (!pseudo_check_wrappers() || !real_syscall) {
 		/* rc was initialized to the "failure" value */
 		pseudo_enosys("syscall");
@@ -147,6 +172,20 @@ prctl(int option, ...) {
 	int rc = -1;
 	va_list ap;
 
+	/* See syscall() above: covers both the pre-constructor window and the
+	 * mid-constructor one, for every option except the one prctl() itself
+	 * still special-cases below. */
+	if ((!_libpseudo_initted || !real_prctl)
+#ifdef PR_SET_SECCOMP
+	    && option != PR_SET_SECCOMP
+#endif
+	    ) {
+		if (!real_prctl)
+			real_prctl = (int (*)(int, ...)) dlsym(RTLD_NEXT, "prctl");
+		if (real_prctl)
+			goto call_prctl;
+	}
+
 	if (!pseudo_check_wrappers() || !real_prctl) {
 		/* rc was initialized to the "failure" value */
 		pseudo_enosys("prctl");
@@ -167,6 +206,15 @@ prctl(int option, ...) {
 	}
 #endif
 
+call_prctl:
+	/* On Debian 11 - gcc (Debian 10.2.1-6) this results in:
+	 *   error: a label can only be part of a statement and a declaration
+	 *   is not a statement
+	 *
+	 * adding a ; here resolves this
+	 */
+	;
+
 	/* gcc magic to attempt to just pass these args to prctl. we have to
 	 * guess about the number of args; the docs discuss calling conventions
 	 * up to 5, so let's try that?

-- 
2.55.0


