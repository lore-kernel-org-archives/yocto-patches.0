Return-Path: <floss@jetm.me>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DF8CA5FA7
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 21:46:12 +0000 (UTC)
Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.79.1790718361898940280
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 29 Sep 2026 14:46:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@peridio.com header.s=google header.b=obFJVxqK;
 spf=pass (domain: peridio.com, ip: 74.125.231.164, mailfrom: javier@peridio.com)
Received: by mail-oo2-f36.google.com with SMTP id 46e09a7af769-81aac23195fso515898a34.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 29 Sep 2026 14:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=peridio.com; s=google; t=1790718361; x=1791323161; darn=lists.yoctoproject.org;
        h=references:in-reply-to:cc:to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:feedback-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wK3lYGpRIUNSeVjTeg4T2LyIF/eew2sJAstZ5WkpfEM=;
        b=obFJVxqKTV50/lB9invTfU+Z7rR2Qsh5jS7GcCvPKKgGy8ApwndrmAPSjCsMfxBY9I
         JvnZPyJKczQB3Piq/Owax1557ndDwFtfQqZipfO8TInlj8rHLAj/+fgs+FQAruyTKlMb
         ej+F8uV+td4Ypq/LY78bJynHoIavt4yHdKBEfUJwOkOFaQs4rqib6zbojbnxMAsMnjG6
         914Y6CEJ39j27L8ruHQ/DMz9MSDsgsgmG3bR6HNEuKNrAJycnCwQngd/qM3a8biyguG7
         3+17ynpcWPWuJD+rSyg0Gv8SyMrzJ5r/V88TWP1/W6XxPqpaBsccjC47AFbprym0ho97
         g3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790718361; x=1791323161;
        h=references:in-reply-to:cc:to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:feedback-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wK3lYGpRIUNSeVjTeg4T2LyIF/eew2sJAstZ5WkpfEM=;
        b=ocktkLk0U0YCJwfyM6dFa4q/SR6umXpKCYmsNWlC4bMflcg5VWyObgZEWPIR1hDWQo
         bC3IBJNtv8uaFUQXQbiWYWuBz7Uz/nknOWh8waEs38m0xKrJnV4yujKW9Pt1Ql9ww+FM
         eAiEaUMcBmJY1y4hwZu93tbwmdo8fgNvA1ZfH1cxf8ZRgu8unBOYbR1fkmDG5HuPZUzw
         vI8fEkpgRl2I4hyHV8FP1yXu3b52En3k1Iqb83R+Du7YeNwy4QGP+3cmTHwNa1E56Vb+
         bRVNkyW2St7PZLH2/bOsth+zj9aHPjFiublYftw8y9BpP73ksT01+5cN160X6nVXHjh6
         Zqxg==
X-Gm-Message-State: AFuF++kQTz5Bf4d5TnksniZCdy9UgDF1vBVGZ/Kp2OWtw0WVAmXMZ2oQ
	5/umrEJumJNd4z90EtKqaDhBQKR28//m+Y52Yl7nPjgJMzzN4ZhRcT7iabsxWbGOIX5h62UlRQg
	PJVlRl9E=
X-Gm-Gg: AYBFou12PCcUpbKjw2WY+ObjroO0DgUFYC15yrfQB+mb/kMEwCCB+kn7A9g0PcEfbD3
	xtEyDmNI5r3/mOPTuxUA5xeNseszp9ieXTDGP9zEB3QqxGwxymCmofKBwy7Jajn5J7/6/sRdCCU
	ILbi9lPgzSmVMbqFowU5+pftikAylqpSHbxVcGgGf3F9W5JLCzgZUk+Iuv7L6mvpXCGSxiljApJ
	WQDjzEuFrafLhE1wkNX+E1TYqlYyRULmvB0plrSfPsIe0BuR27HmlYMfhThhfN7dZK4zvafSIXp
	Q/nbyrr9zRIa9JaNiYqI+dfaoNvS1wQkkdj626jL9bZM4k/09O+YtiewUcbm9SYzc8FE4x5BXJp
	Mz7/e28QoacBNlvvdgapYNtotkkORkfhQNpB9/JxXXHEWnjklwx5THUHzBoSG+fg2qofoGHkkyZ
	+JwSuo2+l3UlamnIdLGK2r7P+w72suMzsGbTF6eOxtemDBkDObHYaBYx2t+kkezKd5/G8Suu9mU
	n4bPKOGpQeGUeYOvBcXB13LErEzXi/IvjG5om9MLXelPEP93+FLxuo5hieL
X-Received: by 2002:a05:6830:488b:b0:811:7b6e:d533 with SMTP id 46e09a7af769-81fd5b5a758mr1142474a34.1.1790718360966;
        Tue, 29 Sep 2026 14:46:00 -0700 (PDT)
Received: from fauth-b1-smtp.messagingengine.com (fauth-b1-smtp.messagingengine.com. [202.12.124.200])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81fafdde8f1sm1017341a34.26.2026.09.29.14.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 14:46:00 -0700 (PDT)
Received: from stl-compute-03.internal (stl-compute-03.internal [10.204.2.63])
	by mailfauth.stl.internal (Postfix) with ESMTP id B8706780066;
	Tue, 29 Sep 2026 17:45:59 -0400 (EDT)
Received: from stl-imap-04 ([10.204.2.95])
  by stl-compute-03.internal (MEProxy); Tue, 29 Sep 2026 17:45:59 -0400
X-ME-Sender: <xms:lzG8ajuTGRhKvN5_krCNQhTUzker2pldv8WFxogBPmRUBKBJ8FhOfg>
    <xme:lzG8avSFHf1H3elmkcaxjTF8AkQAm54v_SuLvvPSyk5P8OXZMUNwk2laO7WDvFzXJ
    o2otOVv5TbkPj_kz3cd5tnHEg3On4H2-JfY709iyaIRL7r3IMch>
X-ME-Proxy-Cause: dmFkZTEOj60ljf8F8ztA8trD+QhORC7g6yyZR10l8QXS1oSjHM4E8/zgzBFe2L1Q0JGFAJ
    PjeW8JD4j8dkTQ7xwUonr8m2ueSY8E+B/x17V3O/FK4M7gMBzzXUIuv4E7idbYU9DT/0At
    EA0E7I86zAmZAZW/xpi3UY95qR0pIEXmMS4S3Y/01jPUvwx3H5pjQyiLpxBQEF1JOewXdU
    258bFkaLFa4xYSLA5h1IAmdOpjVLXOxH1LLHpGsY7I2pxDDDQ8hDsoqkUX/SHapFfmfEJ8
    22SxmW4uj2HcuvjmoIujth9eEEQ03RWFy2YEZBDRfqJUzlxFJF+lzBk8QWxrRoKJx/2YGO
    B/Bm2HA3Mfk/a7+6ivQVvFHsC0r/2D/NV5RqnphU38kbORYs3ZsrtbRfODKIYu8f+qH8ce
    ZACSpVCsem+H7qSiWT0909nie2X/OxqVuBgFWVJR2PBKIcuW+/QNd+olUDGi78+u7gUnZ+
    FoMx2VO7RbORQk54cLD8qh6TjRj9tFNAicYaPRy3wVAcDegR3XX/sMXDsOj8ejR4cwhN7u
    vTzRl6wi5HLJztD6vIEPNQSpCOHcutqeGiyhmZZc3ThT8VLUDLGcvD88J6K5+lEwvuumJN
    OFgok/a6f90BKLcSUroMNNLfbmFydCOw0GOTMLOMnIrbosZFD6FD56eIGrWg
X-ME-Proxy: <xmx:lzG8aiY_qyPeyM9seX8Db7-YHcrUKO3vPKum2KXGDgKVp06rwX_JsQ>
    <xmx:lzG8ajVQiF1odd5vOHOfiFerV1YD462eYPFhw_D3hKgyJaK1-d-4gg>
    <xmx:lzG8akhCvBuTj-rBPSQBaRUxoxhhBIbJEHT1QeFrL5GoSUxlxZ2Jdw>
    <xmx:lzG8ahXUrBqBfBeGnzcLcam4q5GLmSUCDBiYkiug2jWX89YlgkgCww>
    <xmx:lzG8arPdETfh7YAXtUT8XpZj1tZvEFqJgfbDxqNqr2FzNf6-BuKXJILq>
Feedback-ID: if7264b73:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id 6E85180066; Tue, 29 Sep 2026 17:45:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <javier@peridio.com>
Date: Tue, 29 Sep 2026 15:45:55 -0600
Subject: [PATCH pseudo 1/2] pseudo_util: bound pseudo_get_value()'s
 recovery re-init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-pseudo-init-recursion-fix-v1-1-34e30f4c5349@peridio.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Javier Tia <javier@peridio.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3279; i=javier@peridio.com;
 h=from:subject:message-id; bh=OKEUiPjX47kWDoRb0noMXzf7qg2u4aNvx+EUI/CMhQQ=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBqvDGSkXKPC7RmracDmHviNrCE0xgxKMSokMWCV
 HLiSyetStuJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCarwxkgAKCRC17sMLqGd3
 H4CkC/wILdG+QMCIuenJjeHhb/B9DVUHkXIn99e+JQAKQgeDQYu5f9cQ+Eeilwsb7C5Cdp8EVl/
 fHBErxxO3WgUYVkMEjeksPXL75/rB/Fl0CQi02eFEUYHWvyE3f/aMv4I3fTS81NGSm/xiVI+IyA
 4L4D2YJwcUoN+Ovt6SRzXLiYJA/TzCBflWTZSowBwxR6eYYZC9R0q7HNM3KG56/Z5aMlFEyV8SP
 zIRKGgii2kIJkFuLtNI8zIaMor+XXgqmImcy6FT70gT4EpZQRMI26RchhdEuNhBJhFujESeh/i/
 4kk+8QaaSQZJ0QuoS1fHWchC+xR5CmC7hAER2Ys2hhmuXOCoL6gbc0Msb8i27cwHiTnBmTQ/StG
 waufB2cXg9KD7iLng/ASPR/blWqEsPvpYdgZKACpyc/THlibmIR3Q+fBuxw4c5FQu3fvXwLi7cN
 peNuQIY1/J1Xkjw0clUhu0B/s76z1/BDnHGUikQtWjti5+6g5LTG9X0IjnpdWsJTpcaMM=
X-Developer-Key: i=javier@peridio.com; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260929-pseudo-init-recursion-fix-v1-0-34e30f4c5349@peridio.com>
References: <20260929-pseudo-init-recursion-fix-v1-0-34e30f4c5349@peridio.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 29 Sep 2026 21:46:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4967

pseudo_get_value() falls back to calling pseudo_init_util() again when a
cached value is empty but the environment variable is actually set - a
recovery path for a value that failed to cache the first time. But
pseudo_init_util()'s own tail calls pseudo_get_value("PSEUDO_DEBUG") and
pseudo_get_value("PSEUDO_EVLOG") while it is still running, and it clears
its own initted guard (pseudo_util_initted = 0) before those calls rather
than after. If storing a value failed (pseudo_set_value()'s strdup()
returned NULL, which happens when init runs re-entrantly on the same
thread, inside another allocator's own not-yet-finished process init),
the recovery branch re-enters pseudo_init_util() unconditionally, which
fails the same strdup() again, calls pseudo_get_value() again, and
recurses until the stack overflows.

Observed with mold 2.42.1: its bundled mimalloc statically overrides
malloc/strdup process-wide, and under pseudo's LD_PRELOAD interception,
mimalloc's own lazy process init can call a libc function pseudo wraps
before mimalloc has anywhere safe to return an allocation from. See the
companion patch to ports/linux/pseudo_wrappers.c for the syscall()/
prctl() half of that same interaction.

Move the initted-guard reset to the end of pseudo_init_util(), after its
own lookups, and gate the recovery re-init in pseudo_get_value() on that
guard. A value that still could not be cached now surfaces through the
existing "failed to save new value" diagnostic and this function returns
NULL, instead of recursing.

Verified against pseudo's own test suite (no change to the 18/45 tests
that pass in this sandbox, which lacks chroot/openat2/renameat2 support -
confirmed identical to pristine master) and against a real
`gcc -fuse-ld=mold` build run under pseudo with PSEUDO_DEBUG set,
matching what bitbake exports for every fakeroot task.

Signed-off-by: Javier Tia <javier@peridio.com>
---
 pseudo_util.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/pseudo_util.c b/pseudo_util.c
index afd0266..b8afe34 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -159,8 +159,13 @@ pseudo_get_value(const char *key) {
 
 	/* Check if the environment has it and we don't ...
 	 * if so, something went wrong... so we'll attempt to recover
+	 * -- but not while pseudo_init_util() is running.  Its own lookups
+	 * below reach this point, and when a value could not be stored
+	 * (strdup() failed) re-running it fails the same way and recurses
+	 * until the stack overflows.
 	 */
-	if (pseudo_env[i].key && !pseudo_env[i].value && GETENV(pseudo_env[i].key))
+	if (pseudo_util_initted == 0 && pseudo_env[i].key &&
+	    !pseudo_env[i].value && GETENV(pseudo_env[i].key))
 		pseudo_init_util();
 
 	if (pseudo_env[i].value)
@@ -218,8 +223,6 @@ pseudo_init_util(void) {
 			pseudo_set_value(pseudo_env[i].key, GETENV(pseudo_env[i].key));
 	}
 
-	pseudo_util_initted = 0;
-
 	/* Somewhere we have to set the debug level.. */
 	env = pseudo_get_value("PSEUDO_DEBUG");
 	if (env) {
@@ -241,6 +244,8 @@ pseudo_init_util(void) {
 		pseudo_evlog_flags_finalize();
 	}
 	free(env);
+
+	pseudo_util_initted = 0;
 }
 
 unsigned long pseudo_util_debug_flags = 0;

-- 
2.55.0


