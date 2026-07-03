Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A6BC43458
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 11:13:30 +0000 (UTC)
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90975.1783077205138124154
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Jul 2026 04:13:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=TUWhwQ1m;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=MACSHJ+2;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.157, mailfrom: paul@pbarker.dev)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED73D7A00B0;
	Fri,  3 Jul 2026 07:13:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 03 Jul 2026 07:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1783077203; x=1783163603; bh=4B6BnmNg3/
	L34OVafEI/WwhengLZn4dhjJFvLdQDxG8=; b=TUWhwQ1mE7vfdeVHuG256d69Ek
	as5ZNUiV2i+jgYdGoX2hWv1ZsCYaFX9BYQrWdLpp0tpMPYAkoXZ+NTEypzLbLsiU
	zWqdcLcrOh/KjCUUVlRGCT8Eg8iPbD8hLVaa5hZadwZJ0IfGSqOcI1RAjEpLEDpJ
	5rY/MsC/TNyloiOSrnN35jkF6b/rIs/+K7pkEnFizcT9Hkn+mDqqpxMY/Pdr+x1T
	n1+e0CCcs6oHk/Pv7GY9UWJ9/ycmm+JbtLe7DHL/+b/nJsRG5680LBWj0wn1sTTk
	61gFCfE9DoWlZmKYOo6hCrfx0huw3TSOII85Ec/cC+lENJOceD9XuG1Fmxig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783077203; x=1783163603; bh=4B6BnmNg3/L34OVafEI/WwhengLZn4dhjJF
	vLdQDxG8=; b=MACSHJ+2H9C8Ewl6WSbopuE91WOA9UfsY/urpAOcqqrWZz7I1sf
	SHzwq8Qxv1aumQLpm0t2jo1PRLTtdgIzlfNAqJeD1hkXcSERTFixOOxeXXgY2w/A
	dWLfAvgp6Ktegcg9aGEJE67qRH8PbVz4G4Kd3dz+ykspilBE5t0QVTd88Mvbl1rv
	Yrkn8khkG+zTecpIJmgvGUImDQx/z2wngIHQz7SgE5juZ/k73LlY6dwfX+EX3I8U
	O2UvWme9KjdYkSN2cleYEfaYIDzSqRsFHPY76dEo8O9IMjSYBDnk9AdGFlxaYRQT
	eU2JlWJ521SCiiksFjZz9ycjYgO5S/avjxQ==
X-ME-Sender: <xms:U5lHakQip5lxKioC4E2hW_GyuUbzvQfpYhooV_XFAkGspvYsmKT1fA>
    <xme:U5lHapOmdNUGoVMTSlE4EGsRcl3kOd73FoTlP7ZHsY2aPlC7NT7Y9JNLP1yhKbtte
    YLlvBclwhdRZHycMS2y7ZhpLRTclzZqee8iJO4mHqx6bJh_rbrCLA>
X-ME-Received: <xmr:U5lHavMGVe6AFIeq3G3THhgJ3yOhOIfmsMbtk6iWqSbMftNNAYOWDoslKO8wh2Ph1C9whCN4cnbhh8qUTTniA6yliVFXyDFXfonyqxsC0EOS>
X-ME-Proxy-Cause: dmFkZTFnD29cR90nM+OVwMJuCVX5DwgKrXlh2RXpaPtYZMEbpA4zGOFYEpgyzflwBWI62G
    S9jleo/7d9F6F0Ck7aWVM4cYfoxcmEleNA5TOWM8QUwb9+HhfV+RWeZp8+NCZh9jp6XQD3
    zALFLupGGKc+lkKA5x3/I9lJi1DIkooGim0KDTDKaLp/EZpQgGBDvUQRqG2UcHi3trlz0V
    9U4fDRw0y8ZmFCbuRZZ2UlISbjNCQ+mmCil4A44+hw5YthqdEqISaBKnkEdSjAF/da2zsG
    JLkzgb8Rl/Rbqw+7xdscc9hyNm4xnmlpukhPO6oIw97xzBg9pEufJo6TJAKVsIV98KX8jM
    qdehNmrsio5lcOxMTtMvLcI79Y/O3qvzowhC1i/WBFDiZqV8Ef+w5kDwXapkdVDvci6k1T
    NY4TRlBhfQwJKQjzt/+lfXAexANnNVRoSq7hwRFKOi0jtQECMaVOlgw0PVp9DWRuDS0Orq
    AXAzKiVHsbCn4rDxB74dDqhMQtjpaZs5irNzSSRSS+7hWUoHYwI4Ow6zVaUl2gQay8Fo+5
    GeFvENo6LbCgjYKC/PHC2JY7+DAN/bIH6ReMZW0hO37RfoaTc/gU0bLUc+UyH+LaGiLaEg
    OR8/1NoydE3fKPHXmaogbTzIm3wNtjQEoFYtiUGBI++Kc3wbiGInaUNqlb/A
X-ME-Proxy: <xmx:U5lHahvLQOl2kudDCGaVbanNEgFAeSVn7RLn5AxY8gIns84mg135Cg>
    <xmx:U5lHahU4Vpi8eEUvL8MsuV-cJOXkeRkb9Bwk_VnYJmGGhSJXwwBSrg>
    <xmx:U5lHahtABkf50IJ5TvjqGCe9U6gjGlb2WRviAqoeECCvPA9pr7HTTg>
    <xmx:U5lHalWX-MuIglQKtXAjdH824DgZ9yw4-ts1uUMyUtOwUa8BHdRhng>
    <xmx:U5lHamizyb4KuOaCHXCV6QH8gyhPO2tos_urjHm7KJGMTKwsmKeNE2J8>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 07:13:22 -0400 (EDT)
Message-ID: <b5d030e2aceccedfad7772f7854dbeb2e7d4decc.camel@pbarker.dev>
Subject: Re: [yocto-patches] [pseudo][PATCH 22/23] test-bash-exec-env: Add
 bash env test case
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Date: Fri, 03 Jul 2026 12:13:18 +0100
In-Reply-To: <1783039578-31531-23-git-send-email-mark.hatle@kernel.crashing.org>
References: 
	<1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
	 <1783039578-31531-23-git-send-email-mark.hatle@kernel.crashing.org>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-HpY21uC2n6pwRTXlFkWk"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 11:13:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4392


--=-HpY21uC2n6pwRTXlFkWk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-07-02 at 19:46 -0500, Mark Hatle wrote:
> From: Mark Hatle <mark.hatle@amd.com>
>=20
> Add a test reproducing the bash/pseudo environment conflict
> (https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D16078) where pseudo'=
s
> setenv workaround corrupted memory when pseudo ran under bash.
>=20
> The helper binary exports its own getenv/setenv/unsetenv (as bash does),
> maintaining a private variable table separate from environ. It strips the
> derived PSEUDO_* variables and forks children, mirroring the opkg-build
> pipeline that triggered the production crash. pseudo's fork wrapper runs
> pseudo_setupenv() in each child, which re-adds those variables; the child
> then checks whether they leaked back into the real environ:
>=20
>   Unfixed pseudo calls glibc's setenv via dlsym(RTLD_NEXT), writing the
>   variables straight into environ and desyncing it from bash's table.
>=20
>   Fixed pseudo calls the process's own setenv, leaving environ untouched.
>=20
> The check is deterministic, so the test fails when the fixes are reverted
> and passes when they are present. MALLOC_CHECK_=3D3 is kept as a secondar=
y
> safety net.
>=20
> AI-Generated: Test constructed with GitHub Copilot (Claude Opus 4.8)
>=20
> Signed-off-by: Mark Hatle <mark.hatle@amd.com>

Hi Mark,

I've done some initial review and added some comments below, though I
must admit I ran out of patience with the AI-generated code. It needs a
thorough tidy up, then another review.

> ---
>  test/test-bash-exec-env.c  | 667 +++++++++++++++++++++++++++++++++++++
>  test/test-bash-exec-env.sh |  34 ++
>  2 files changed, 701 insertions(+)
>  create mode 100644 test/test-bash-exec-env.c
>  create mode 100755 test/test-bash-exec-env.sh
>=20
> diff --git a/test/test-bash-exec-env.c b/test/test-bash-exec-env.c
> new file mode 100644
> index 0000000..68ed42a
> --- /dev/null
> +++ b/test/test-bash-exec-env.c
> @@ -0,0 +1,667 @@
> +/*
> + * SPDX-License-Identifier: LGPL-2.1-only
> + *
> + * test-bash-exec-env.c
> + *
> + * Reproducer for https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D16=
078
> + *
> + * What this binary simulates
> + * --------------------------
> + * bash exports getenv(), setenv(), and unsetenv() as dynamic symbols.
> + * Because the main executable appears first in the dynamic-linker searc=
h
> + * order, every library loaded into the process (including libpseudo.so)
> + * resolves calls to those names to bash's own implementations.
> + *
> + * bash maintains a private variable hash table that is separate from th=
e
> + * C-library 'environ' array.  bash's setenv/getenv operate on this tabl=
e;
> + * 'environ' is only rebuilt lazily by maybe_make_export_env().
> + *
> + * The old pseudo workaround (commit 80c6334a) used
> + *   pseudo_real_setenv =3D dlsym(RTLD_NEXT, "setenv")
> + * to bypass bash's override and call glibc's setenv directly.
> + * dlsym(RTLD_NEXT, =E2=80=A6) from within an LD_PRELOAD library searche=
s the
> + * shared-library chain *after* the LD_PRELOAD library, so it finds
> + * glibc's implementation =E2=80=94 it does NOT find the main executable=
's
> + * (bash's) version.
> + *
> + * glibc's setenv modifies 'environ' directly, allocating a new heap
> + * block (block A) for the updated "LD_PRELOAD=3Dlibpseudo.so:=E2=80=A6"=
 entry.
> + * bash's internal variable table is NOT updated.
> + *
> + * When bash later calls maybe_make_export_env() (before exec-ing each
> + * pipeline stage), it calls strvec_flush() which frees every entry in
> + * the current 'environ' array =E2=80=94 including block A =E2=80=94 and=
 rebuilds from
> + * the internal table (which still has the original LD_PRELOAD without
> + * libpseudo.so).
> + *
> + * The freed block A therefore remains live in the allocator's free list
> + * while pseudo's exec wrapper (pseudo_setupenvp) iterates 'environ'.
> + * Whether the access to freed memory produces a crash depends on whethe=
r
> + * the allocator happens to reuse that block and overwrite its contents
> + * before pseudo reads from it.
> + *
> + * This binary faithfully reproduces the bash conditions:
> + *
> + *   1.  It exports its own setenv/getenv/unsetenv (like bash) that
> + *       maintain a private internal table, separate from 'environ'.
> + *       The regular setenv/getenv calls in pseudo therefore go to
> + *       *our* functions; only dlsym(RTLD_NEXT, =E2=80=A6) from inside
> + *       libpseudo.so reaches glibc's implementations.
> + *
> + *   2.  It implements strvec_flush() and maybe_make_export_env() that
> + *       rebuild 'environ' from the internal table, freeing the old
> + *       array (which contains glibc-setenv-allocated blocks).
> + *
> + *   3.  It runs the pipeline pattern from opkg-build: fork N children
> + *       in parallel (simulating find|sort|tar|gzip|ar), each child
> + *       calling maybe_make_export_env() then execve().  This is the
> + *       exact sequence that triggered the production crash.
> + *
> + * Detection
> + * ---------
> + * The bug is detected deterministically rather than by relying on the
> + * probabilistic heap corruption it causes.  main() strips the derived
> + * PSEUDO_* variables (PSEUDO_BINDIR, PSEUDO_LIBDIR, =E2=80=A6) from bot=
h the
> + * internal table and the real 'environ'.  pseudo's fork wrapper then
> + * runs pseudo_setupenv() in every child, which re-adds them:
> + *
> + *   Unfixed pseudo calls glibc's setenv (via dlsym(RTLD_NEXT, =E2=80=A6=
)),
> + *   which writes the variables straight back into the real 'environ'
> + *   array =E2=80=94 the very environ/allocator desync that corrupts bas=
h's
> + *   heap in production.  The child observes the reappearing PSEUDO_*
> + *   entries and reports the bug.
> + *
> + *   Fixed pseudo calls the process's own setenv (ours/bash's), which
> + *   updates only the internal table, and the exec/system/popen
> + *   wrappers operate on a private pseudo_setupenvp() copy and restore
> + *   environ afterwards.  The real 'environ' is never mutated, so the
> + *   PSEUDO_* variables do not reappear and the child exits cleanly.
> + *
> + * See pseudo_mutated_environ() below for the check.  MALLOC_CHECK_=3D3 =
is
> + * still set by the shell wrapper as a secondary safety net so that any
> + * residual heap corruption also aborts the run.
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <stddef.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +/* ------------------------------------------------------------------ */
> +/* Internal variable table =E2=80=94 analogous to bash's variable hash t=
able.  */
> +/* setenv/getenv/unsetenv operate on this table; 'environ' is rebuilt   =
*/
> +/* on demand by maybe_make_export_env().                                =
*/
> +/* ------------------------------------------------------------------ */
> +
> +static char **internal_table =3D NULL;  /* "KEY=3DVALUE" strings        =
   */
> +static int    internal_count  =3D 0;
> +static int    internal_cap    =3D 0;

The comment and code formatting is a complete mess. If we're going to
end comment lines with '*/' then they should be aligned, but we may as
well just use the simpler comment format used above. We should also
either align '=3D' or consistently use one space between a variable name
and '=3D'.

> +
> +static int table_find(const char *name, size_t nlen)
> +{
> +    for (int i =3D 0; i < internal_count; i++) {
> +        if (strncmp(internal_table[i], name, nlen) =3D=3D 0 &&
> +            internal_table[i][nlen] =3D=3D '=3D')
> +            return i;
> +    }
> +    return -1;
> +}
> +
> +/* ------------------------------------------------------------------ */
> +/* Exported env functions =E2=80=94 these override glibc's versions for =
code   */
> +/* that resolves symbols via the normal dynamic-linker search order    *=
/
> +/* (i.e., callers inside bash/this binary itself).                     *=
/
> +/*                                                                      =
*/
> +/* dlsym(RTLD_NEXT, "setenv") from an LD_PRELOAD library searches      *=
/
> +/* *after* the LD_PRELOAD library, finding glibc's implementation =E2=80=
=94    */
> +/* NOT these functions.  That is the exact asymmetry that pseudo's old  =
*/
> +/* workaround relied on and that caused the bug.                        =
*/
> +/*                                                                      =
*/
> +/* The defensive NULL checks below intentionally mirror bash's own      =
*/
> +/* env functions.  glibc declares setenv/getenv/unsetenv with the       =
*/
> +/* 'nonnull' attribute, so comparing the parameters to NULL trips       =
*/
> +/* -Wnonnull-compare; suppress it for this block since keeping the      =
*/
> +/* guards is deliberate.                                                =
*/
> +/* ------------------------------------------------------------------ */
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wnonnull-compare"

This further ties pseudo to building with GCC. It may be better to just
pass -Wno-nonnull-compare for the whole test file.

> +
> +int setenv(const char *name, const char *value, int overwrite)
> +{
> +    if (!name || !value || strchr(name, '=3D')) { errno =3D EINVAL; retu=
rn -1; }

This doesn't all need to be on one line.

> +    size_t nlen =3D strlen(name);
> +    size_t vlen =3D strlen(value);
> +
> +    /* Before main() initialises internal_table, update environ directly=
. */
> +    if (!internal_table) {
> +        /* Find and replace existing entry, or append if not found. */
> +        if (environ) {
> +            for (int i =3D 0; environ[i]; i++) {
> +                if (strncmp(environ[i], name, nlen) =3D=3D 0 &&
> +                    environ[i][nlen] =3D=3D '=3D') {
> +                    if (!overwrite) return 0;
> +                    char *e =3D malloc(nlen + 1 + vlen + 1);
> +                    if (!e) return -1;
> +                    memcpy(e, name, nlen); e[nlen] =3D '=3D';
> +                    memcpy(e + nlen + 1, value, vlen + 1);
> +                    free(environ[i]); environ[i] =3D e;
> +                    return 0;

This block is just unparsable by human eyeballs. The if condition
continues at the same level of indentation as the following block, and
we have single line if conditions that should be split across two lines
with proper indentation.

There are more instances of this below that need fixing.

> +                }
> +            }
> +        }
> +        /* Entry not found: can't resize kernel-provided environ safely;
> +         * just ignore (the entry will be added when main() starts). */
> +        return 0;
> +    }
> +
> +    int idx =3D table_find(name, nlen);
> +    if (idx >=3D 0) {
> +        if (!overwrite) return 0;
> +        free(internal_table[idx]);
> +        internal_table[idx] =3D NULL;
> +    } else {
> +        /* Grow table if needed (keep a NULL sentinel). */
> +        if (internal_count + 1 >=3D internal_cap) {
> +            internal_cap =3D (internal_cap < 8) ? 16 : internal_cap * 2;
> +            char **t =3D realloc(internal_table,
> +                               (size_t)internal_cap * sizeof(char *));
> +            if (!t) return -1;
> +            internal_table =3D t;
> +        }
> +        idx =3D internal_count++;
> +        internal_table[internal_count] =3D NULL;  /* sentinel */
> +    }
> +
> +    char *entry =3D malloc(nlen + 1 + vlen + 1);
> +    if (!entry) return -1;
> +    memcpy(entry, name, nlen);
> +    entry[nlen] =3D '=3D';
> +    memcpy(entry + nlen + 1, value, vlen + 1);
> +    internal_table[idx] =3D entry;
> +    return 0;
> +}
> +
> +char *getenv(const char *name)
> +{
> +    if (!name) return NULL;
> +    size_t nlen =3D strlen(name);
> +    /*
> +     * Before main() initialises internal_table, fall back to searching
> +     * 'environ' directly.  This is needed because pseudo's library
> +     * constructor (which runs before main()) calls getenv() to read
> +     * PSEUDO_PREFIX and similar variables.
> +     */
> +    if (!internal_table) {
> +        for (int i =3D 0; environ && environ[i]; i++) {
> +            if (strncmp(environ[i], name, nlen) =3D=3D 0 &&
> +                environ[i][nlen] =3D=3D '=3D')
> +                return environ[i] + nlen + 1;
> +        }
> +        return NULL;
> +    }
> +    int idx =3D table_find(name, nlen);
> +    if (idx < 0) return NULL;
> +    return internal_table[idx] + nlen + 1;
> +}
> +
> +int unsetenv(const char *name)
> +{
> +    if (!name || !*name || strchr(name, '=3D')) { errno =3D EINVAL; retu=
rn -1; }
> +    size_t nlen =3D strlen(name);
> +    /* Before internal_table is initialised, remove from environ directl=
y. */
> +    if (!internal_table) {
> +        if (environ) {
> +            for (int i =3D 0; environ[i]; i++) {
> +                if (strncmp(environ[i], name, nlen) =3D=3D 0 &&
> +                    environ[i][nlen] =3D=3D '=3D') {
> +                    free(environ[i]);
> +                    int j =3D i;
> +                    while (environ[j]) { environ[j] =3D environ[j+1]; j+=
+; }
> +                    break;
> +                }
> +            }
> +        }
> +        return 0;
> +    }
> +    int idx =3D table_find(name, nlen);
> +    if (idx < 0) return 0;
> +    free(internal_table[idx]);
> +    memmove(&internal_table[idx], &internal_table[idx + 1],
> +            (size_t)(internal_count - idx) * sizeof(char *));
> +    internal_count--;
> +    return 0;
> +}
> +
> +#pragma GCC diagnostic pop
> +
> +/* ------------------------------------------------------------------ */
> +/* strip_asan_from_preload =E2=80=94 remove any libasan*.so entry from a=
n      */
> +/* LD_PRELOAD value string (colon-separated list).                     *=
/
> +/*                                                                      =
*/
> +/* The ASAN library must be first in LD_PRELOAD so that ASAN properly  *=
/
> +/* intercepts malloc/free from all shared libraries (including         *=
/
> +/* libpseudo.so).  But the pseudo server-spawn grandchild must NOT     *=
/
> +/* inherit it: the server is not ASAN-compiled and loading the ASAN    *=
/
> +/* runtime into an uninstrumented binary causes SQLite lock failures.  *=
/
> +/*                                                                      =
*/
> +/* By stripping libasan from the rebuilt 'environ' (produced by        *=
/
> +/* maybe_make_export_env), the server inherits clean LD_PRELOAD while  *=
/
> +/* ASAN detection in the direct child (fork of our binary) remains    */
> +/* active =E2=80=94 ASAN is compiled into the binary and its hooks are a=
lready */
> +/* live from process startup.                                           =
*/
> +/* ------------------------------------------------------------------ */
> +static char *strip_asan_from_preload(const char *preload)
> +{
> +    if (!preload) return NULL;
> +    char *buf =3D strdup(preload);
> +    if (!buf) return NULL;
> +
> +    char *out =3D buf;
> +    const char *in  =3D preload;
> +    while (*in) {
> +        const char *sep =3D strchr(in, ':');
> +        size_t len =3D sep ? (size_t)(sep - in) : strlen(in);
> +
> +        /* skip any entry that contains "libasan" */
> +        int skip =3D 0;
> +        for (size_t k =3D 0; k + 6 <=3D len; k++) {
> +            if (strncmp(in + k, "libasan", 7) =3D=3D 0) { skip =3D 1; br=
eak; }
> +        }
> +
> +        if (!skip) {
> +            memcpy(out, in, len);
> +            out +=3D len;
> +            if (sep) *out++ =3D ':';
> +        }
> +
> +        in +=3D len;
> +        if (*in =3D=3D ':') in++;
> +    }
> +    /* trim a trailing colon */
> +    if (out > buf && *(out - 1) =3D=3D ':') out--;
> +    *out =3D '\0';
> +    return buf;
> +}
> +
> +/* ------------------------------------------------------------------ */
> +/* strvec_flush =E2=80=94 free every string in v[] then free v itself.  =
       */
> +/* Equivalent to bash's strvec_flush() in lib/sh/stringvec.c.         */
> +/* ------------------------------------------------------------------ */
> +static void strvec_flush(char **v)
> +{
> +    if (!v) return;
> +    for (int i =3D 0; v[i]; i++)
> +        free(v[i]);
> +    free(v);
> +}
> +
> +/* ------------------------------------------------------------------ */
> +/* maybe_make_export_env =E2=80=94 rebuild 'environ' from the internal t=
able.  */
> +/*                                                                      =
*/
> +/* This is the function that triggers the use-after-free:              *=
/
> +/*                                                                      =
*/
> +/*   1. pseudo's fork wrapper called glibc's setenv (via               *=
/
> +/*      dlsym(RTLD_NEXT)) which allocated block A and stored it in     *=
/
> +/*      environ[LD_PRELOAD_idx].                                        =
*/
> +/*                                                                      =
*/
> +/*   2. strvec_flush(old_environ) frees block A.                       *=
/
> +/*                                                                      =
*/
> +/*   3. environ is updated to point to the freshly built array         *=
/
> +/*      (built from internal_table, which has the original LD_PRELOAD  *=
/
> +/*      without libpseudo.so).                                         *=
/
> +/*                                                                      =
*/
> +/*   4. When the exec wrapper runs pseudo_setupenvp(environ), the      *=
/
> +/*      allocator may have already reused block A, causing the freed   *=
/
> +/*      memory to be read with stale or garbage content.               *=
/
> +/* ------------------------------------------------------------------ */
> +static void maybe_make_export_env(void)
> +{
> +    char **old =3D environ;
> +
> +    /* Build fresh copy from internal_table. */
> +    char **new_env =3D malloc((size_t)(internal_count + 1) * sizeof(char=
 *));
> +    if (!new_env) return;
> +
> +    for (int i =3D 0; i < internal_count; i++) {
> +        new_env[i] =3D strdup(internal_table[i]);
> +        if (!new_env[i]) {
> +            for (int j =3D 0; j < i; j++) free(new_env[j]);
> +            free(new_env);
> +            return;
> +        }
> +    }
> +    new_env[internal_count] =3D NULL;
> +
> +    /* Strip the ASAN runtime library from LD_PRELOAD in BOTH the rebuil=
t
> +     * environ AND internal_table so that the pseudo server-spawn grandc=
hild
> +     * does not inherit it (via pseudo_setupenv reading internal_table).
> +     *
> +     * ASAN detection in the current process is unaffected: libasan.so i=
s
> +     * already mapped in the process address space (loaded at startup vi=
a the
> +     * original LD_PRELOAD) and its malloc/free interception is active a=
t the
> +     * GOT/PLT level for all shared libraries including libpseudo.so.
> +     * Removing it from environ/internal_table only affects exec'd child=
ren. */
> +    const char *ldp =3D "LD_PRELOAD=3D";
> +    size_t ldp_len =3D strlen(ldp);
> +    for (int i =3D 0; i < internal_count; i++) {
> +        if (strncmp(new_env[i], ldp, ldp_len) =3D=3D 0) {
> +            char *stripped =3D strip_asan_from_preload(new_env[i] + ldp_=
len);
> +            if (stripped) {
> +                char *new_entry =3D malloc(ldp_len + strlen(stripped) + =
1);
> +                if (new_entry) {
> +                    memcpy(new_entry, ldp, ldp_len);
> +                    strcpy(new_entry + ldp_len, stripped);
> +                    free(new_env[i]);
> +                    new_env[i] =3D new_entry;
> +                }
> +                free(stripped);
> +            }
> +            break;
> +        }
> +    }
> +    /* Also strip from internal_table so pseudo_setupenv() doesn't
> +     * re-inject libasan into environ via SETENV(). */
> +    for (int i =3D 0; i < internal_count; i++) {
> +        if (strncmp(internal_table[i], ldp, ldp_len) =3D=3D 0) {
> +            char *stripped =3D strip_asan_from_preload(internal_table[i]=
 + ldp_len);
> +            if (stripped) {
> +                char *new_entry =3D malloc(ldp_len + strlen(stripped) + =
1);
> +                if (new_entry) {
> +                    memcpy(new_entry, ldp, ldp_len);
> +                    strcpy(new_entry + ldp_len, stripped);
> +                    free(internal_table[i]);
> +                    internal_table[i] =3D new_entry;
> +                }
> +                free(stripped);
> +            }
> +            break;
> +        }
> +    }
> +
> +    /*
> +     * Free the old environ.  This releases every entry including any
> +     * block that glibc's setenv (called by pseudo_setupenv inside the
> +     * fork wrapper) had allocated.  After this, 'environ' briefly
> +     * points to freed memory until the assignment below.
> +     */
> +    strvec_flush(old);
> +
> +    environ =3D new_env;
> +}
> +
> +/* ------------------------------------------------------------------ */
> +/* run_pipeline_iteration                                               =
*/
> +/*                                                                      =
*/
> +/* Simulate one opkg-build pipeline:                                   *=
/
> +/*   ( cd CTRL && find . | sort > list )                               *=
/
> +/*   ( cd PKG  && find . | sort > list )                               *=
/
> +/*   ( cd PKG  && tar  =E2=80=A6 | gzip  > data.tar.gz )                =
      */
> +/*   ( cd CTRL && tar  =E2=80=A6 | gzip  > ctrl.tar.gz )                =
      */
> +/*   ( cd TMP  && ar =E2=80=A6               )                          =
       */
> +/*                                                                      =
*/
> +/* Each child simulates one pipeline stage:                            *=
/
> +/*   fork =E2=86=92 [pseudo fork wrapper runs pseudo_setupenv() in the c=
hild]  */
> +/*   child: check whether pseudo mutated the real environ (bug), then  *=
/
> +/*          maybe_make_export_env() and execve("/bin/true")            *=
/
> +/* ------------------------------------------------------------------ */
> +#define PIPELINE_STAGES 5   /* find, sort, tar, gzip, ar */

This is not "one pipeline". It's five separate shell statements, with at
most two commands in a pipeline. But the function below seems to
simulate a single pipeline of five commands.

> +
> +/* Distinct exit code a child uses to report that pseudo mutated the
> + * real 'environ' array (i.e. the unfixed glibc-setenv code path ran). *=
/
> +#define BUG_ENV_MUTATED 42
> +
> +/* ------------------------------------------------------------------ */
> +/* pseudo_mutated_environ =E2=80=94 deterministic detector for the bug f=
ixed   */
> +/* by commits 9c6b4c1..5abd42c.                                        *=
/
> +/*                                                                      =
*/
> +/* pseudo's fork wrapper runs pseudo_setupenv() in every child before   =
*/
> +/* fork() returns.  pseudo_setupenv() re-adds the PSEUDO_* variables    =
*/
> +/* (PSEUDO_BINDIR, PSEUDO_LIBDIR, =E2=80=A6) that main() stripped from t=
he      */
> +/* environment:                                                         =
*/
> +/*                                                                      =
*/
> +/*   Unfixed pseudo:  SETENV -> pseudo_real_setenv (dlsym RTLD_NEXT) -> =
*/
> +/*     glibc setenv, which writes directly into the real 'environ'      =
*/
> +/*     array.  The stripped PSEUDO_* vars therefore REAPPEAR in the     =
*/
> +/*     real environ =E2=80=94 exactly the environ/allocator desync that =
        */
> +/*     corrupts bash's heap in production.                              =
*/
> +/*                                                                      =
*/
> +/*   Fixed pseudo:  SETENV -> setenv -> our (bash's) setenv, which only =
*/
> +/*     updates internal_table; the exec/system/popen wrappers build a   =
*/
> +/*     private copy with pseudo_setupenvp() and restore environ.  The   =
*/
> +/*     real 'environ' is left untouched, so the stripped PSEUDO_* vars  =
*/
> +/*     do NOT reappear there.                                           =
*/
> +/*                                                                      =
*/
> +/* Returns 1 if a stripped PSEUDO_* var was found back in the real      =
*/
> +/* environ (buggy code path), 0 otherwise.  Must be called BEFORE       =
*/
> +/* maybe_make_export_env(), which would otherwise rebuild environ from  =
*/
> +/* internal_table and discard the injected entries.                     =
*/
> +/* ------------------------------------------------------------------ */
> +static int pseudo_mutated_environ(void)
> +{
> +    for (int i =3D 0; environ && environ[i]; i++) {
> +        if (strncmp(environ[i], "PSEUDO_BINDIR=3D", 14) =3D=3D 0 ||
> +            strncmp(environ[i], "PSEUDO_LIBDIR=3D", 14) =3D=3D 0)
> +            return 1;
> +    }
> +    return 0;
> +}
> +
> +static int run_pipeline_iteration(void)
> +{
> +    pid_t pids[PIPELINE_STAGES];
> +    char *const args[] =3D { "/bin/true", NULL };
> +
> +    /*
> +     * Fork all pipeline stages before waiting for any of them, just
> +     * as bash does for a pipeline.  pseudo's fork wrapper runs
> +     * pseudo_setupenv() in each child before fork() returns.
> +     */
> +    for (int s =3D 0; s < PIPELINE_STAGES; s++) {
> +        pid_t pid =3D fork();
> +        if (pid < 0) {
> +            perror("fork");
> +            return -1;
> +        }
> +        if (pid =3D=3D 0) {
> +            /*
> +             * Child: pseudo's fork wrapper has already run
> +             * pseudo_setupenv() at this point.  Deterministically
> +             * detect whether it mutated the real environ (the bug)
> +             * before doing anything that would rebuild environ.
> +             */
> +            if (pseudo_mutated_environ())
> +                _exit(BUG_ENV_MUTATED);
> +            /*
> +             * Otherwise behave like bash: rebuild environ from the
> +             * internal table and exec the pipeline stage.
> +             */
> +            maybe_make_export_env();
> +            execve("/bin/true", args, environ);
> +            _exit(127);
> +        }
> +        pids[s] =3D pid;
> +    }
> +
> +    /* Wait for all pipeline children. */
> +    for (int s =3D 0; s < PIPELINE_STAGES; s++) {
> +        int status;
> +        if (waitpid(pids[s], &status, 0) < 0) {
> +            perror("waitpid");
> +            return -1;
> +        }
> +        if (WIFEXITED(status) && WEXITSTATUS(status) =3D=3D BUG_ENV_MUTA=
TED) {
> +            fprintf(stderr,
> +                "BUG: pseudo mutated the real environ in pipeline stage =
%d "
> +                "(pseudo_setupenv used glibc setenv via dlsym instead of=
 the "
> +                "process's own setenv)\n", s);
> +            return -1;
> +        }
> +        if (!WIFEXITED(status) || WEXITSTATUS(status) !=3D 0) {
> +            fprintf(stderr, "pipeline stage %d failed: status=3D%d\n",
> +                    s, status);
> +            return -1;
> +        }
> +    }
> +    return 0;
> +}
> +
> +int main(void)
> +{
> +    /* Initialise internal_table from the process's current environ. */
> +    int count =3D 0;
> +    while (environ[count]) count++;
> +
> +    internal_cap =3D count + 32;
> +    internal_table =3D malloc((size_t)internal_cap * sizeof(char *));
> +    if (!internal_table) { perror("malloc"); return 1; }
> +
> +    for (int i =3D 0; i < count; i++) {
> +        internal_table[i] =3D strdup(environ[i]);
> +        if (!internal_table[i]) { perror("strdup"); return 1; }
> +    }
> +    internal_table[count] =3D NULL;
> +    internal_count =3D count;
> +
> +    /*
> +     * Replace environ with a heap-allocated copy before any call to
> +     * maybe_make_export_env().  The initial environ supplied by the
> +     * kernel exec is in static memory, not the heap; calling free()
> +     * on those strings (as strvec_flush does) would crash immediately.
> +     * bash avoids this by building its own heap-allocated export_env
> +     * during shell initialisation; we replicate that here.
> +     */
> +    {
> +        char **heap_env =3D malloc((size_t)(count + 1) * sizeof(char *))=
;
> +        if (!heap_env) { perror("malloc"); return 1; }
> +        for (int i =3D 0; i < count; i++) {
> +            heap_env[i] =3D strdup(internal_table[i]);
> +            if (!heap_env[i]) { perror("strdup"); return 1; }
> +        }
> +        heap_env[count] =3D NULL;
> +        environ =3D heap_env;   /* now environ is entirely heap-managed =
*/
> +    }

This would be clearer as a separate function that gets called rather
than a nested scope.

> +
> +    /*
> +     * Run 20 pipeline iterations.  With the unfixed pseudo code and
> +     * MALLOC_CHECK_=3D3, the heap corruption introduced by pseudo_setup=
env
> +     * (glibc setenv) followed by strvec_flush causes an abort within
> +     * the first few iterations on affected platforms.
> +     */

This comment belongs with the for loop at the end of the function.

> +
> +    /*
> +     * Strip the ASAN runtime library from LD_PRELOAD and strip derived
> +     * PSEUDO_* vars (PSEUDO_BINDIR, PSEUDO_LIBDIR, etc.) from both
> +     * internal_table and heap environ BEFORE any pseudo-intercepted cal=
l.
> +     *
> +     * Reason for stripping ASAN from LD_PRELOAD:
> +     *   The pseudo server-spawn grandchild is not ASAN-compiled; loadin=
g the
> +     *   ASAN runtime into an uninstrumented binary causes SQLite lock f=
ailures.

This duplicates (badly) the explanation already given in the comment for
strip_asan_from_preload().

> +     *
> +     * Reason for stripping derived PSEUDO_* vars:
> +     *   When the test runs inside the pseudo test framework, the outer =
pseudo's
> +     *   exec wrapper pre-populates all PSEUDO_* vars (PSEUDO_BINDIR etc=
.) in
> +     *   the binary's initial environ via pseudo_setupenvp().  If these =
are
> +     *   already present, pseudo_setupenv() treats them as existing (ove=
rwrite=3D0)
> +     *   and makes no change =E2=80=94 no __add_to_environ() call, no he=
ap-corruption
> +     *   opportunity, MALLOC_CHECK_=3D3 detects nothing.
> +     *   By stripping them here we force pseudo_setupenv() (in the fork =
wrapper
> +     *   of every child) to ADD them as NEW environ entries.  The unfixe=
d code
> +     *   (glibc setenv via dlsym RTLD_NEXT) calls __add_to_environ() whi=
ch
> +     *   calls realloc(environ_array).  strvec_flush() later frees that
> +     *   allocation, and MALLOC_CHECK_=3D3 aborts the server-spawn grand=
child.
> +     *   The fixed code calls our binary's setenv() which updates intern=
al_table
> +     *   only =E2=80=94 no __add_to_environ(), no realloc, no corruption=
.
> +     *
> +     * We keep PSEUDO_PREFIX and PSEUDO_LOCALSTATEDIR so that pseudo can=
 find
> +     * the server binary and socket directory.
> +     */
> +    {
> +        const char *ldp    =3D "LD_PRELOAD=3D";
> +        size_t      ldp_len =3D strlen(ldp);
> +
> +        /* is_kept: return 1 if the env entry should NOT be stripped.
> +         * Keep non-PSEUDO, non-LD_PRELOAD, PSEUDO_PREFIX, PSEUDO_LOCALS=
TATEDIR.
> +         */
> +        /* NOTE: GCC nested functions are used here for locality; the la=
mbda
> +         * captures ldp/ldp_len by enclosing scope (auto function). */
> +        int is_kept(const char *entry) {
> +            if (strncmp(entry, "PSEUDO_", 7) !=3D 0 &&
> +                strncmp(entry, ldp, ldp_len) !=3D 0)
> +                return 1;
> +            if (strncmp(entry, "PSEUDO_PREFIX=3D",       14) =3D=3D 0) r=
eturn 1;
> +            if (strncmp(entry, "PSEUDO_LOCALSTATEDIR=3D", 21) =3D=3D 0) =
return 1;
> +            return 0;
> +        }

This is nonsense - ldp & ldp_len are constants, they don't need to be
captured into a nested function for "locality". Better to define them as
global constants and move is_kept() to the top level.

> +
> +        /* Process internal_table */
> +        {
> +            int w =3D 0;
> +            for (int i =3D 0; i < internal_count; i++) {
> +                if (strncmp(internal_table[i], ldp, ldp_len) =3D=3D 0) {
> +                    /* LD_PRELOAD: strip ASAN lib, keep pseudo lib */
> +                    char *s =3D strip_asan_from_preload(
> +                                  internal_table[i] + ldp_len);
> +                    char *e =3D s ? malloc(ldp_len + strlen(s) + 1) : NU=
LL;
> +                    if (e) {
> +                        memcpy(e, ldp, ldp_len);
> +                        strcpy(e + ldp_len, s);
> +                    }
> +                    free(internal_table[i]);
> +                    free(s);
> +                    if (e) internal_table[w++] =3D e;
> +                } else if (is_kept(internal_table[i])) {
> +                    internal_table[w++] =3D internal_table[i];
> +                } else {
> +                    free(internal_table[i]); /* drop PSEUDO_BINDIR etc. =
*/
> +                }
> +            }
> +            internal_count =3D w;
> +            internal_table[w] =3D NULL;
> +        }
> +
> +        /* Process environ (the heap copy) */
> +        {
> +            int w =3D 0;
> +            for (int i =3D 0; environ[i]; i++) {
> +                if (strncmp(environ[i], ldp, ldp_len) =3D=3D 0) {
> +                    char *s =3D strip_asan_from_preload(environ[i] + ldp=
_len);
> +                    char *e =3D s ? malloc(ldp_len + strlen(s) + 1) : NU=
LL;
> +                    if (e) {
> +                        memcpy(e, ldp, ldp_len);
> +                        strcpy(e + ldp_len, s);
> +                    }
> +                    free(environ[i]);
> +                    free(s);
> +                    if (e) environ[w++] =3D e;
> +                } else if (is_kept(environ[i])) {
> +                    environ[w++] =3D environ[i];
> +                } else {
> +                    free(environ[i]); /* drop PSEUDO_BINDIR etc. */
> +                }
> +            }
> +            environ[w] =3D NULL;
> +        }

These nested scopes and reuse of a 'w' variable are just confusing.
It looks like there is a lot of duplicated code which can probably be
refactored into a function that gets called twice, once with
internal_table and once with environ.

> +    }
> +
> +    /*
> +     * Force pseudo server startup in the parent before any children are
> +     * forked.  Without this, all PIPELINE_STAGES children may try to sp=
awn
> +     * the server simultaneously, causing a "lock_held" race condition o=
n the
> +     * first iteration.
> +     */
> +    access(".", F_OK);
> +
> +    int iterations =3D 20;
> +    for (int i =3D 0; i < iterations; i++) {
> +        if (run_pipeline_iteration() !=3D 0) {
> +            fprintf(stderr, "FAILED on pipeline iteration %d\n", i + 1);
> +            return 1;
> +        }
> +    }
> +
> +    return 0;
> +}
> diff --git a/test/test-bash-exec-env.sh b/test/test-bash-exec-env.sh
> new file mode 100755
> index 0000000..d95a04d
> --- /dev/null
> +++ b/test/test-bash-exec-env.sh
> @@ -0,0 +1,34 @@
> +#!/bin/bash
> +#
> +# SPDX-License-Identifier: LGPL-2.1-only
> +#
> +# Test for the bash/pseudo environment conflict:
> +#   https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D16078
> +#
> +# The compiled helper binary (test-bash-exec-env.c) exports its own
> +# getenv/setenv/unsetenv (simulating bash) and calls maybe_make_export_e=
nv()
> +# before each execve(), exactly reproducing the opkg-build crash pattern=
.
> +#
> +# Detection mechanism:
> +#   The binary strips all PSEUDO_* vars (except PSEUDO_PREFIX and
> +#   PSEUDO_LOCALSTATEDIR) from its internal table and environ before
> +#   starting.  This forces pseudo_setupenv() =E2=80=94 called by pseudo'=
s fork
> +#   wrapper in each child =E2=80=94 to ADD those vars back.
> +#
> +#   The check is deterministic: each child inspects the real environ aft=
er
> +#   pseudo's fork wrapper has run.
> +#
> +#   Unfixed pseudo: SETENV() -> dlsym(RTLD_NEXT) -> glibc setenv writes =
the
> +#     stripped PSEUDO_* vars straight back into the real environ array. =
 The
> +#     child sees them reappear and reports the bug (exit 42); the test f=
ails.
> +#
> +#   Fixed pseudo: SETENV() -> our binary's setenv() -> internal_table on=
ly;
> +#     the real environ is left untouched, no PSEUDO_* vars reappear, the=
 child
> +#     execs cleanly and the test passes.
> +#
> +#   MALLOC_CHECK_=3D3 is kept as a secondary safety net so any residual =
heap
> +#   corruption from the unfixed code also aborts the run.
> +
> +MALLOC_CHECK_=3D3 $(dirname "$0")/test-bash-exec-env || { echo "FAILED: =
test-bash-exec-env returned $?" ; exit 1; }
> +
> +exit 0

Best regards,

--=20
Paul Barker


--=-HpY21uC2n6pwRTXlFkWk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCakeZThEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bhJ8AQDsYGxZWgvUBnazSlweNkkH7Pw7vofnR7qb
Vz2X2e1lzAD/UyGjjweqbyMQARKcOfY8UPtE7aRCB+9OKz65xbBq9Aw=
=xxIK
-----END PGP SIGNATURE-----

--=-HpY21uC2n6pwRTXlFkWk--

