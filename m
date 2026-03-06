Return-Path: <hprajapati@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED579F01832
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 12:18:47 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.67783.1772799519038595252
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Mar 2026 04:18:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=VtdbTzi1;
 spf=pass (domain: mvista.com, ip: 74.125.82.172, mailfrom: hprajapati@mvista.com)
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so7615095eec.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 04:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1772799518; x=1773404318; darn=lists.yoctoproject.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF2KV7ffsgKNn1kdHg4rk+M48SYIWkCbGswfS2vz1uQ=;
        b=VtdbTzi1va5ljq7CnaKSwnysCFb+J6A7TV1a71gCO58ClddNOAOQkEqi6P3aRHc1G2
         klGaFV4HMEYxxWTLVHJRvR26yM6TR8jGrJe18msnKQL7T8do2/dQOoIcvw+RJM78Lm38
         OaN83m4EKDCfEvf7HeM4L78RtEik1/J1tICwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772799518; x=1773404318;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aF2KV7ffsgKNn1kdHg4rk+M48SYIWkCbGswfS2vz1uQ=;
        b=d3wAUKFvPHRu+PRuTa9NfM6u8YEVslLeFxsJPfKWs40geo2LvbITIPb2PqGVUdxKGg
         HlB0Vxf6UEn5balecaxA7l79q81QuSgM4WathH824jV/RaLgj9BtHA7cyZrCeeGdv6kY
         DJDC1u2BUQfuhRvl/d7pveQezzRGIgJOvBgcUAVt3yIGcW+yzBwz8uPYxA0DqjoEy7Sp
         vZqufYqkY8o9rTYyTRnm+OsQcsWWsb6XMocZUs7NbUx6XEoBsM48hdmJAU9eVgv2oMe3
         p5vPROtyk8REWIY4bVKSpfDGy8oqpYV/aHyHnfhVtmwkPV5sXsTavYl2up6YcsbO6SAC
         YQQw==
X-Gm-Message-State: AOJu0YxGmOxkswQvdle7xY0Z6qNWQ7UCQIDjG8wnssUBWjuXe2mDJZNo
	meFQnC5NrxEc6BTFSlB5XMV8s4eqVtixBM0dzRz9BAsD1aBOvofBdnOdyhxNvQXSSnXDOHy/awI
	JNWIDkbI=
X-Gm-Gg: ATEYQzzTuxbaKYkC6y/BIKmxuFZJYZSWmkzihuezMq5CWOCMZ5sTSDX5MA4/pK0d08/
	dJIqZJjRaClW/C88zsBR8QgFdUhHoX88e+YuiVjw5B6ntWeY+i5XIQadDPSJwl3JR2w/x7xc1bi
	kMs1yZAXLgkhQ3yPlo6Dh2LxLOiP3SnLkgz6HheMvRysqbJCl4qXqFDQKwG5qjX4XU4LoznImYc
	GAiyFvPJd/mqbdA7EAL5mgyPB3dMGKStLCEOU1zqsldsLD/QboR5qsnNCxy5SM3fXqtfcxvss/X
	ao4SCRYntSKC+xew63lwCTKJPZpwHrm8u3Rsn7W1tQqgdyY92Z963O1TFKCIj45LHEOe5NmWdKj
	3ydYkFUVvLO5q4Pxu4TcgVEtgc+OI4b9CgmODmRokxd3fy11Ie7zv6VJXFGnoi3qZ7ekcHhAphk
	O/LVK6Nil7cfLHfihaveN6A2XUDEufFA==
X-Received: by 2002:a05:7301:1018:b0:2ba:9835:112d with SMTP id 5a478bee46e88-2be4de928e2mr658365eec.3.1772799517220;
        Fri, 06 Mar 2026 04:18:37 -0800 (PST)
Received: from [192.168.1.100] ([150.129.170.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f82b1d3sm1044840eec.11.2026.03.06.04.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 04:18:36 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------jT0hXWsRfjrhPD3q545rlzHR"
Message-ID: <c59313db-fa3c-4e23-b5b2-44762950491d@mvista.com>
Date: Fri, 6 Mar 2026 17:48:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-security][scarthgap][PATCH] suricata: update to 7.0.13
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com
References: <20260216112838.17952-1-hprajapati@mvista.com>
Content-Language: en-US
From: Hitendra Prajapati <hprajapati@mvista.com>
In-Reply-To: <20260216112838.17952-1-hprajapati@mvista.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 12:18:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3347

This is a multi-part message in MIME format.
--------------jT0hXWsRfjrhPD3q545rlzHR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Team,

Any update ?

On 16/02/26 4:58 pm, Hitendra Prajapati wrote:
> Release notes:
> https://suricata.io/2025/11/06/suricata-8-0-2-and-7-0-13-released/
>
> See suricata release notes for more details about changes and CVEs
> fixed.
>
> Signed-off-by: Hitendra Prajapati<hprajapati@mvista.com>
> ---
>   recipes-ids/suricata/suricata-crates.inc      | 1437 +++++++++--------
>   ...{suricata_7.0.12.bb => suricata_7.0.13.bb} |    2 +-
>   2 files changed, 734 insertions(+), 705 deletions(-)
>   rename recipes-ids/suricata/{suricata_7.0.12.bb => suricata_7.0.13.bb} (98%)
>
> diff --git a/recipes-ids/suricata/suricata-crates.inc b/recipes-ids/suricata/suricata-crates.inc
> index 0755302..9c65acf 100644
> --- a/recipes-ids/suricata/suricata-crates.inc
> +++ b/recipes-ids/suricata/suricata-crates.inc
> @@ -1,547 +1,125 @@
>   # Autogenerated with 'bitbake -c update_crates suricata'
>   
>   # from rust/Cargo.lock
> -SRC_URI += "crate://crates.io/adler/1.0.2 \
> -           crate://crates.io/aead/0.4.3 \
> -           crate://crates.io/aes/0.7.5 \
> -           crate://crates.io/aes-gcm/0.9.4 \
> -           crate://crates.io/aho-corasick/0.7.20 \
> -           crate://crates.io/alloc-no-stdlib/2.0.4 \
> -           crate://crates.io/alloc-stdlib/0.2.2 \
> -           crate://crates.io/asn1-rs/0.5.2 \
> -           crate://crates.io/asn1-rs-derive/0.4.0 \
> -           crate://crates.io/asn1-rs-impl/0.1.0 \
> -           crate://crates.io/autocfg/1.1.0 \
> -           crate://crates.io/base64/0.13.1 \
> -           crate://crates.io/bendy/0.3.3 \
> -           crate://crates.io/bitflags/1.2.1 \
> -           crate://crates.io/block-buffer/0.10.4 \
> -           crate://crates.io/brotli/8.0.1 \
> -           crate://crates.io/brotli-decompressor/5.0.0 \
> -           crate://crates.io/build_const/0.2.2 \
> -           crate://crates.io/byteorder/1.4.3 \
> -           crate://crates.io/cfg-if/1.0.0 \
> -           crate://crates.io/cipher/0.3.0 \
> -           crate://crates.io/cpufeatures/0.2.11 \
> -           crate://crates.io/crc/1.8.1 \
> -           crate://crates.io/crc32fast/1.3.2 \
> -           crate://crates.io/crypto-common/0.1.6 \
> -           crate://crates.io/ctr/0.8.0 \
> -           crate://crates.io/data-encoding/2.4.0 \
> -           crate://crates.io/der-oid-macro/0.5.0 \
> -           crate://crates.io/der-parser/6.0.1 \
> -           crate://crates.io/der-parser/8.2.0 \
> -           crate://crates.io/digest/0.10.7 \
> -           crate://crates.io/displaydoc/0.2.4 \
> -           crate://crates.io/enum_primitive/0.1.1 \
> -           crate://crates.io/failure/0.1.8 \
> -           crate://crates.io/failure_derive/0.1.8 \
> -           crate://crates.io/flate2/1.0.28 \
> -           crate://crates.io/generic-array/0.14.7 \
> -           crate://crates.io/getrandom/0.2.11 \
> -           crate://crates.io/ghash/0.4.4 \
> -           crate://crates.io/hex/0.4.3 \
> -           crate://crates.io/hkdf/0.12.3 \
> -           crate://crates.io/hmac/0.12.1 \
> -           crate://crates.io/ipsec-parser/0.7.0 \
> -           crate://crates.io/itoa/1.0.9 \
> -           crate://crates.io/kerberos-parser/0.7.1 \
> -           crate://crates.io/lazy_static/1.4.0 \
> -           crate://crates.io/libc/0.2.150 \
> -           crate://crates.io/lzma-rs/0.2.0 \
> -           crate://crates.io/md-5/0.10.6 \
> -           crate://crates.io/memchr/2.4.1 \
> -           crate://crates.io/minimal-lexical/0.2.1 \
> -           crate://crates.io/miniz_oxide/0.7.1 \
> -           crate://crates.io/nom/7.1.3 \
> -           crate://crates.io/nom-derive/0.10.1 \
> -           crate://crates.io/nom-derive-impl/0.10.1 \
> -           crate://crates.io/ntp-parser/0.6.0 \
> -           crate://crates.io/num/0.2.1 \
> -           crate://crates.io/num-bigint/0.2.6 \
> -           crate://crates.io/num-bigint/0.4.4 \
> -           crate://crates.io/num-complex/0.2.4 \
> -           crate://crates.io/num-derive/0.4.2 \
> -           crate://crates.io/num-integer/0.1.45 \
> -           crate://crates.io/num-iter/0.1.43 \
> -           crate://crates.io/num-rational/0.2.4 \
> -           crate://crates.io/num-traits/0.1.43 \
> -           crate://crates.io/num-traits/0.2.17 \
> -           crate://crates.io/num_enum/0.5.11 \
> -           crate://crates.io/num_enum_derive/0.5.11 \
> -           crate://crates.io/num_threads/0.1.6 \
> -           crate://crates.io/oid-registry/0.6.1 \
> -           crate://crates.io/opaque-debug/0.3.0 \
> -           crate://crates.io/phf/0.10.1 \
> -           crate://crates.io/phf_codegen/0.10.0 \
> -           crate://crates.io/phf_generator/0.10.0 \
> -           crate://crates.io/phf_shared/0.10.0 \
> -           crate://crates.io/polyval/0.5.3 \
> -           crate://crates.io/ppv-lite86/0.2.17 \
> -           crate://crates.io/proc-macro-crate/1.1.0 \
> -           crate://crates.io/proc-macro2/1.0.69 \
> -           crate://crates.io/quote/1.0.33 \
> -           crate://crates.io/rand/0.8.5 \
> -           crate://crates.io/rand_chacha/0.3.1 \
> -           crate://crates.io/rand_core/0.6.4 \
> -           crate://crates.io/regex/1.5.6 \
> -           crate://crates.io/regex-syntax/0.6.29 \
> -           crate://crates.io/rusticata-macros/4.1.0 \
> -           crate://crates.io/rustversion/1.0.14 \
> -           crate://crates.io/sawp/0.12.1 \
> -           crate://crates.io/sawp-flags/0.12.1 \
> -           crate://crates.io/sawp-flags-derive/0.12.1 \
> -           crate://crates.io/sawp-modbus/0.12.1 \
> -           crate://crates.io/serde/1.0.192 \
> -           crate://crates.io/serde_derive/1.0.192 \
> -           crate://crates.io/sha1/0.10.6 \
> -           crate://crates.io/sha2/0.10.8 \
> -           crate://crates.io/siphasher/0.3.11 \
> -           crate://crates.io/snmp-parser/0.9.0 \
> -           crate://crates.io/subtle/2.4.1 \
> -           crate://crates.io/syn/1.0.109 \
> -           crate://crates.io/syn/2.0.39 \
> -           crate://crates.io/synstructure/0.12.6 \
> -           crate://crates.io/test-case/1.1.0 \
> -           crate://crates.io/thiserror/1.0.50 \
> -           crate://crates.io/thiserror-impl/1.0.50 \
> -           crate://crates.io/time/0.3.13 \
> -           crate://crates.io/time-macros/0.2.4 \
> -           crate://crates.io/tls-parser/0.11.0 \
> -           crate://crates.io/toml/0.5.11 \
> -           crate://crates.io/typenum/1.17.0 \
> -           crate://crates.io/unicode-ident/1.0.12 \
> -           crate://crates.io/unicode-xid/0.2.4 \
> -           crate://crates.io/universal-hash/0.4.1 \
> -           crate://crates.io/uuid/0.8.2 \
> -           crate://crates.io/version_check/0.9.4 \
> -           crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
> -           crate://crates.io/widestring/0.4.3 \
> -           crate://crates.io/x509-parser/0.15.1 \
> -           crate://crates.io/ansi_term/0.12.1 \
> -           crate://crates.io/atty/0.2.14 \
> -           crate://crates.io/autocfg/0.1.8 \
> -           crate://crates.io/autocfg/1.1.0 \
> -           crate://crates.io/bitflags/1.3.2 \
> -           crate://crates.io/bstr/0.2.17 \
> -           crate://crates.io/bumpalo/3.11.1 \
> -           crate://crates.io/cast/0.2.7 \
> -           crate://crates.io/cast/0.3.0 \
> -           crate://crates.io/cfg-if/1.0.0 \
> -           crate://crates.io/clap/2.34.0 \
> -           crate://crates.io/cloudabi/0.0.3 \
> -           crate://crates.io/criterion/0.3.2 \
> -           crate://crates.io/criterion-plot/0.4.5 \
> -           crate://crates.io/crossbeam-channel/0.5.6 \
> -           crate://crates.io/crossbeam-deque/0.8.2 \
> -           crate://crates.io/crossbeam-epoch/0.9.11 \
> -           crate://crates.io/crossbeam-utils/0.8.12 \
> -           crate://crates.io/csv/1.1.6 \
> -           crate://crates.io/csv-core/0.1.10 \
> -           crate://crates.io/either/1.8.0 \
> -           crate://crates.io/fuchsia-cprng/0.1.1 \
> -           crate://crates.io/heck/0.3.3 \
> -           crate://crates.io/hermit-abi/0.1.19 \
> -           crate://crates.io/itertools/0.9.0 \
> -           crate://crates.io/itertools/0.10.5 \
> -           crate://crates.io/itoa/0.4.8 \
> -           crate://crates.io/itoa/1.0.4 \
> -           crate://crates.io/js-sys/0.3.60 \
> -           crate://crates.io/lazy_static/1.4.0 \
> -           crate://crates.io/libc/0.2.135 \
> -           crate://crates.io/log/0.4.17 \
> -           crate://crates.io/memchr/2.5.0 \
> -           crate://crates.io/memoffset/0.6.5 \
> -           crate://crates.io/num-traits/0.2.15 \
> -           crate://crates.io/num_cpus/1.13.1 \
> -           crate://crates.io/once_cell/1.15.0 \
> -           crate://crates.io/oorandom/11.1.3 \
> -           crate://crates.io/plotters/0.2.15 \
> -           crate://crates.io/proc-macro-error/1.0.4 \
> -           crate://crates.io/proc-macro-error-attr/1.0.4 \
> -           crate://crates.io/proc-macro2/1.0.47 \
> -           crate://crates.io/quote/1.0.21 \
> -           crate://crates.io/rand/0.6.5 \
> -           crate://crates.io/rand_chacha/0.1.1 \
> -           crate://crates.io/rand_core/0.3.1 \
> -           crate://crates.io/rand_core/0.4.2 \
> -           crate://crates.io/rand_hc/0.1.0 \
> -           crate://crates.io/rand_isaac/0.1.1 \
> -           crate://crates.io/rand_jitter/0.1.4 \
> -           crate://crates.io/rand_os/0.1.3 \
> -           crate://crates.io/rand_pcg/0.1.2 \
> -           crate://crates.io/rand_xorshift/0.1.1 \
> -           crate://crates.io/rayon/1.5.3 \
> -           crate://crates.io/rayon-core/1.9.3 \
> -           crate://crates.io/rdrand/0.4.0 \
> -           crate://crates.io/regex/1.6.0 \
> -           crate://crates.io/regex-automata/0.1.10 \
> -           crate://crates.io/regex-syntax/0.6.27 \
> -           crate://crates.io/rustc_version/0.4.0 \
> -           crate://crates.io/ryu/1.0.11 \
> -           crate://crates.io/same-file/1.0.6 \
> -           crate://crates.io/scopeguard/1.1.0 \
> -           crate://crates.io/semver/1.0.14 \
> -           crate://crates.io/serde/1.0.146 \
> -           crate://crates.io/serde_derive/1.0.146 \
> -           crate://crates.io/serde_json/1.0.87 \
> -           crate://crates.io/strsim/0.8.0 \
> -           crate://crates.io/structopt/0.3.26 \
> -           crate://crates.io/structopt-derive/0.4.18 \
> -           crate://crates.io/syn/1.0.103 \
> -           crate://crates.io/textwrap/0.11.0 \
> -           crate://crates.io/tinytemplate/1.2.1 \
> -           crate://crates.io/unicode-ident/1.0.5 \
> -           crate://crates.io/unicode-segmentation/1.10.0 \
> -           crate://crates.io/unicode-width/0.1.10 \
> -           crate://crates.io/vec_map/0.8.2 \
> -           crate://crates.io/version_check/0.9.4 \
> -           crate://crates.io/walkdir/2.3.2 \
> -           crate://crates.io/wasm-bindgen/0.2.83 \
> -           crate://crates.io/wasm-bindgen-backend/0.2.83 \
> -           crate://crates.io/wasm-bindgen-macro/0.2.83 \
> -           crate://crates.io/wasm-bindgen-macro-support/0.2.83 \
> -           crate://crates.io/wasm-bindgen-shared/0.2.83 \
> -           crate://crates.io/web-sys/0.3.60 \
> -           crate://crates.io/winapi/0.3.9 \
> -           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> -           crate://crates.io/winapi-util/0.1.5 \
> -           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> -           crate://crates.io/backtrace/0.3.46 \
> -           crate://crates.io/backtrace-sys/0.1.37 \
> -           crate://crates.io/cc/1.0.52 \
> -           crate://crates.io/cfg-if/0.1.10 \
> -           crate://crates.io/failure_derive/0.1.7 \
> -           crate://crates.io/libc/0.2.69 \
> -           crate://crates.io/proc-macro2/1.0.12 \
> -           crate://crates.io/quote/1.0.4 \
> -           crate://crates.io/rustc-demangle/0.1.16 \
> -           crate://crates.io/syn/1.0.18 \
> -           crate://crates.io/synstructure/0.12.3 \
> -           crate://crates.io/unicode-xid/0.2.0 \
> -           crate://crates.io/autocfg/1.1.0 \
> -           crate://crates.io/hashbrown/0.12.3 \
> -           crate://crates.io/indexmap/1.9.2 \
> -           crate://crates.io/itoa/1.0.5 \
> -           crate://crates.io/proc-macro2/1.0.50 \
> -           crate://crates.io/quote/1.0.23 \
> -           crate://crates.io/ryu/1.0.12 \
> -           crate://crates.io/serde/1.0.152 \
> -           crate://crates.io/serde_derive/1.0.152 \
> -           crate://crates.io/serde_json/1.0.91 \
> -           crate://crates.io/syn/1.0.107 \
> -           crate://crates.io/unicode-ident/1.0.6 \
> -           crate://crates.io/autocfg/1.0.1 \
> -           crate://crates.io/bit-set/0.5.2 \
> -           crate://crates.io/bit-vec/0.6.3 \
> -           crate://crates.io/bitflags/1.3.2 \
> -           crate://crates.io/byteorder/1.4.3 \
> -           crate://crates.io/cfg-if/1.0.0 \
> -           crate://crates.io/doc-comment/0.3.3 \
> -           crate://crates.io/fnv/1.0.7 \
> -           crate://crates.io/getrandom/0.2.3 \
> -           crate://crates.io/lazy_static/1.4.0 \
> -           crate://crates.io/libc/0.2.106 \
> -           crate://crates.io/memchr/2.4.1 \
> -           crate://crates.io/minimal-lexical/0.2.1 \
> -           crate://crates.io/num-traits/0.2.14 \
> -           crate://crates.io/ppv-lite86/0.2.15 \
> -           crate://crates.io/proptest/1.0.0 \
> -           crate://crates.io/quick-error/1.2.3 \
> -           crate://crates.io/quick-error/2.0.1 \
> -           crate://crates.io/rand/0.8.4 \
> -           crate://crates.io/rand_chacha/0.3.1 \
> -           crate://crates.io/rand_core/0.6.3 \
> -           crate://crates.io/rand_hc/0.3.1 \
> -           crate://crates.io/rand_xorshift/0.3.0 \
> -           crate://crates.io/redox_syscall/0.2.10 \
> -           crate://crates.io/regex-syntax/0.6.25 \
> -           crate://crates.io/remove_dir_all/0.5.3 \
> -           crate://crates.io/rusty-fork/0.3.0 \
> -           crate://crates.io/tempfile/3.2.0 \
> -           crate://crates.io/wait-timeout/0.2.0 \
> -           crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
> -           crate://crates.io/winapi/0.3.9 \
> -           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> -           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> -           crate://crates.io/alloc-no-stdlib/2.0.4 \
> -           crate://crates.io/alloc-stdlib/0.2.2 \
> -           crate://crates.io/ansi_term/0.11.0 \
> -           crate://crates.io/basic-toml/0.1.2 \
> -           crate://crates.io/ctor/0.1.26 \
> -           crate://crates.io/difference/2.0.0 \
> -           crate://crates.io/glob/0.3.1 \
> -           crate://crates.io/itoa/1.0.6 \
> -           crate://crates.io/libc/0.2.142 \
> -           crate://crates.io/once_cell/1.17.1 \
> -           crate://crates.io/output_vt100/0.1.3 \
> -           crate://crates.io/pretty_assertions/0.6.1 \
> -           crate://crates.io/proc-macro2/1.0.56 \
> -           crate://crates.io/quote/1.0.26 \
> -           crate://crates.io/rustversion/1.0.12 \
> -           crate://crates.io/ryu/1.0.13 \
> -           crate://crates.io/serde/1.0.160 \
> -           crate://crates.io/serde_derive/1.0.160 \
> -           crate://crates.io/serde_json/1.0.96 \
> -           crate://crates.io/static_assertions/1.1.0 \
> -           crate://crates.io/syn/1.0.109 \
> -           crate://crates.io/syn/2.0.15 \
> -           crate://crates.io/termcolor/1.2.0 \
> -           crate://crates.io/thiserror/1.0.40 \
> -           crate://crates.io/thiserror-impl/1.0.40 \
> -           crate://crates.io/trybuild/1.0.80 \
> -           crate://crates.io/unicode-ident/1.0.8 \
> -           crate://crates.io/winapi/0.3.9 \
> -           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> -           crate://crates.io/winapi-util/0.1.5 \
> -           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> -           crate://crates.io/asn1-rs/0.5.1 \
> -           crate://crates.io/asn1-rs-derive/0.4.0 \
> -           crate://crates.io/asn1-rs-impl/0.1.0 \
> -           crate://crates.io/atty/0.2.14 \
> -           crate://crates.io/autocfg/1.1.0 \
> -           crate://crates.io/base64/0.13.1 \
> -           crate://crates.io/basic-toml/0.1.2 \
> -           crate://crates.io/bitvec/1.0.1 \
> -           crate://crates.io/colored/2.0.0 \
> -           crate://crates.io/cookie-factory/0.3.2 \
> -           crate://crates.io/displaydoc/0.2.3 \
> -           crate://crates.io/funty/2.0.0 \
> -           crate://crates.io/glob/0.3.1 \
> -           crate://crates.io/hermit-abi/0.1.19 \
> -           crate://crates.io/hex-literal/0.3.4 \
> -           crate://crates.io/itoa/1.0.6 \
> -           crate://crates.io/lazy_static/1.4.0 \
> -           crate://crates.io/libc/0.2.139 \
> -           crate://crates.io/memchr/2.5.0 \
> -           crate://crates.io/minimal-lexical/0.2.1 \
> -           crate://crates.io/nom/7.1.3 \
> -           crate://crates.io/num-bigint/0.4.3 \
> -           crate://crates.io/num-integer/0.1.45 \
> -           crate://crates.io/num-traits/0.2.15 \
> -           crate://crates.io/oid-registry/0.6.1 \
> -           crate://crates.io/once_cell/1.17.1 \
> -           crate://crates.io/pem/1.1.1 \
> -           crate://crates.io/proc-macro2/1.0.51 \
> -           crate://crates.io/quote/1.0.23 \
> -           crate://crates.io/radium/0.7.0 \
> -           crate://crates.io/rusticata-macros/4.1.0 \
> -           crate://crates.io/ryu/1.0.13 \
> -           crate://crates.io/serde/1.0.152 \
> -           crate://crates.io/serde_derive/1.0.152 \
> -           crate://crates.io/serde_json/1.0.94 \
> -           crate://crates.io/syn/1.0.109 \
> -           crate://crates.io/synstructure/0.12.6 \
> -           crate://crates.io/tap/1.0.1 \
> -           crate://crates.io/termcolor/1.2.0 \
> -           crate://crates.io/thiserror/1.0.39 \
> -           crate://crates.io/thiserror-impl/1.0.39 \
> -           crate://crates.io/time/0.3.20 \
> -           crate://crates.io/time-core/0.1.0 \
> -           crate://crates.io/time-macros/0.2.8 \
> -           crate://crates.io/trybuild/1.0.79 \
> -           crate://crates.io/unicode-ident/1.0.8 \
> -           crate://crates.io/unicode-xid/0.2.4 \
> -           crate://crates.io/winapi/0.3.9 \
> -           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> -           crate://crates.io/winapi-util/0.1.5 \
> -           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> -           crate://crates.io/wyz/0.5.1 \
> -           crate://crates.io/alloc-no-stdlib/2.0.4 \
> -           crate://crates.io/alloc-stdlib/0.2.2 \
> -           crate://crates.io/block-buffer/0.10.4 \
> -           crate://crates.io/brotli-decompressor/5.0.0 \
> -           crate://crates.io/cfg-if/1.0.0 \
> -           crate://crates.io/cpufeatures/0.2.17 \
> -           crate://crates.io/crypto-common/0.1.6 \
> -           crate://crates.io/digest/0.10.7 \
> -           crate://crates.io/generic-array/0.14.7 \
> -           crate://crates.io/libc/0.2.172 \
> -           crate://crates.io/sha2/0.10.9 \
> -           crate://crates.io/typenum/1.18.0 \
> -           crate://crates.io/version_check/0.9.5 \
> -           crate://crates.io/atty/0.2.14 \
> -           crate://crates.io/autocfg/1.0.1 \
> -           crate://crates.io/bitflags/1.2.1 \
> -           crate://crates.io/bstr/0.2.16 \
> -           crate://crates.io/bumpalo/3.7.0 \
> -           crate://crates.io/cast/0.2.7 \
> -           crate://crates.io/cfg-if/1.0.0 \
> -           crate://crates.io/clap/2.33.3 \
> -           crate://crates.io/criterion/0.3.4 \
> -           crate://crates.io/criterion-plot/0.4.4 \
> -           crate://crates.io/crossbeam-channel/0.5.1 \
> -           crate://crates.io/crossbeam-deque/0.8.1 \
> -           crate://crates.io/crossbeam-epoch/0.9.5 \
> -           crate://crates.io/crossbeam-utils/0.8.5 \
> -           crate://crates.io/csv/1.1.6 \
> -           crate://crates.io/csv-core/0.1.10 \
> -           crate://crates.io/either/1.6.1 \
> -           crate://crates.io/getrandom/0.2.3 \
> -           crate://crates.io/half/1.7.1 \
> -           crate://crates.io/hermit-abi/0.1.19 \
> -           crate://crates.io/itertools/0.10.1 \
> -           crate://crates.io/itoa/0.4.7 \
> -           crate://crates.io/js-sys/0.3.52 \
> -           crate://crates.io/lazy_static/1.4.0 \
> -           crate://crates.io/libc/0.2.99 \
> -           crate://crates.io/log/0.4.14 \
> -           crate://crates.io/memchr/2.4.0 \
> -           crate://crates.io/memoffset/0.6.4 \
> -           crate://crates.io/num-traits/0.2.14 \
> -           crate://crates.io/num_cpus/1.13.0 \
> -           crate://crates.io/oorandom/11.1.3 \
> -           crate://crates.io/phf_shared/0.10.0 \
> -           crate://crates.io/plotters/0.3.1 \
> -           crate://crates.io/plotters-backend/0.3.2 \
> -           crate://crates.io/plotters-svg/0.3.1 \
> -           crate://crates.io/ppv-lite86/0.2.10 \
> -           crate://crates.io/proc-macro2/1.0.28 \
> -           crate://crates.io/quote/1.0.9 \
> -           crate://crates.io/rand/0.8.4 \
> -           crate://crates.io/rand_chacha/0.3.1 \
> -           crate://crates.io/rand_core/0.6.3 \
> -           crate://crates.io/rand_hc/0.3.1 \
> -           crate://crates.io/rayon/1.5.1 \
> -           crate://crates.io/rayon-core/1.9.1 \
> -           crate://crates.io/regex/1.5.4 \
> -           crate://crates.io/regex-automata/0.1.10 \
> -           crate://crates.io/regex-syntax/0.6.25 \
> -           crate://crates.io/rustc_version/0.4.0 \
> -           crate://crates.io/ryu/1.0.5 \
> -           crate://crates.io/same-file/1.0.6 \
> -           crate://crates.io/scopeguard/1.1.0 \
> -           crate://crates.io/semver/1.0.4 \
> -           crate://crates.io/serde/1.0.127 \
> -           crate://crates.io/serde_cbor/0.11.1 \
> -           crate://crates.io/serde_derive/1.0.127 \
> -           crate://crates.io/serde_json/1.0.66 \
> -           crate://crates.io/siphasher/0.3.6 \
> -           crate://crates.io/syn/1.0.74 \
> -           crate://crates.io/textwrap/0.11.0 \
> -           crate://crates.io/tinytemplate/1.2.1 \
> -           crate://crates.io/unicode-width/0.1.8 \
> -           crate://crates.io/unicode-xid/0.2.2 \
> -           crate://crates.io/walkdir/2.3.2 \
> -           crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
> -           crate://crates.io/wasm-bindgen/0.2.75 \
> -           crate://crates.io/wasm-bindgen-backend/0.2.75 \
> -           crate://crates.io/wasm-bindgen-macro/0.2.75 \
> -           crate://crates.io/wasm-bindgen-macro-support/0.2.75 \
> -           crate://crates.io/wasm-bindgen-shared/0.2.75 \
> -           crate://crates.io/web-sys/0.3.52 \
> -           crate://crates.io/winapi/0.3.9 \
> -           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> -           crate://crates.io/winapi-util/0.1.5 \
> -           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> -           crate://crates.io/alloc-no-stdlib/2.0.4 \
> -           crate://crates.io/asn1-rs/0.5.2 \
> -           crate://crates.io/asn1-rs-derive/0.4.0 \
> -           crate://crates.io/asn1-rs-impl/0.1.0 \
> -           crate://crates.io/autocfg/1.1.0 \
> -           crate://crates.io/bumpalo/3.13.0 \
> -           crate://crates.io/cc/1.0.81 \
> -           crate://crates.io/cfg-if/1.0.0 \
> -           crate://crates.io/data-encoding/2.4.0 \
> -           crate://crates.io/der-parser/8.2.0 \
> -           crate://crates.io/deranged/0.3.7 \
> -           crate://crates.io/displaydoc/0.2.4 \
> -           crate://crates.io/itoa/1.0.9 \
> -           crate://crates.io/js-sys/0.3.64 \
> -           crate://crates.io/lazy_static/1.4.0 \
> -           crate://crates.io/libc/0.2.147 \
> -           crate://crates.io/log/0.4.19 \
> -           crate://crates.io/memchr/2.5.0 \
> -           crate://crates.io/minimal-lexical/0.2.1 \
> -           crate://crates.io/nom/7.1.3 \
> -           crate://crates.io/num-bigint/0.4.3 \
> -           crate://crates.io/num-integer/0.1.45 \
> -           crate://crates.io/num-traits/0.2.16 \
> -           crate://crates.io/oid-registry/0.6.1 \
> -           crate://crates.io/once_cell/1.18.0 \
> -           crate://crates.io/proc-macro2/1.0.66 \
> -           crate://crates.io/quote/1.0.32 \
> -           crate://crates.io/ring/0.16.20 \
> -           crate://crates.io/rusticata-macros/4.1.0 \
> -           crate://crates.io/serde/1.0.180 \
> -           crate://crates.io/spin/0.5.2 \
> -           crate://crates.io/syn/1.0.109 \
> -           crate://crates.io/syn/2.0.28 \
> -           crate://crates.io/synstructure/0.12.6 \
> -           crate://crates.io/thiserror/1.0.44 \
> -           crate://crates.io/thiserror-impl/1.0.44 \
> -           crate://crates.io/time/0.3.25 \
> -           crate://crates.io/time-core/0.1.1 \
> -           crate://crates.io/time-macros/0.2.11 \
> -           crate://crates.io/unicode-ident/1.0.11 \
> -           crate://crates.io/unicode-xid/0.2.4 \
> -           crate://crates.io/untrusted/0.7.1 \
> -           crate://crates.io/wasm-bindgen/0.2.87 \
> -           crate://crates.io/wasm-bindgen-backend/0.2.87 \
> -           crate://crates.io/wasm-bindgen-macro/0.2.87 \
> -           crate://crates.io/wasm-bindgen-macro-support/0.2.87 \
> -           crate://crates.io/wasm-bindgen-shared/0.2.87 \
> -           crate://crates.io/web-sys/0.3.64 \
> -           crate://crates.io/winapi/0.3.9 \
> -           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> -           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> -           crate://crates.io/aho-corasick/0.7.18 \
> -           crate://crates.io/cfg-if/1.0.0 \
> -           crate://crates.io/getrandom/0.2.6 \
> -           crate://crates.io/lazy_static/1.4.0 \
> -           crate://crates.io/libc/0.2.125 \
> -           crate://crates.io/memchr/2.5.0 \
> -           crate://crates.io/quickcheck/1.0.3 \
> -           crate://crates.io/rand/0.8.5 \
> -           crate://crates.io/rand_core/0.6.3 \
> -           crate://crates.io/regex-syntax/0.6.26 \
> -           crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
> -           crate://crates.io/addr2line/0.14.0 \
> -           crate://crates.io/adler/0.2.3 \
> -           crate://crates.io/aho-corasick/0.7.15 \
> -           crate://crates.io/autocfg/1.0.1 \
> -           crate://crates.io/backtrace/0.3.54 \
> -           crate://crates.io/cfg-if/1.0.0 \
> -           crate://crates.io/failure/0.1.8 \
> -           crate://crates.io/failure_derive/0.1.8 \
> -           crate://crates.io/gimli/0.23.0 \
> -           crate://crates.io/lazy_static/1.4.0 \
> -           crate://crates.io/libc/0.2.80 \
> -           crate://crates.io/memchr/2.3.4 \
> -           crate://crates.io/miniz_oxide/0.4.3 \
> -           crate://crates.io/object/0.22.0 \
> -           crate://crates.io/proc-macro2/1.0.24 \
> -           crate://crates.io/quote/1.0.7 \
> -           crate://crates.io/regex/1.4.2 \
> -           crate://crates.io/regex-syntax/0.6.21 \
> -           crate://crates.io/rustc-demangle/0.1.18 \
> -           crate://crates.io/serde/1.0.117 \
> -           crate://crates.io/serde_bytes/0.11.5 \
> -           crate://crates.io/serde_derive/1.0.117 \
> -           crate://crates.io/syn/1.0.48 \
> -           crate://crates.io/synstructure/0.12.4 \
> -           crate://crates.io/thread_local/1.0.1 \
> -           crate://crates.io/unicode-xid/0.2.1 \
> -           crate://crates.io/adler/1.0.2 \
> -           crate://crates.io/cc/1.0.79 \
> -           crate://crates.io/cfg-if/1.0.0 \
> -           crate://crates.io/cloudflare-zlib-sys/0.3.0 \
> -           crate://crates.io/cmake/0.1.50 \
> -           crate://crates.io/crc32fast/1.3.2 \
> -           crate://crates.io/getrandom/0.2.9 \
> -           crate://crates.io/libc/0.2.144 \
> -           crate://crates.io/libz-ng-sys/1.1.10 \
> -           crate://crates.io/libz-sys/1.1.10 \
> -           crate://crates.io/miniz_oxide/0.7.1 \
> -           crate://crates.io/pkg-config/0.3.27 \
> -           crate://crates.io/ppv-lite86/0.2.17 \
> -           crate://crates.io/quickcheck/1.0.3 \
> -           crate://crates.io/rand/0.8.5 \
> -           crate://crates.io/rand_chacha/0.3.1 \
> -           crate://crates.io/rand_core/0.6.4 \
> -           crate://crates.io/vcpkg/0.2.15 \
> -           crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
> -           "
> +SRC_URI += " \
> +    crate://crates.io/adler/1.0.2 \
> +    crate://crates.io/aead/0.4.3 \
> +    crate://crates.io/aes/0.7.5 \
> +    crate://crates.io/aes-gcm/0.9.4 \
> +    crate://crates.io/aho-corasick/0.7.20 \
> +    crate://crates.io/alloc-no-stdlib/2.0.4 \
> +    crate://crates.io/alloc-stdlib/0.2.2 \
> +    crate://crates.io/asn1-rs/0.5.2 \
> +    crate://crates.io/asn1-rs-derive/0.4.0 \
> +    crate://crates.io/asn1-rs-impl/0.1.0 \
> +    crate://crates.io/autocfg/1.1.0 \
> +    crate://crates.io/base64/0.13.1 \
> +    crate://crates.io/bendy/0.3.3 \
> +    crate://crates.io/bitflags/1.2.1 \
> +    crate://crates.io/block-buffer/0.10.4 \
> +    crate://crates.io/brotli/8.0.1 \
> +    crate://crates.io/brotli-decompressor/5.0.0 \
> +    crate://crates.io/build_const/0.2.2 \
> +    crate://crates.io/byteorder/1.4.3 \
> +    crate://crates.io/cfg-if/1.0.0 \
> +    crate://crates.io/cipher/0.3.0 \
> +    crate://crates.io/cpufeatures/0.2.11 \
> +    crate://crates.io/crc/1.8.1 \
> +    crate://crates.io/crc32fast/1.3.2 \
> +    crate://crates.io/crypto-common/0.1.6 \
> +    crate://crates.io/ctr/0.8.0 \
> +    crate://crates.io/data-encoding/2.4.0 \
> +    crate://crates.io/der-oid-macro/0.5.0 \
> +    crate://crates.io/der-parser/6.0.1 \
> +    crate://crates.io/der-parser/8.2.0 \
> +    crate://crates.io/digest/0.10.7 \
> +    crate://crates.io/displaydoc/0.2.4 \
> +    crate://crates.io/enum_primitive/0.1.1 \
> +    crate://crates.io/failure/0.1.8 \
> +    crate://crates.io/failure_derive/0.1.8 \
> +    crate://crates.io/flate2/1.0.28 \
> +    crate://crates.io/generic-array/0.14.7 \
> +    crate://crates.io/getrandom/0.2.11 \
> +    crate://crates.io/ghash/0.4.4 \
> +    crate://crates.io/hex/0.4.3 \
> +    crate://crates.io/hkdf/0.12.3 \
> +    crate://crates.io/hmac/0.12.1 \
> +    crate://crates.io/ipsec-parser/0.7.0 \
> +    crate://crates.io/itoa/1.0.9 \
> +    crate://crates.io/kerberos-parser/0.7.1 \
> +    crate://crates.io/lazy_static/1.4.0 \
> +    crate://crates.io/libc/0.2.150 \
> +    crate://crates.io/lzma-rs/0.2.0 \
> +    crate://crates.io/md-5/0.10.6 \
> +    crate://crates.io/memchr/2.4.1 \
> +    crate://crates.io/minimal-lexical/0.2.1 \
> +    crate://crates.io/miniz_oxide/0.7.1 \
> +    crate://crates.io/nom/7.1.3 \
> +    crate://crates.io/nom-derive/0.10.1 \
> +    crate://crates.io/nom-derive-impl/0.10.1 \
> +    crate://crates.io/ntp-parser/0.6.0 \
> +    crate://crates.io/num/0.2.1 \
> +    crate://crates.io/num-bigint/0.2.6 \
> +    crate://crates.io/num-bigint/0.4.4 \
> +    crate://crates.io/num-complex/0.2.4 \
> +    crate://crates.io/num-derive/0.4.2 \
> +    crate://crates.io/num-integer/0.1.45 \
> +    crate://crates.io/num-iter/0.1.43 \
> +    crate://crates.io/num-rational/0.2.4 \
> +    crate://crates.io/num-traits/0.1.43 \
> +    crate://crates.io/num-traits/0.2.17 \
> +    crate://crates.io/num_enum/0.5.11 \
> +    crate://crates.io/num_enum_derive/0.5.11 \
> +    crate://crates.io/num_threads/0.1.6 \
> +    crate://crates.io/oid-registry/0.6.1 \
> +    crate://crates.io/opaque-debug/0.3.0 \
> +    crate://crates.io/phf/0.10.1 \
> +    crate://crates.io/phf_codegen/0.10.0 \
> +    crate://crates.io/phf_generator/0.10.0 \
> +    crate://crates.io/phf_shared/0.10.0 \
> +    crate://crates.io/polyval/0.5.3 \
> +    crate://crates.io/ppv-lite86/0.2.17 \
> +    crate://crates.io/proc-macro-crate/1.1.0 \
> +    crate://crates.io/proc-macro2/1.0.69 \
> +    crate://crates.io/quote/1.0.33 \
> +    crate://crates.io/rand/0.8.5 \
> +    crate://crates.io/rand_chacha/0.3.1 \
> +    crate://crates.io/rand_core/0.6.4 \
> +    crate://crates.io/regex/1.5.6 \
> +    crate://crates.io/regex-syntax/0.6.29 \
> +    crate://crates.io/rusticata-macros/4.1.0 \
> +    crate://crates.io/rustversion/1.0.14 \
> +    crate://crates.io/sawp/0.12.1 \
> +    crate://crates.io/sawp-flags/0.12.1 \
> +    crate://crates.io/sawp-flags-derive/0.12.1 \
> +    crate://crates.io/sawp-modbus/0.12.1 \
> +    crate://crates.io/serde/1.0.192 \
> +    crate://crates.io/serde_derive/1.0.192 \
> +    crate://crates.io/sha1/0.10.6 \
> +    crate://crates.io/sha2/0.10.8 \
> +    crate://crates.io/siphasher/0.3.11 \
> +    crate://crates.io/snmp-parser/0.9.0 \
> +    crate://crates.io/subtle/2.4.1 \
> +    crate://crates.io/syn/1.0.109 \
> +    crate://crates.io/syn/2.0.39 \
> +    crate://crates.io/synstructure/0.12.6 \
> +    crate://crates.io/test-case/1.1.0 \
> +    crate://crates.io/thiserror/1.0.50 \
> +    crate://crates.io/thiserror-impl/1.0.50 \
> +    crate://crates.io/time/0.3.13 \
> +    crate://crates.io/time-macros/0.2.4 \
> +    crate://crates.io/tls-parser/0.11.0 \
> +    crate://crates.io/toml/0.5.11 \
> +    crate://crates.io/typenum/1.17.0 \
> +    crate://crates.io/unicode-ident/1.0.12 \
> +    crate://crates.io/unicode-xid/0.2.4 \
> +    crate://crates.io/universal-hash/0.4.1 \
> +    crate://crates.io/uuid/0.8.2 \
> +    crate://crates.io/version_check/0.9.4 \
> +    crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
> +    crate://crates.io/widestring/0.4.3 \
> +    crate://crates.io/x509-parser/0.15.1 \
> +"
>   
>   SRC_URI[adler-1.0.2.sha256sum] = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
>   SRC_URI[aead-0.4.3.sha256sum] = "0b613b8e1e3cf911a086f53f03bf286f52fd7a7258e4fa606f0ef220d39d8877" @@ -661,6 +239,97 @@ 
> SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11
>   SRC_URI[widestring-0.4.3.sha256sum] = "c168940144dd21fd8046987c16a46a33d5fc84eec29ef9dcddc2ac9e31526b7c"
>   SRC_URI[x509-parser-0.15.1.sha256sum] = "7069fba5b66b9193bd2c5d3d4ff12b839118f6bcbef5328efafafb5395cf63da"
>   # from rust/vendor/base64/Cargo.lock
> +SRC_URI += " \
> +    crate://crates.io/ansi_term/0.12.1 \
> +    crate://crates.io/atty/0.2.14 \
> +    crate://crates.io/autocfg/0.1.8 \
> +    crate://crates.io/autocfg/1.1.0 \
> +    crate://crates.io/bitflags/1.3.2 \
> +    crate://crates.io/bstr/0.2.17 \
> +    crate://crates.io/bumpalo/3.11.1 \
> +    crate://crates.io/cast/0.2.7 \
> +    crate://crates.io/cast/0.3.0 \
> +    crate://crates.io/cfg-if/1.0.0 \
> +    crate://crates.io/clap/2.34.0 \
> +    crate://crates.io/cloudabi/0.0.3 \
> +    crate://crates.io/criterion/0.3.2 \
> +    crate://crates.io/criterion-plot/0.4.5 \
> +    crate://crates.io/crossbeam-channel/0.5.6 \
> +    crate://crates.io/crossbeam-deque/0.8.2 \
> +    crate://crates.io/crossbeam-epoch/0.9.11 \
> +    crate://crates.io/crossbeam-utils/0.8.12 \
> +    crate://crates.io/csv/1.1.6 \
> +    crate://crates.io/csv-core/0.1.10 \
> +    crate://crates.io/either/1.8.0 \
> +    crate://crates.io/fuchsia-cprng/0.1.1 \
> +    crate://crates.io/heck/0.3.3 \
> +    crate://crates.io/hermit-abi/0.1.19 \
> +    crate://crates.io/itertools/0.9.0 \
> +    crate://crates.io/itertools/0.10.5 \
> +    crate://crates.io/itoa/0.4.8 \
> +    crate://crates.io/itoa/1.0.4 \
> +    crate://crates.io/js-sys/0.3.60 \
> +    crate://crates.io/lazy_static/1.4.0 \
> +    crate://crates.io/libc/0.2.135 \
> +    crate://crates.io/log/0.4.17 \
> +    crate://crates.io/memchr/2.5.0 \
> +    crate://crates.io/memoffset/0.6.5 \
> +    crate://crates.io/num-traits/0.2.15 \
> +    crate://crates.io/num_cpus/1.13.1 \
> +    crate://crates.io/once_cell/1.15.0 \
> +    crate://crates.io/oorandom/11.1.3 \
> +    crate://crates.io/plotters/0.2.15 \
> +    crate://crates.io/proc-macro-error/1.0.4 \
> +    crate://crates.io/proc-macro-error-attr/1.0.4 \
> +    crate://crates.io/proc-macro2/1.0.47 \
> +    crate://crates.io/quote/1.0.21 \
> +    crate://crates.io/rand/0.6.5 \
> +    crate://crates.io/rand_chacha/0.1.1 \
> +    crate://crates.io/rand_core/0.3.1 \
> +    crate://crates.io/rand_core/0.4.2 \
> +    crate://crates.io/rand_hc/0.1.0 \
> +    crate://crates.io/rand_isaac/0.1.1 \
> +    crate://crates.io/rand_jitter/0.1.4 \
> +    crate://crates.io/rand_os/0.1.3 \
> +    crate://crates.io/rand_pcg/0.1.2 \
> +    crate://crates.io/rand_xorshift/0.1.1 \
> +    crate://crates.io/rayon/1.5.3 \
> +    crate://crates.io/rayon-core/1.9.3 \
> +    crate://crates.io/rdrand/0.4.0 \
> +    crate://crates.io/regex/1.6.0 \
> +    crate://crates.io/regex-automata/0.1.10 \
> +    crate://crates.io/regex-syntax/0.6.27 \
> +    crate://crates.io/rustc_version/0.4.0 \
> +    crate://crates.io/ryu/1.0.11 \
> +    crate://crates.io/same-file/1.0.6 \
> +    crate://crates.io/scopeguard/1.1.0 \
> +    crate://crates.io/semver/1.0.14 \
> +    crate://crates.io/serde/1.0.146 \
> +    crate://crates.io/serde_derive/1.0.146 \
> +    crate://crates.io/serde_json/1.0.87 \
> +    crate://crates.io/strsim/0.8.0 \
> +    crate://crates.io/structopt/0.3.26 \
> +    crate://crates.io/structopt-derive/0.4.18 \
> +    crate://crates.io/syn/1.0.103 \
> +    crate://crates.io/textwrap/0.11.0 \
> +    crate://crates.io/tinytemplate/1.2.1 \
> +    crate://crates.io/unicode-ident/1.0.5 \
> +    crate://crates.io/unicode-segmentation/1.10.0 \
> +    crate://crates.io/unicode-width/0.1.10 \
> +    crate://crates.io/vec_map/0.8.2 \
> +    crate://crates.io/version_check/0.9.4 \
> +    crate://crates.io/walkdir/2.3.2 \
> +    crate://crates.io/wasm-bindgen/0.2.83 \
> +    crate://crates.io/wasm-bindgen-backend/0.2.83 \
> +    crate://crates.io/wasm-bindgen-macro/0.2.83 \
> +    crate://crates.io/wasm-bindgen-macro-support/0.2.83 \
> +    crate://crates.io/wasm-bindgen-shared/0.2.83 \
> +    crate://crates.io/web-sys/0.3.60 \
> +    crate://crates.io/winapi/0.3.9 \
> +    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> +    crate://crates.io/winapi-util/0.1.5 \
> +    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> +"
>   
>   SRC_URI[ansi_term-0.12.1.sha256sum] = "d52a9bb7ec0cf484c551830a7ce27bd20d67eac647e1befb56b0be4ee39a55d2"
>   SRC_URI[atty-0.2.14.sha256sum] = "d9b39be18770d11421cdb1b9947a45dd3f37e93092cbf377614828a319d5fee8" @@ -751,7 +420,29 @@ SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761
>   SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
>   SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
>   SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
> +# from rust/vendor/brotli-decompressor/Cargo.lock
> +SRC_URI += " \
> +    crate://crates.io/alloc-no-stdlib/2.0.4 \
> +    crate://crates.io/alloc-stdlib/0.2.2 \
> +"
> +
> +SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
> +SRC_URI[alloc-stdlib-0.2.2.sha256sum] = "94fb8275041c72129eb51b7d0322c29b8387a0386127718b096429201a5d6ece"
>   # from rust/vendor/failure/Cargo.lock
> +SRC_URI += " \
> +    crate://crates.io/backtrace/0.3.46 \
> +    crate://crates.io/backtrace-sys/0.1.37 \
> +    crate://crates.io/cc/1.0.52 \
> +    crate://crates.io/cfg-if/0.1.10 \
> +    crate://crates.io/failure_derive/0.1.7 \
> +    crate://crates.io/libc/0.2.69 \
> +    crate://crates.io/proc-macro2/1.0.12 \
> +    crate://crates.io/quote/1.0.4 \
> +    crate://crates.io/rustc-demangle/0.1.16 \
> +    crate://crates.io/syn/1.0.18 \
> +    crate://crates.io/synstructure/0.12.3 \
> +    crate://crates.io/unicode-xid/0.2.0 \
> +"
>   
>   SRC_URI[backtrace-0.3.46.sha256sum] = "b1e692897359247cc6bb902933361652380af0f1b7651ae5c5013407f30e109e"
>   SRC_URI[backtrace-sys-0.1.37.sha256sum] = "18fbebbe1c9d1f383a9cc7e8ccdb471b91c8d024ee9c2ca5b5346121fe8b4399" @@ -765,21 +456,104 @@ SRC_URI[rustc-demangle-0.1.16.sha256sum] = "4c691c0e608126e00913e33f0ccf3727d5fc
>   SRC_URI[syn-1.0.18.sha256sum] = "410a7488c0a728c7ceb4ad59b9567eb4053d02e8cc7f5c0e0eeeb39518369213"
>   SRC_URI[synstructure-0.12.3.sha256sum] = "67656ea1dc1b41b1451851562ea232ec2e5a80242139f7e679ceccfb5d61f545"
>   SRC_URI[unicode-xid-0.2.0.sha256sum] = "826e7639553986605ec5979c7dd957c7895e93eabed50ab2ffa7f6128a75097c"
> -# from rust/vendor/toml/Cargo.lock
> +# from rust/vendor/bendy/Cargo.lock
> +SRC_URI += " \
> +    crate://crates.io/addr2line/0.14.0 \
> +    crate://crates.io/adler/0.2.3 \
> +    crate://crates.io/aho-corasick/0.7.15 \
> +    crate://crates.io/autocfg/1.0.1 \
> +    crate://crates.io/backtrace/0.3.54 \
> +    crate://crates.io/cfg-if/1.0.0 \
> +    crate://crates.io/failure/0.1.8 \
> +    crate://crates.io/failure_derive/0.1.8 \
> +    crate://crates.io/gimli/0.23.0 \
> +    crate://crates.io/lazy_static/1.4.0 \
> +    crate://crates.io/libc/0.2.80 \
> +    crate://crates.io/memchr/2.3.4 \
> +    crate://crates.io/miniz_oxide/0.4.3 \
> +    crate://crates.io/object/0.22.0 \
> +    crate://crates.io/proc-macro2/1.0.24 \
> +    crate://crates.io/quote/1.0.7 \
> +    crate://crates.io/regex/1.4.2 \
> +    crate://crates.io/regex-syntax/0.6.21 \
> +    crate://crates.io/rustc-demangle/0.1.18 \
> +    crate://crates.io/serde/1.0.117 \
> +    crate://crates.io/serde_bytes/0.11.5 \
> +    crate://crates.io/serde_derive/1.0.117 \
> +    crate://crates.io/syn/1.0.48 \
> +    crate://crates.io/synstructure/0.12.4 \
> +    crate://crates.io/thread_local/1.0.1 \
> +    crate://crates.io/unicode-xid/0.2.1 \
> +"
>   
> -SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
> -SRC_URI[hashbrown-0.12.3.sha256sum] = "8a9ee70c43aaf417c914396645a0fa852624801b24ebb7ae78fe8272889ac888"
> -SRC_URI[indexmap-1.9.2.sha256sum] = "1885e79c1fc4b10f0e172c475f458b7f7b93061064d98c3293e98c5ba0c8b399"
> -SRC_URI[itoa-1.0.5.sha256sum] = "fad582f4b9e86b6caa621cabeb0963332d92eea04729ab12892c2533951e6440"
> -SRC_URI[proc-macro2-1.0.50.sha256sum] = "6ef7d57beacfaf2d8aee5937dab7b7f28de3cb8b1828479bb5de2a7106f2bae2"
> -SRC_URI[quote-1.0.23.sha256sum] = "8856d8364d252a14d474036ea1358d63c9e6965c8e5c1885c18f73d70bff9c7b"
> -SRC_URI[ryu-1.0.12.sha256sum] = "7b4b9743ed687d4b4bcedf9ff5eaa7398495ae14e61cba0a295704edbc7decde"
> -SRC_URI[serde-1.0.152.sha256sum] = "bb7d1f0d3021d347a83e556fc4683dea2ea09d87bccdf88ff5c12545d89d5efb"
> -SRC_URI[serde_derive-1.0.152.sha256sum] = "af487d118eecd09402d70a5d72551860e788df87b464af30e5ea6a38c75c541e"
> -SRC_URI[serde_json-1.0.91.sha256sum] = "877c235533714907a8c2464236f5c4b2a17262ef1bd71f38f35ea592c8da6883"
> -SRC_URI[syn-1.0.107.sha256sum] = "1f4064b5b16e03ae50984a5a8ed5d4f8803e6bc1fd170a3cda91a1be4b18e3f5"
> -SRC_URI[unicode-ident-1.0.6.sha256sum] = "84a22b9f218b40614adcb3f4ff08b703773ad44fa9423e4e0d346d5db86e4ebc"
> +SRC_URI[addr2line-0.14.0.sha256sum] = "7c0929d69e78dd9bf5408269919fcbcaeb2e35e5d43e5815517cdc6a8e11a423"
> +SRC_URI[adler-0.2.3.sha256sum] = "ee2a4ec343196209d6594e19543ae87a39f96d5534d7174822a3ad825dd6ed7e"
> +SRC_URI[aho-corasick-0.7.15.sha256sum] = "7404febffaa47dac81aa44dba71523c9d069b1bdc50a77db41195149e17f68e5"
> +SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a"
> +SRC_URI[backtrace-0.3.54.sha256sum] = "2baad346b2d4e94a24347adeee9c7a93f412ee94b9cc26e5b59dea23848e9f28"
> +SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> +SRC_URI[failure-0.1.8.sha256sum] = "d32e9bd16cc02eae7db7ef620b392808b89f6a5e16bb3497d159c6b92a0f4f86"
> +SRC_URI[failure_derive-0.1.8.sha256sum] = "aa4da3c766cd7a0db8242e326e9e4e081edd567072893ed320008189715366a4"
> +SRC_URI[gimli-0.23.0.sha256sum] = "f6503fe142514ca4799d4c26297c4248239fe8838d827db6bd6065c6ed29a6ce"
> +SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
> +SRC_URI[libc-0.2.80.sha256sum] = "4d58d1b70b004888f764dfbf6a26a3b0342a1632d33968e4a179d8011c760614"
> +SRC_URI[memchr-2.3.4.sha256sum] = "0ee1c47aaa256ecabcaea351eae4a9b01ef39ed810004e298d2511ed284b1525"
> +SRC_URI[miniz_oxide-0.4.3.sha256sum] = "0f2d26ec3309788e423cfbf68ad1800f061638098d76a83681af979dc4eda19d"
> +SRC_URI[object-0.22.0.sha256sum] = "8d3b63360ec3cb337817c2dbd47ab4a0f170d285d8e5a2064600f3def1402397"
> +SRC_URI[proc-macro2-1.0.24.sha256sum] = "1e0704ee1a7e00d7bb417d0770ea303c1bccbabf0ef1667dae92b5967f5f8a71"
> +SRC_URI[quote-1.0.7.sha256sum] = "aa563d17ecb180e500da1cfd2b028310ac758de548efdd203e18f283af693f37"
> +SRC_URI[regex-1.4.2.sha256sum] = "38cf2c13ed4745de91a5eb834e11c00bcc3709e773173b2ce4c56c9fbde04b9c"
> +SRC_URI[regex-syntax-0.6.21.sha256sum] = "3b181ba2dcf07aaccad5448e8ead58db5b742cf85dfe035e2227f137a539a189"
> +SRC_URI[rustc-demangle-0.1.18.sha256sum] = "6e3bad0ee36814ca07d7968269dd4b7ec89ec2da10c4bb613928d3077083c232"
> +SRC_URI[serde-1.0.117.sha256sum] = "b88fa983de7720629c9387e9f517353ed404164b1e482c970a90c1a4aaf7dc1a"
> +SRC_URI[serde_bytes-0.11.5.sha256sum] = "16ae07dd2f88a366f15bd0632ba725227018c69a1c8550a927324f8eb8368bb9"
> +SRC_URI[serde_derive-1.0.117.sha256sum] = "cbd1ae72adb44aab48f325a02444a5fc079349a8d804c1fc922aed3f7454c74e"
> +SRC_URI[syn-1.0.48.sha256sum] = "cc371affeffc477f42a221a1e4297aedcea33d47d19b61455588bd9d8f6b19ac"
> +SRC_URI[synstructure-0.12.4.sha256sum] = "b834f2d66f734cb897113e34aaff2f1ab4719ca946f9a7358dba8f8064148701"
> +SRC_URI[thread_local-1.0.1.sha256sum] = "d40c6d1b69745a6ec6fb1ca717914848da4b44ae29d9b3080cbee91d72a69b14"
> +SRC_URI[unicode-xid-0.2.1.sha256sum] = "f7fe0bb3479651439c9112f72b6c505038574c9fbb575ed1bf3b797fa39dd564"
> +# from rust/vendor/alloc-stdlib/Cargo.lock
> +SRC_URI += " \
> +    crate://crates.io/alloc-no-stdlib/2.0.4 \
> +"
> +
> +SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
>   # from rust/vendor/nom/Cargo.lock
> +SRC_URI += " \
> +    crate://crates.io/autocfg/1.0.1 \
> +    crate://crates.io/bit-set/0.5.2 \
> +    crate://crates.io/bit-vec/0.6.3 \
> +    crate://crates.io/bitflags/1.3.2 \
> +    crate://crates.io/byteorder/1.4.3 \
> +    crate://crates.io/cfg-if/1.0.0 \
> +    crate://crates.io/doc-comment/0.3.3 \
> +    crate://crates.io/fnv/1.0.7 \
> +    crate://crates.io/getrandom/0.2.3 \
> +    crate://crates.io/lazy_static/1.4.0 \
> +    crate://crates.io/libc/0.2.106 \
> +    crate://crates.io/memchr/2.4.1 \
> +    crate://crates.io/minimal-lexical/0.2.1 \
> +    crate://crates.io/num-traits/0.2.14 \
> +    crate://crates.io/ppv-lite86/0.2.15 \
> +    crate://crates.io/proptest/1.0.0 \
> +    crate://crates.io/quick-error/1.2.3 \
> +    crate://crates.io/quick-error/2.0.1 \
> +    crate://crates.io/rand/0.8.4 \
> +    crate://crates.io/rand_chacha/0.3.1 \
> +    crate://crates.io/rand_core/0.6.3 \
> +    crate://crates.io/rand_hc/0.3.1 \
> +    crate://crates.io/rand_xorshift/0.3.0 \
> +    crate://crates.io/redox_syscall/0.2.10 \
> +    crate://crates.io/regex-syntax/0.6.25 \
> +    crate://crates.io/remove_dir_all/0.5.3 \
> +    crate://crates.io/rusty-fork/0.3.0 \
> +    crate://crates.io/tempfile/3.2.0 \
> +    crate://crates.io/wait-timeout/0.2.0 \
> +    crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
> +    crate://crates.io/winapi/0.3.9 \
> +    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> +    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> +"
>   
>   SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a"
>   SRC_URI[bit-set-0.5.2.sha256sum] = "6e11e16035ea35e4e5997b393eacbf6f63983188f7a2ad25bfb13465f5ad59de" @@ -814,42 +588,129 @@ 
> SRC_URI[wasi-0.10.2+wasi-snapshot-preview1.sha256sum] = "fd6fbd9a79829dd1ad0cc20
>   SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
>   SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
>   SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
> -# from rust/vendor/brotli-decompressor/Cargo.lock
> +# from rust/vendor/flate2/Cargo.lock
> +SRC_URI += " \
> +    crate://crates.io/adler/1.0.2 \
> +    crate://crates.io/cc/1.0.79 \
> +    crate://crates.io/cfg-if/1.0.0 \
> +    crate://crates.io/cloudflare-zlib-sys/0.3.0 \
> +    crate://crates.io/cmake/0.1.50 \
> +    crate://crates.io/crc32fast/1.3.2 \
> +    crate://crates.io/getrandom/0.2.9 \
> +    crate://crates.io/libc/0.2.144 \
> +    crate://crates.io/libz-ng-sys/1.1.10 \
> +    crate://crates.io/libz-sys/1.1.10 \
> +    crate://crates.io/miniz_oxide/0.7.1 \
> +    crate://crates.io/pkg-config/0.3.27 \
> +    crate://crates.io/ppv-lite86/0.2.17 \
> +    crate://crates.io/quickcheck/1.0.3 \
> +    crate://crates.io/rand/0.8.5 \
> +    crate://crates.io/rand_chacha/0.3.1 \
> +    crate://crates.io/rand_core/0.6.4 \
> +    crate://crates.io/vcpkg/0.2.15 \
> +    crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
> +"
>   
> -SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
> -SRC_URI[alloc-stdlib-0.2.2.sha256sum] = "94fb8275041c72129eb51b7d0322c29b8387a0386127718b096429201a5d6ece"
> -# from rust/vendor/displaydoc/Cargo.lock
> +SRC_URI[adler-1.0.2.sha256sum] = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
> +SRC_URI[cc-1.0.79.sha256sum] = "50d30906286121d95be3d479533b458f87493b30a4b5f79a607db8f5d11aa91f"
> +SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> +SRC_URI[cloudflare-zlib-sys-0.3.0.sha256sum] = "2040b6d1edfee6d75f172d81e2d2a7807534f3f294ce18184c70e7bb0105cd6f"
> +SRC_URI[cmake-0.1.50.sha256sum] = "a31c789563b815f77f4250caee12365734369f942439b7defd71e18a48197130"
> +SRC_URI[crc32fast-1.3.2.sha256sum] = "b540bd8bc810d3885c6ea91e2018302f68baba2129ab3e88f32389ee9370880d"
> +SRC_URI[getrandom-0.2.9.sha256sum] = "c85e1d9ab2eadba7e5040d4e09cbd6d072b76a557ad64e797c2cb9d4da21d7e4"
> +SRC_URI[libc-0.2.144.sha256sum] = "2b00cc1c228a6782d0f076e7b232802e0c5689d41bb5df366f2a6b6621cfdfe1"
> +SRC_URI[libz-ng-sys-1.1.10.sha256sum] = "425fb6808068335c8c7c69d1cff0a7d1ed8f681e9ac040272f160a89e6f43b8b"
> +SRC_URI[libz-sys-1.1.10.sha256sum] = "24e6ab01971eb092ffe6a7d42f49f9ff42662f17604681e2843ad65077ba47dc"
> +SRC_URI[miniz_oxide-0.7.1.sha256sum] = "e7810e0be55b428ada41041c41f32c9f1a42817901b4ccf45fa3d4b6561e74c7"
> +SRC_URI[pkg-config-0.3.27.sha256sum] = "26072860ba924cbfa98ea39c8c19b4dd6a4a25423dbdf219c1eca91aa0cf6964"
> +SRC_URI[ppv-lite86-0.2.17.sha256sum] = "5b40af805b3121feab8a3c29f04d8ad262fa8e0561883e7653e024ae4479e6de"
> +SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
> +SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
> +SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
> +SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
> +SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
> +SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
> +# from rust/vendor/regex/Cargo.lock
> +SRC_URI += " \
> +    crate://crates.io/aho-corasick/0.7.18 \
> +    crate://crates.io/cfg-if/1.0.0 \
> +    crate://crates.io/getrandom/0.2.6 \
> +    crate://crates.io/lazy_static/1.4.0 \
> +    crate://crates.io/libc/0.2.125 \
> +    crate://crates.io/memchr/2.5.0 \
> +    crate://crates.io/quickcheck/1.0.3 \
> +    crate://crates.io/rand/0.8.5 \
> +    crate://crates.io/rand_core/0.6.3 \
> +    crate://crates.io/regex-syntax/0.6.26 \
> +    crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
> +"
>   
> -SRC_URI[ansi_term-0.11.0.sha256sum] = "ee49baf6cb617b853aa8d93bf420db2383fab46d314482ca2803b40d5fde979b"
> -SRC_URI[basic-toml-0.1.2.sha256sum] = "5c0de75129aa8d0cceaf750b89013f0e08804d6ec61416da787b35ad0d7cddf1"
> -SRC_URI[ctor-0.1.26.sha256sum] = "6d2301688392eb071b0bf1a37be05c469d3cc4dbbd95df672fe28ab021e6a096"
> -SRC_URI[difference-2.0.0.sha256sum] = "524cbf6897b527295dff137cec09ecf3a05f4fddffd7dfcd1585403449e74198"
> -SRC_URI[glob-0.3.1.sha256sum] = "d2fabcfbdc87f4758337ca535fb41a6d701b65693ce38287d856d1674551ec9b"
> -SRC_URI[itoa-1.0.6.sha256sum] = "453ad9f582a441959e5f0d088b02ce04cfe8d51a8eaf077f12ac6d3e94164ca6"
> -SRC_URI[libc-0.2.142.sha256sum] = "6a987beff54b60ffa6d51982e1aa1146bc42f19bd26be28b0586f252fccf5317"
> -SRC_URI[once_cell-1.17.1.sha256sum] = "b7e5500299e16ebb147ae15a00a942af264cf3688f47923b8fc2cd5858f23ad3"
> -SRC_URI[output_vt100-0.1.3.sha256sum] = "628223faebab4e3e40667ee0b2336d34a5b960ff60ea743ddfdbcf7770bcfb66"
> -SRC_URI[pretty_assertions-0.6.1.sha256sum] = "3f81e1644e1b54f5a68959a29aa86cde704219254669da328ecfdf6a1f09d427"
> -SRC_URI[proc-macro2-1.0.56.sha256sum] = "2b63bdb0cd06f1f4dedf69b254734f9b45af66e4a031e42a7480257d9898b435"
> -SRC_URI[quote-1.0.26.sha256sum] = "4424af4bf778aae2051a77b60283332f386554255d722233d09fbfc7e30da2fc"
> -SRC_URI[rustversion-1.0.12.sha256sum] = "4f3208ce4d8448b3f3e7d168a73f5e0c43a61e32930de3bceeccedb388b6bf06"
> -SRC_URI[ryu-1.0.13.sha256sum] = "f91339c0467de62360649f8d3e185ca8de4224ff281f66000de5eb2a77a79041"
> -SRC_URI[serde-1.0.160.sha256sum] = "bb2f3770c8bce3bcda7e149193a069a0f4365bda1fa5cd88e03bca26afc1216c"
> -SRC_URI[serde_derive-1.0.160.sha256sum] = "291a097c63d8497e00160b166a967a4a79c64f3facdd01cbd7502231688d77df"
> -SRC_URI[serde_json-1.0.96.sha256sum] = "057d394a50403bcac12672b2b18fb387ab6d289d957dab67dd201875391e52f1"
> -SRC_URI[static_assertions-1.1.0.sha256sum] = "a2eb9349b6444b326872e140eb1cf5e7c522154d69e7a0ffb0fb81c06b37543f"
> -SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
> -SRC_URI[syn-2.0.15.sha256sum] = "a34fcf3e8b60f57e6a14301a2e916d323af98b0ea63c599441eec8558660c822"
> -SRC_URI[termcolor-1.2.0.sha256sum] = "be55cf8942feac5c765c2c993422806843c9a9a45d4d5c407ad6dd2ea95eb9b6"
> -SRC_URI[thiserror-1.0.40.sha256sum] = "978c9a314bd8dc99be594bc3c175faaa9794be04a5a5e153caba6915336cebac"
> -SRC_URI[thiserror-impl-1.0.40.sha256sum] = "f9456a42c5b0d803c8cd86e73dd7cc9edd429499f37a3550d286d5e86720569f"
> -SRC_URI[trybuild-1.0.80.sha256sum] = "501dbdbb99861e4ab6b60eb6a7493956a9defb644fd034bc4a5ef27c693c8a3a"
> -SRC_URI[unicode-ident-1.0.8.sha256sum] = "e5464a87b239f13a63a501f2701565754bae92d243d4bb7eb12f6d57d2269bf4"
> -SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
> -SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
> -SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
> -SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
> +SRC_URI[aho-corasick-0.7.18.sha256sum] = "1e37cfd5e7657ada45f742d6e99ca5788580b5c529dc78faf11ece6dc702656f"
> +SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> +SRC_URI[getrandom-0.2.6.sha256sum] = "9be70c98951c83b8d2f8f60d7065fa6d5146873094452a1008da8c2f1e4205ad"
> +SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
> +SRC_URI[libc-0.2.125.sha256sum] = "5916d2ae698f6de9bfb891ad7a8d65c09d232dc58cc4ac433c7da3b2fd84bc2b"
> +SRC_URI[memchr-2.5.0.sha256sum] = "2dffe52ecf27772e601905b7522cb4ef790d2cc203488bbd0e2fe85fcb74566d"
> +SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
> +SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
> +SRC_URI[rand_core-0.6.3.sha256sum] = "d34f1408f55294453790c48b2f1ebbb1c5b4b7563eb1f418bcfcfdbb06ebb4e7"
> +SRC_URI[regex-syntax-0.6.26.sha256sum] = "49b3de9ec5dc0a3417da371aab17d729997c15010e7fd24ff707773a33bddb64"
> +SRC_URI[wasi-0.10.2+wasi-snapshot-preview1.sha256sum] = "fd6fbd9a79829dd1ad0cc20627bf1ed606756a7f77edff7b66b7064f9cb327c6"
>   # from rust/vendor/asn1-rs/Cargo.lock
> +SRC_URI += " \
> +    crate://crates.io/asn1-rs/0.5.1 \
> +    crate://crates.io/asn1-rs-derive/0.4.0 \
> +    crate://crates.io/asn1-rs-impl/0.1.0 \
> +    crate://crates.io/atty/0.2.14 \
> +    crate://crates.io/autocfg/1.1.0 \
> +    crate://crates.io/base64/0.13.1 \
> +    crate://crates.io/basic-toml/0.1.2 \
> +    crate://crates.io/bitvec/1.0.1 \
> +    crate://crates.io/colored/2.0.0 \
> +    crate://crates.io/cookie-factory/0.3.2 \
> +    crate://crates.io/displaydoc/0.2.3 \
> +    crate://crates.io/funty/2.0.0 \
> +    crate://crates.io/glob/0.3.1 \
> +    crate://crates.io/hermit-abi/0.1.19 \
> +    crate://crates.io/hex-literal/0.3.4 \
> +    crate://crates.io/itoa/1.0.6 \
> +    crate://crates.io/lazy_static/1.4.0 \
> +    crate://crates.io/libc/0.2.139 \
> +    crate://crates.io/memchr/2.5.0 \
> +    crate://crates.io/minimal-lexical/0.2.1 \
> +    crate://crates.io/nom/7.1.3 \
> +    crate://crates.io/num-bigint/0.4.3 \
> +    crate://crates.io/num-integer/0.1.45 \
> +    crate://crates.io/num-traits/0.2.15 \
> +    crate://crates.io/oid-registry/0.6.1 \
> +    crate://crates.io/once_cell/1.17.1 \
> +    crate://crates.io/pem/1.1.1 \
> +    crate://crates.io/proc-macro2/1.0.51 \
> +    crate://crates.io/quote/1.0.23 \
> +    crate://crates.io/radium/0.7.0 \
> +    crate://crates.io/rusticata-macros/4.1.0 \
> +    crate://crates.io/ryu/1.0.13 \
> +    crate://crates.io/serde/1.0.152 \
> +    crate://crates.io/serde_derive/1.0.152 \
> +    crate://crates.io/serde_json/1.0.94 \
> +    crate://crates.io/syn/1.0.109 \
> +    crate://crates.io/synstructure/0.12.6 \
> +    crate://crates.io/tap/1.0.1 \
> +    crate://crates.io/termcolor/1.2.0 \
> +    crate://crates.io/thiserror/1.0.39 \
> +    crate://crates.io/thiserror-impl/1.0.39 \
> +    crate://crates.io/time/0.3.20 \
> +    crate://crates.io/time-core/0.1.0 \
> +    crate://crates.io/time-macros/0.2.8 \
> +    crate://crates.io/trybuild/1.0.79 \
> +    crate://crates.io/unicode-ident/1.0.8 \
> +    crate://crates.io/unicode-xid/0.2.4 \
> +    crate://crates.io/winapi/0.3.9 \
> +    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> +    crate://crates.io/winapi-util/0.1.5 \
> +    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> +    crate://crates.io/wyz/0.5.1 \
> +"
>   
>   SRC_URI[asn1-rs-0.5.1.sha256sum] = "cf6690c370453db30743b373a60ba498fc0d6d83b11f4abfd87a84a075db5dd4"
>   SRC_URI[asn1-rs-derive-0.4.0.sha256sum] = "726535892e8eae7e70657b4c8ea93d26b8553afb1ce617caee529ef96d7dee6c" @@ -903,7 +764,216 @@ 
> SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5c
>   SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
>   SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
>   SRC_URI[wyz-0.5.1.sha256sum] = "05f360fc0b24296329c78fda852a1e9ae82de9cf7b27dae4b7f62f118f77b9ed"
> +# from rust/vendor/x509-parser/Cargo.lock
> +SRC_URI += " \
> +    crate://crates.io/asn1-rs/0.5.2 \
> +    crate://crates.io/asn1-rs-derive/0.4.0 \
> +    crate://crates.io/asn1-rs-impl/0.1.0 \
> +    crate://crates.io/autocfg/1.1.0 \
> +    crate://crates.io/bumpalo/3.13.0 \
> +    crate://crates.io/cc/1.0.81 \
> +    crate://crates.io/cfg-if/1.0.0 \
> +    crate://crates.io/data-encoding/2.4.0 \
> +    crate://crates.io/der-parser/8.2.0 \
> +    crate://crates.io/deranged/0.3.7 \
> +    crate://crates.io/displaydoc/0.2.4 \
> +    crate://crates.io/itoa/1.0.9 \
> +    crate://crates.io/js-sys/0.3.64 \
> +    crate://crates.io/lazy_static/1.4.0 \
> +    crate://crates.io/libc/0.2.147 \
> +    crate://crates.io/log/0.4.19 \
> +    crate://crates.io/memchr/2.5.0 \
> +    crate://crates.io/minimal-lexical/0.2.1 \
> +    crate://crates.io/nom/7.1.3 \
> +    crate://crates.io/num-bigint/0.4.3 \
> +    crate://crates.io/num-integer/0.1.45 \
> +    crate://crates.io/num-traits/0.2.16 \
> +    crate://crates.io/oid-registry/0.6.1 \
> +    crate://crates.io/once_cell/1.18.0 \
> +    crate://crates.io/proc-macro2/1.0.66 \
> +    crate://crates.io/quote/1.0.32 \
> +    crate://crates.io/ring/0.16.20 \
> +    crate://crates.io/rusticata-macros/4.1.0 \
> +    crate://crates.io/serde/1.0.180 \
> +    crate://crates.io/spin/0.5.2 \
> +    crate://crates.io/syn/1.0.109 \
> +    crate://crates.io/syn/2.0.28 \
> +    crate://crates.io/synstructure/0.12.6 \
> +    crate://crates.io/thiserror/1.0.44 \
> +    crate://crates.io/thiserror-impl/1.0.44 \
> +    crate://crates.io/time/0.3.25 \
> +    crate://crates.io/time-core/0.1.1 \
> +    crate://crates.io/time-macros/0.2.11 \
> +    crate://crates.io/unicode-ident/1.0.11 \
> +    crate://crates.io/unicode-xid/0.2.4 \
> +    crate://crates.io/untrusted/0.7.1 \
> +    crate://crates.io/wasm-bindgen/0.2.87 \
> +    crate://crates.io/wasm-bindgen-backend/0.2.87 \
> +    crate://crates.io/wasm-bindgen-macro/0.2.87 \
> +    crate://crates.io/wasm-bindgen-macro-support/0.2.87 \
> +    crate://crates.io/wasm-bindgen-shared/0.2.87 \
> +    crate://crates.io/web-sys/0.3.64 \
> +    crate://crates.io/winapi/0.3.9 \
> +    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> +    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> +"
> +
> +SRC_URI[asn1-rs-0.5.2.sha256sum] = "7f6fd5ddaf0351dff5b8da21b2fb4ff8e08ddd02857f0bf69c47639106c0fff0"
> +SRC_URI[asn1-rs-derive-0.4.0.sha256sum] = "726535892e8eae7e70657b4c8ea93d26b8553afb1ce617caee529ef96d7dee6c"
> +SRC_URI[asn1-rs-impl-0.1.0.sha256sum] = "2777730b2039ac0f95f093556e61b6d26cebed5393ca6f152717777cec3a42ed"
> +SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
> +SRC_URI[bumpalo-3.13.0.sha256sum] = "a3e2c3daef883ecc1b5d58c15adae93470a91d425f3532ba1695849656af3fc1"
> +SRC_URI[cc-1.0.81.sha256sum] = "6c6b2562119bf28c3439f7f02db99faf0aa1a8cdfe5772a2ee155d32227239f0"
> +SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> +SRC_URI[data-encoding-2.4.0.sha256sum] = "c2e66c9d817f1720209181c316d28635c050fa304f9c79e47a520882661b7308"
> +SRC_URI[der-parser-8.2.0.sha256sum] = "dbd676fbbab537128ef0278adb5576cf363cff6aa22a7b24effe97347cfab61e"
> +SRC_URI[deranged-0.3.7.sha256sum] = "7684a49fb1af197853ef7b2ee694bc1f5b4179556f1e5710e1760c5db6f5e929"
> +SRC_URI[displaydoc-0.2.4.sha256sum] = "487585f4d0c6655fe74905e2504d8ad6908e4db67f744eb140876906c2f3175d"
> +SRC_URI[itoa-1.0.9.sha256sum] = "af150ab688ff2122fcef229be89cb50dd66af9e01a4ff320cc137eecc9bacc38"
> +SRC_URI[js-sys-0.3.64.sha256sum] = "c5f195fe497f702db0f318b07fdd68edb16955aed830df8363d837542f8f935a"
> +SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
> +SRC_URI[libc-0.2.147.sha256sum] = "b4668fb0ea861c1df094127ac5f1da3409a82116a4ba74fca2e58ef927159bb3"
> +SRC_URI[log-0.4.19.sha256sum] = "b06a4cde4c0f271a446782e3eff8de789548ce57dbc8eca9292c27f4a42004b4"
> +SRC_URI[memchr-2.5.0.sha256sum] = "2dffe52ecf27772e601905b7522cb4ef790d2cc203488bbd0e2fe85fcb74566d"
> +SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
> +SRC_URI[nom-7.1.3.sha256sum] = "d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
> +SRC_URI[num-bigint-0.4.3.sha256sum] = "f93ab6289c7b344a8a9f60f88d80aa20032336fe78da341afc91c8a2341fc75f"
> +SRC_URI[num-integer-0.1.45.sha256sum] = "225d3389fb3509a24c93f5c29eb6bde2586b98d9f016636dff58d7c6f7569cd9"
> +SRC_URI[num-traits-0.2.16.sha256sum] = "f30b0abd723be7e2ffca1272140fac1a2f084c77ec3e123c192b66af1ee9e6c2"
> +SRC_URI[oid-registry-0.6.1.sha256sum] = "9bedf36ffb6ba96c2eb7144ef6270557b52e54b20c0a8e1eb2ff99a6c6959bff"
> +SRC_URI[once_cell-1.18.0.sha256sum] = "dd8b5dd2ae5ed71462c540258bedcb51965123ad7e7ccf4b9a8cafaa4a63576d"
> +SRC_URI[proc-macro2-1.0.66.sha256sum] = "18fb31db3f9bddb2ea821cde30a9f70117e3f119938b5ee630b7403aa6e2ead9"
> +SRC_URI[quote-1.0.32.sha256sum] = "50f3b39ccfb720540debaa0164757101c08ecb8d326b15358ce76a62c7e85965"
> +SRC_URI[ring-0.16.20.sha256sum] = "3053cf52e236a3ed746dfc745aa9cacf1b791d846bdaf412f60a8d7d6e17c8fc"
> +SRC_URI[rusticata-macros-4.1.0.sha256sum] = "faf0c4a6ece9950b9abdb62b1cfcf2a68b3b67a10ba445b3bb85be2a293d0632"
> +SRC_URI[serde-1.0.180.sha256sum] = "0ea67f183f058fe88a4e3ec6e2788e003840893b91bac4559cabedd00863b3ed"
> +SRC_URI[spin-0.5.2.sha256sum] = "6e63cff320ae2c57904679ba7cb63280a3dc4613885beafb148ee7bf9aa9042d"
> +SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
> +SRC_URI[syn-2.0.28.sha256sum] = "04361975b3f5e348b2189d8dc55bc942f278b2d482a6a0365de5bdd62d351567"
> +SRC_URI[synstructure-0.12.6.sha256sum] = "f36bdaa60a83aca3921b5259d5400cbf5e90fc51931376a9bd4a0eb79aa7210f"
> +SRC_URI[thiserror-1.0.44.sha256sum] = "611040a08a0439f8248d1990b111c95baa9c704c805fa1f62104b39655fd7f90"
> +SRC_URI[thiserror-impl-1.0.44.sha256sum] = "090198534930841fab3a5d1bb637cde49e339654e606195f8d9c76eeb081dc96"
> +SRC_URI[time-0.3.25.sha256sum] = "b0fdd63d58b18d663fbdf70e049f00a22c8e42be082203be7f26589213cd75ea"
> +SRC_URI[time-core-0.1.1.sha256sum] = "7300fbefb4dadc1af235a9cef3737cea692a9d97e1b9cbcd4ebdae6f8868e6fb"
> +SRC_URI[time-macros-0.2.11.sha256sum] = "eb71511c991639bb078fd5bf97757e03914361c48100d52878b8e52b46fb92cd"
> +SRC_URI[unicode-ident-1.0.11.sha256sum] = "301abaae475aa91687eb82514b328ab47a211a533026cb25fc3e519b86adfc3c"
> +SRC_URI[unicode-xid-0.2.4.sha256sum] = "f962df74c8c05a667b5ee8bcf162993134c104e96440b663c8daa176dc772d8c"
> +SRC_URI[untrusted-0.7.1.sha256sum] = "a156c684c91ea7d62626509bce3cb4e1d9ed5c4d978f7b4352658f96a4c26b4a"
> +SRC_URI[wasm-bindgen-0.2.87.sha256sum] = "7706a72ab36d8cb1f80ffbf0e071533974a60d0a308d01a5d0375bf60499a342"
> +SRC_URI[wasm-bindgen-backend-0.2.87.sha256sum] = "5ef2b6d3c510e9625e5fe6f509ab07d66a760f0885d858736483c32ed7809abd"
> +SRC_URI[wasm-bindgen-macro-0.2.87.sha256sum] = "dee495e55982a3bd48105a7b947fd2a9b4a8ae3010041b9e0faab3f9cd028f1d"
> +SRC_URI[wasm-bindgen-macro-support-0.2.87.sha256sum] = "54681b18a46765f095758388f2d0cf16eb8d4169b639ab575a8f5693af210c7b"
> +SRC_URI[wasm-bindgen-shared-0.2.87.sha256sum] = "ca6ad05a4870b2bf5fe995117d3728437bd27d7cd5f06f13c17443ef369775a1"
> +SRC_URI[web-sys-0.3.64.sha256sum] = "9b85cbef8c220a6abc02aefd892dfc0fc23afb1c6a426316ec33253a3877249b"
> +SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
> +SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
> +SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
> +# from rust/vendor/displaydoc/Cargo.lock
> +SRC_URI += " \
> +    crate://crates.io/ansi_term/0.11.0 \
> +    crate://crates.io/basic-toml/0.1.2 \
> +    crate://crates.io/ctor/0.1.26 \
> +    crate://crates.io/difference/2.0.0 \
> +    crate://crates.io/glob/0.3.1 \
> +    crate://crates.io/itoa/1.0.6 \
> +    crate://crates.io/libc/0.2.142 \
> +    crate://crates.io/once_cell/1.17.1 \
> +    crate://crates.io/output_vt100/0.1.3 \
> +    crate://crates.io/pretty_assertions/0.6.1 \
> +    crate://crates.io/proc-macro2/1.0.56 \
> +    crate://crates.io/quote/1.0.26 \
> +    crate://crates.io/rustversion/1.0.12 \
> +    crate://crates.io/ryu/1.0.13 \
> +    crate://crates.io/serde/1.0.160 \
> +    crate://crates.io/serde_derive/1.0.160 \
> +    crate://crates.io/serde_json/1.0.96 \
> +    crate://crates.io/static_assertions/1.1.0 \
> +    crate://crates.io/syn/1.0.109 \
> +    crate://crates.io/syn/2.0.15 \
> +    crate://crates.io/termcolor/1.2.0 \
> +    crate://crates.io/thiserror/1.0.40 \
> +    crate://crates.io/thiserror-impl/1.0.40 \
> +    crate://crates.io/trybuild/1.0.80 \
> +    crate://crates.io/unicode-ident/1.0.8 \
> +    crate://crates.io/winapi/0.3.9 \
> +    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> +    crate://crates.io/winapi-util/0.1.5 \
> +    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> +"
> +
> +SRC_URI[ansi_term-0.11.0.sha256sum] = "ee49baf6cb617b853aa8d93bf420db2383fab46d314482ca2803b40d5fde979b"
> +SRC_URI[basic-toml-0.1.2.sha256sum] = "5c0de75129aa8d0cceaf750b89013f0e08804d6ec61416da787b35ad0d7cddf1"
> +SRC_URI[ctor-0.1.26.sha256sum] = "6d2301688392eb071b0bf1a37be05c469d3cc4dbbd95df672fe28ab021e6a096"
> +SRC_URI[difference-2.0.0.sha256sum] = "524cbf6897b527295dff137cec09ecf3a05f4fddffd7dfcd1585403449e74198"
> +SRC_URI[glob-0.3.1.sha256sum] = "d2fabcfbdc87f4758337ca535fb41a6d701b65693ce38287d856d1674551ec9b"
> +SRC_URI[itoa-1.0.6.sha256sum] = "453ad9f582a441959e5f0d088b02ce04cfe8d51a8eaf077f12ac6d3e94164ca6"
> +SRC_URI[libc-0.2.142.sha256sum] = "6a987beff54b60ffa6d51982e1aa1146bc42f19bd26be28b0586f252fccf5317"
> +SRC_URI[once_cell-1.17.1.sha256sum] = "b7e5500299e16ebb147ae15a00a942af264cf3688f47923b8fc2cd5858f23ad3"
> +SRC_URI[output_vt100-0.1.3.sha256sum] = "628223faebab4e3e40667ee0b2336d34a5b960ff60ea743ddfdbcf7770bcfb66"
> +SRC_URI[pretty_assertions-0.6.1.sha256sum] = "3f81e1644e1b54f5a68959a29aa86cde704219254669da328ecfdf6a1f09d427"
> +SRC_URI[proc-macro2-1.0.56.sha256sum] = "2b63bdb0cd06f1f4dedf69b254734f9b45af66e4a031e42a7480257d9898b435"
> +SRC_URI[quote-1.0.26.sha256sum] = "4424af4bf778aae2051a77b60283332f386554255d722233d09fbfc7e30da2fc"
> +SRC_URI[rustversion-1.0.12.sha256sum] = "4f3208ce4d8448b3f3e7d168a73f5e0c43a61e32930de3bceeccedb388b6bf06"
> +SRC_URI[ryu-1.0.13.sha256sum] = "f91339c0467de62360649f8d3e185ca8de4224ff281f66000de5eb2a77a79041"
> +SRC_URI[serde-1.0.160.sha256sum] = "bb2f3770c8bce3bcda7e149193a069a0f4365bda1fa5cd88e03bca26afc1216c"
> +SRC_URI[serde_derive-1.0.160.sha256sum] = "291a097c63d8497e00160b166a967a4a79c64f3facdd01cbd7502231688d77df"
> +SRC_URI[serde_json-1.0.96.sha256sum] = "057d394a50403bcac12672b2b18fb387ab6d289d957dab67dd201875391e52f1"
> +SRC_URI[static_assertions-1.1.0.sha256sum] = "a2eb9349b6444b326872e140eb1cf5e7c522154d69e7a0ffb0fb81c06b37543f"
> +SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
> +SRC_URI[syn-2.0.15.sha256sum] = "a34fcf3e8b60f57e6a14301a2e916d323af98b0ea63c599441eec8558660c822"
> +SRC_URI[termcolor-1.2.0.sha256sum] = "be55cf8942feac5c765c2c993422806843c9a9a45d4d5c407ad6dd2ea95eb9b6"
> +SRC_URI[thiserror-1.0.40.sha256sum] = "978c9a314bd8dc99be594bc3c175faaa9794be04a5a5e153caba6915336cebac"
> +SRC_URI[thiserror-impl-1.0.40.sha256sum] = "f9456a42c5b0d803c8cd86e73dd7cc9edd429499f37a3550d286d5e86720569f"
> +SRC_URI[trybuild-1.0.80.sha256sum] = "501dbdbb99861e4ab6b60eb6a7493956a9defb644fd034bc4a5ef27c693c8a3a"
> +SRC_URI[unicode-ident-1.0.8.sha256sum] = "e5464a87b239f13a63a501f2701565754bae92d243d4bb7eb12f6d57d2269bf4"
> +SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
> +SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
> +SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
> +SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
> +# from rust/vendor/toml/Cargo.lock
> +SRC_URI += " \
> +    crate://crates.io/autocfg/1.1.0 \
> +    crate://crates.io/hashbrown/0.12.3 \
> +    crate://crates.io/indexmap/1.9.2 \
> +    crate://crates.io/itoa/1.0.5 \
> +    crate://crates.io/proc-macro2/1.0.50 \
> +    crate://crates.io/quote/1.0.23 \
> +    crate://crates.io/ryu/1.0.12 \
> +    crate://crates.io/serde/1.0.152 \
> +    crate://crates.io/serde_derive/1.0.152 \
> +    crate://crates.io/serde_json/1.0.91 \
> +    crate://crates.io/syn/1.0.107 \
> +    crate://crates.io/unicode-ident/1.0.6 \
> +"
> +
> +SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
> +SRC_URI[hashbrown-0.12.3.sha256sum] = "8a9ee70c43aaf417c914396645a0fa852624801b24ebb7ae78fe8272889ac888"
> +SRC_URI[indexmap-1.9.2.sha256sum] = "1885e79c1fc4b10f0e172c475f458b7f7b93061064d98c3293e98c5ba0c8b399"
> +SRC_URI[itoa-1.0.5.sha256sum] = "fad582f4b9e86b6caa621cabeb0963332d92eea04729ab12892c2533951e6440"
> +SRC_URI[proc-macro2-1.0.50.sha256sum] = "6ef7d57beacfaf2d8aee5937dab7b7f28de3cb8b1828479bb5de2a7106f2bae2"
> +SRC_URI[quote-1.0.23.sha256sum] = "8856d8364d252a14d474036ea1358d63c9e6965c8e5c1885c18f73d70bff9c7b"
> +SRC_URI[ryu-1.0.12.sha256sum] = "7b4b9743ed687d4b4bcedf9ff5eaa7398495ae14e61cba0a295704edbc7decde"
> +SRC_URI[serde-1.0.152.sha256sum] = "bb7d1f0d3021d347a83e556fc4683dea2ea09d87bccdf88ff5c12545d89d5efb"
> +SRC_URI[serde_derive-1.0.152.sha256sum] = "af487d118eecd09402d70a5d72551860e788df87b464af30e5ea6a38c75c541e"
> +SRC_URI[serde_json-1.0.91.sha256sum] = "877c235533714907a8c2464236f5c4b2a17262ef1bd71f38f35ea592c8da6883"
> +SRC_URI[syn-1.0.107.sha256sum] = "1f4064b5b16e03ae50984a5a8ed5d4f8803e6bc1fd170a3cda91a1be4b18e3f5"
> +SRC_URI[unicode-ident-1.0.6.sha256sum] = "84a22b9f218b40614adcb3f4ff08b703773ad44fa9423e4e0d346d5db86e4ebc"
>   # from rust/vendor/brotli/Cargo.lock
> +SRC_URI += " \
> +    crate://crates.io/alloc-no-stdlib/2.0.4 \
> +    crate://crates.io/alloc-stdlib/0.2.2 \
> +    crate://crates.io/block-buffer/0.10.4 \
> +    crate://crates.io/brotli-decompressor/5.0.0 \
> +    crate://crates.io/cfg-if/1.0.0 \
> +    crate://crates.io/cpufeatures/0.2.17 \
> +    crate://crates.io/crypto-common/0.1.6 \
> +    crate://crates.io/digest/0.10.7 \
> +    crate://crates.io/generic-array/0.14.7 \
> +    crate://crates.io/libc/0.2.172 \
> +    crate://crates.io/sha2/0.10.9 \
> +    crate://crates.io/typenum/1.18.0 \
> +    crate://crates.io/version_check/0.9.5 \
> +"
>   
>   SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
>   SRC_URI[alloc-stdlib-0.2.2.sha256sum] = "94fb8275041c72129eb51b7d0322c29b8387a0386127718b096429201a5d6ece" @@ -919,6 +989,82 @@ SRC_URI[sha2-0.10.9.sha256sum] = "a7507d819769d01a365ab707794a4084392c824f54a7a6
>   SRC_URI[typenum-1.18.0.sha256sum] = "1dccffe3ce07af9386bfd29e80c0ab1a8205a2fc34e4bcd40364df902cfa8f3f"
>   SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
>   # from rust/vendor/phf_generator/Cargo.lock
> +SRC_URI += " \
> +    crate://crates.io/atty/0.2.14 \
> +    crate://crates.io/autocfg/1.0.1 \
> +    crate://crates.io/bitflags/1.2.1 \
> +    crate://crates.io/bstr/0.2.16 \
> +    crate://crates.io/bumpalo/3.7.0 \
> +    crate://crates.io/cast/0.2.7 \
> +    crate://crates.io/cfg-if/1.0.0 \
> +    crate://crates.io/clap/2.33.3 \
> +    crate://crates.io/criterion/0.3.4 \
> +    crate://crates.io/criterion-plot/0.4.4 \
> +    crate://crates.io/crossbeam-channel/0.5.1 \
> +    crate://crates.io/crossbeam-deque/0.8.1 \
> +    crate://crates.io/crossbeam-epoch/0.9.5 \
> +    crate://crates.io/crossbeam-utils/0.8.5 \
> +    crate://crates.io/csv/1.1.6 \
> +    crate://crates.io/csv-core/0.1.10 \
> +    crate://crates.io/either/1.6.1 \
> +    crate://crates.io/getrandom/0.2.3 \
> +    crate://crates.io/half/1.7.1 \
> +    crate://crates.io/hermit-abi/0.1.19 \
> +    crate://crates.io/itertools/0.10.1 \
> +    crate://crates.io/itoa/0.4.7 \
> +    crate://crates.io/js-sys/0.3.52 \
> +    crate://crates.io/lazy_static/1.4.0 \
> +    crate://crates.io/libc/0.2.99 \
> +    crate://crates.io/log/0.4.14 \
> +    crate://crates.io/memchr/2.4.0 \
> +    crate://crates.io/memoffset/0.6.4 \
> +    crate://crates.io/num-traits/0.2.14 \
> +    crate://crates.io/num_cpus/1.13.0 \
> +    crate://crates.io/oorandom/11.1.3 \
> +    crate://crates.io/phf_shared/0.10.0 \
> +    crate://crates.io/plotters/0.3.1 \
> +    crate://crates.io/plotters-backend/0.3.2 \
> +    crate://crates.io/plotters-svg/0.3.1 \
> +    crate://crates.io/ppv-lite86/0.2.10 \
> +    crate://crates.io/proc-macro2/1.0.28 \
> +    crate://crates.io/quote/1.0.9 \
> +    crate://crates.io/rand/0.8.4 \
> +    crate://crates.io/rand_chacha/0.3.1 \
> +    crate://crates.io/rand_core/0.6.3 \
> +    crate://crates.io/rand_hc/0.3.1 \
> +    crate://crates.io/rayon/1.5.1 \
> +    crate://crates.io/rayon-core/1.9.1 \
> +    crate://crates.io/regex/1.5.4 \
> +    crate://crates.io/regex-automata/0.1.10 \
> +    crate://crates.io/regex-syntax/0.6.25 \
> +    crate://crates.io/rustc_version/0.4.0 \
> +    crate://crates.io/ryu/1.0.5 \
> +    crate://crates.io/same-file/1.0.6 \
> +    crate://crates.io/scopeguard/1.1.0 \
> +    crate://crates.io/semver/1.0.4 \
> +    crate://crates.io/serde/1.0.127 \
> +    crate://crates.io/serde_cbor/0.11.1 \
> +    crate://crates.io/serde_derive/1.0.127 \
> +    crate://crates.io/serde_json/1.0.66 \
> +    crate://crates.io/siphasher/0.3.6 \
> +    crate://crates.io/syn/1.0.74 \
> +    crate://crates.io/textwrap/0.11.0 \
> +    crate://crates.io/tinytemplate/1.2.1 \
> +    crate://crates.io/unicode-width/0.1.8 \
> +    crate://crates.io/unicode-xid/0.2.2 \
> +    crate://crates.io/walkdir/2.3.2 \
> +    crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
> +    crate://crates.io/wasm-bindgen/0.2.75 \
> +    crate://crates.io/wasm-bindgen-backend/0.2.75 \
> +    crate://crates.io/wasm-bindgen-macro/0.2.75 \
> +    crate://crates.io/wasm-bindgen-macro-support/0.2.75 \
> +    crate://crates.io/wasm-bindgen-shared/0.2.75 \
> +    crate://crates.io/web-sys/0.3.52 \
> +    crate://crates.io/winapi/0.3.9 \
> +    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
> +    crate://crates.io/winapi-util/0.1.5 \
> +    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
> +"
>   
>   SRC_URI[atty-0.2.14.sha256sum] = "d9b39be18770d11421cdb1b9947a45dd3f37e93092cbf377614828a319d5fee8"
>   SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a" @@ -994,120 +1140,3 @@ SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761
>   SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
>   SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
>   SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
> -# from rust/vendor/alloc-stdlib/Cargo.lock
> -
> -SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
> -# from rust/vendor/x509-parser/Cargo.lock
> -
> -SRC_URI[asn1-rs-0.5.2.sha256sum] = "7f6fd5ddaf0351dff5b8da21b2fb4ff8e08ddd02857f0bf69c47639106c0fff0"
> -SRC_URI[asn1-rs-derive-0.4.0.sha256sum] = "726535892e8eae7e70657b4c8ea93d26b8553afb1ce617caee529ef96d7dee6c"
> -SRC_URI[asn1-rs-impl-0.1.0.sha256sum] = "2777730b2039ac0f95f093556e61b6d26cebed5393ca6f152717777cec3a42ed"
> -SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
> -SRC_URI[bumpalo-3.13.0.sha256sum] = "a3e2c3daef883ecc1b5d58c15adae93470a91d425f3532ba1695849656af3fc1"
> -SRC_URI[cc-1.0.81.sha256sum] = "6c6b2562119bf28c3439f7f02db99faf0aa1a8cdfe5772a2ee155d32227239f0"
> -SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> -SRC_URI[data-encoding-2.4.0.sha256sum] = "c2e66c9d817f1720209181c316d28635c050fa304f9c79e47a520882661b7308"
> -SRC_URI[der-parser-8.2.0.sha256sum] = "dbd676fbbab537128ef0278adb5576cf363cff6aa22a7b24effe97347cfab61e"
> -SRC_URI[deranged-0.3.7.sha256sum] = "7684a49fb1af197853ef7b2ee694bc1f5b4179556f1e5710e1760c5db6f5e929"
> -SRC_URI[displaydoc-0.2.4.sha256sum] = "487585f4d0c6655fe74905e2504d8ad6908e4db67f744eb140876906c2f3175d"
> -SRC_URI[itoa-1.0.9.sha256sum] = "af150ab688ff2122fcef229be89cb50dd66af9e01a4ff320cc137eecc9bacc38"
> -SRC_URI[js-sys-0.3.64.sha256sum] = "c5f195fe497f702db0f318b07fdd68edb16955aed830df8363d837542f8f935a"
> -SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
> -SRC_URI[libc-0.2.147.sha256sum] = "b4668fb0ea861c1df094127ac5f1da3409a82116a4ba74fca2e58ef927159bb3"
> -SRC_URI[log-0.4.19.sha256sum] = "b06a4cde4c0f271a446782e3eff8de789548ce57dbc8eca9292c27f4a42004b4"
> -SRC_URI[memchr-2.5.0.sha256sum] = "2dffe52ecf27772e601905b7522cb4ef790d2cc203488bbd0e2fe85fcb74566d"
> -SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
> -SRC_URI[nom-7.1.3.sha256sum] = "d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
> -SRC_URI[num-bigint-0.4.3.sha256sum] = "f93ab6289c7b344a8a9f60f88d80aa20032336fe78da341afc91c8a2341fc75f"
> -SRC_URI[num-integer-0.1.45.sha256sum] = "225d3389fb3509a24c93f5c29eb6bde2586b98d9f016636dff58d7c6f7569cd9"
> -SRC_URI[num-traits-0.2.16.sha256sum] = "f30b0abd723be7e2ffca1272140fac1a2f084c77ec3e123c192b66af1ee9e6c2"
> -SRC_URI[oid-registry-0.6.1.sha256sum] = "9bedf36ffb6ba96c2eb7144ef6270557b52e54b20c0a8e1eb2ff99a6c6959bff"
> -SRC_URI[once_cell-1.18.0.sha256sum] = "dd8b5dd2ae5ed71462c540258bedcb51965123ad7e7ccf4b9a8cafaa4a63576d"
> -SRC_URI[proc-macro2-1.0.66.sha256sum] = "18fb31db3f9bddb2ea821cde30a9f70117e3f119938b5ee630b7403aa6e2ead9"
> -SRC_URI[quote-1.0.32.sha256sum] = "50f3b39ccfb720540debaa0164757101c08ecb8d326b15358ce76a62c7e85965"
> -SRC_URI[ring-0.16.20.sha256sum] = "3053cf52e236a3ed746dfc745aa9cacf1b791d846bdaf412f60a8d7d6e17c8fc"
> -SRC_URI[rusticata-macros-4.1.0.sha256sum] = "faf0c4a6ece9950b9abdb62b1cfcf2a68b3b67a10ba445b3bb85be2a293d0632"
> -SRC_URI[serde-1.0.180.sha256sum] = "0ea67f183f058fe88a4e3ec6e2788e003840893b91bac4559cabedd00863b3ed"
> -SRC_URI[spin-0.5.2.sha256sum] = "6e63cff320ae2c57904679ba7cb63280a3dc4613885beafb148ee7bf9aa9042d"
> -SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
> -SRC_URI[syn-2.0.28.sha256sum] = "04361975b3f5e348b2189d8dc55bc942f278b2d482a6a0365de5bdd62d351567"
> -SRC_URI[synstructure-0.12.6.sha256sum] = "f36bdaa60a83aca3921b5259d5400cbf5e90fc51931376a9bd4a0eb79aa7210f"
> -SRC_URI[thiserror-1.0.44.sha256sum] = "611040a08a0439f8248d1990b111c95baa9c704c805fa1f62104b39655fd7f90"
> -SRC_URI[thiserror-impl-1.0.44.sha256sum] = "090198534930841fab3a5d1bb637cde49e339654e606195f8d9c76eeb081dc96"
> -SRC_URI[time-0.3.25.sha256sum] = "b0fdd63d58b18d663fbdf70e049f00a22c8e42be082203be7f26589213cd75ea"
> -SRC_URI[time-core-0.1.1.sha256sum] = "7300fbefb4dadc1af235a9cef3737cea692a9d97e1b9cbcd4ebdae6f8868e6fb"
> -SRC_URI[time-macros-0.2.11.sha256sum] = "eb71511c991639bb078fd5bf97757e03914361c48100d52878b8e52b46fb92cd"
> -SRC_URI[unicode-ident-1.0.11.sha256sum] = "301abaae475aa91687eb82514b328ab47a211a533026cb25fc3e519b86adfc3c"
> -SRC_URI[unicode-xid-0.2.4.sha256sum] = "f962df74c8c05a667b5ee8bcf162993134c104e96440b663c8daa176dc772d8c"
> -SRC_URI[untrusted-0.7.1.sha256sum] = "a156c684c91ea7d62626509bce3cb4e1d9ed5c4d978f7b4352658f96a4c26b4a"
> -SRC_URI[wasm-bindgen-0.2.87.sha256sum] = "7706a72ab36d8cb1f80ffbf0e071533974a60d0a308d01a5d0375bf60499a342"
> -SRC_URI[wasm-bindgen-backend-0.2.87.sha256sum] = "5ef2b6d3c510e9625e5fe6f509ab07d66a760f0885d858736483c32ed7809abd"
> -SRC_URI[wasm-bindgen-macro-0.2.87.sha256sum] = "dee495e55982a3bd48105a7b947fd2a9b4a8ae3010041b9e0faab3f9cd028f1d"
> -SRC_URI[wasm-bindgen-macro-support-0.2.87.sha256sum] = "54681b18a46765f095758388f2d0cf16eb8d4169b639ab575a8f5693af210c7b"
> -SRC_URI[wasm-bindgen-shared-0.2.87.sha256sum] = "ca6ad05a4870b2bf5fe995117d3728437bd27d7cd5f06f13c17443ef369775a1"
> -SRC_URI[web-sys-0.3.64.sha256sum] = "9b85cbef8c220a6abc02aefd892dfc0fc23afb1c6a426316ec33253a3877249b"
> -SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
> -SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
> -SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
> -# from rust/vendor/regex/Cargo.lock
> -
> -SRC_URI[aho-corasick-0.7.18.sha256sum] = "1e37cfd5e7657ada45f742d6e99ca5788580b5c529dc78faf11ece6dc702656f"
> -SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> -SRC_URI[getrandom-0.2.6.sha256sum] = "9be70c98951c83b8d2f8f60d7065fa6d5146873094452a1008da8c2f1e4205ad"
> -SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
> -SRC_URI[libc-0.2.125.sha256sum] = "5916d2ae698f6de9bfb891ad7a8d65c09d232dc58cc4ac433c7da3b2fd84bc2b"
> -SRC_URI[memchr-2.5.0.sha256sum] = "2dffe52ecf27772e601905b7522cb4ef790d2cc203488bbd0e2fe85fcb74566d"
> -SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
> -SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
> -SRC_URI[rand_core-0.6.3.sha256sum] = "d34f1408f55294453790c48b2f1ebbb1c5b4b7563eb1f418bcfcfdbb06ebb4e7"
> -SRC_URI[regex-syntax-0.6.26.sha256sum] = "49b3de9ec5dc0a3417da371aab17d729997c15010e7fd24ff707773a33bddb64"
> -SRC_URI[wasi-0.10.2+wasi-snapshot-preview1.sha256sum] = "fd6fbd9a79829dd1ad0cc20627bf1ed606756a7f77edff7b66b7064f9cb327c6"
> -# from rust/vendor/bendy/Cargo.lock
> -
> -SRC_URI[addr2line-0.14.0.sha256sum] = "7c0929d69e78dd9bf5408269919fcbcaeb2e35e5d43e5815517cdc6a8e11a423"
> -SRC_URI[adler-0.2.3.sha256sum] = "ee2a4ec343196209d6594e19543ae87a39f96d5534d7174822a3ad825dd6ed7e"
> -SRC_URI[aho-corasick-0.7.15.sha256sum] = "7404febffaa47dac81aa44dba71523c9d069b1bdc50a77db41195149e17f68e5"
> -SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a"
> -SRC_URI[backtrace-0.3.54.sha256sum] = "2baad346b2d4e94a24347adeee9c7a93f412ee94b9cc26e5b59dea23848e9f28"
> -SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> -SRC_URI[failure-0.1.8.sha256sum] = "d32e9bd16cc02eae7db7ef620b392808b89f6a5e16bb3497d159c6b92a0f4f86"
> -SRC_URI[failure_derive-0.1.8.sha256sum] = "aa4da3c766cd7a0db8242e326e9e4e081edd567072893ed320008189715366a4"
> -SRC_URI[gimli-0.23.0.sha256sum] = "f6503fe142514ca4799d4c26297c4248239fe8838d827db6bd6065c6ed29a6ce"
> -SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
> -SRC_URI[libc-0.2.80.sha256sum] = "4d58d1b70b004888f764dfbf6a26a3b0342a1632d33968e4a179d8011c760614"
> -SRC_URI[memchr-2.3.4.sha256sum] = "0ee1c47aaa256ecabcaea351eae4a9b01ef39ed810004e298d2511ed284b1525"
> -SRC_URI[miniz_oxide-0.4.3.sha256sum] = "0f2d26ec3309788e423cfbf68ad1800f061638098d76a83681af979dc4eda19d"
> -SRC_URI[object-0.22.0.sha256sum] = "8d3b63360ec3cb337817c2dbd47ab4a0f170d285d8e5a2064600f3def1402397"
> -SRC_URI[proc-macro2-1.0.24.sha256sum] = "1e0704ee1a7e00d7bb417d0770ea303c1bccbabf0ef1667dae92b5967f5f8a71"
> -SRC_URI[quote-1.0.7.sha256sum] = "aa563d17ecb180e500da1cfd2b028310ac758de548efdd203e18f283af693f37"
> -SRC_URI[regex-1.4.2.sha256sum] = "38cf2c13ed4745de91a5eb834e11c00bcc3709e773173b2ce4c56c9fbde04b9c"
> -SRC_URI[regex-syntax-0.6.21.sha256sum] = "3b181ba2dcf07aaccad5448e8ead58db5b742cf85dfe035e2227f137a539a189"
> -SRC_URI[rustc-demangle-0.1.18.sha256sum] = "6e3bad0ee36814ca07d7968269dd4b7ec89ec2da10c4bb613928d3077083c232"
> -SRC_URI[serde-1.0.117.sha256sum] = "b88fa983de7720629c9387e9f517353ed404164b1e482c970a90c1a4aaf7dc1a"
> -SRC_URI[serde_bytes-0.11.5.sha256sum] = "16ae07dd2f88a366f15bd0632ba725227018c69a1c8550a927324f8eb8368bb9"
> -SRC_URI[serde_derive-1.0.117.sha256sum] = "cbd1ae72adb44aab48f325a02444a5fc079349a8d804c1fc922aed3f7454c74e"
> -SRC_URI[syn-1.0.48.sha256sum] = "cc371affeffc477f42a221a1e4297aedcea33d47d19b61455588bd9d8f6b19ac"
> -SRC_URI[synstructure-0.12.4.sha256sum] = "b834f2d66f734cb897113e34aaff2f1ab4719ca946f9a7358dba8f8064148701"
> -SRC_URI[thread_local-1.0.1.sha256sum] = "d40c6d1b69745a6ec6fb1ca717914848da4b44ae29d9b3080cbee91d72a69b14"
> -SRC_URI[unicode-xid-0.2.1.sha256sum] = "f7fe0bb3479651439c9112f72b6c505038574c9fbb575ed1bf3b797fa39dd564"
> -# from rust/vendor/flate2/Cargo.lock
> -
> -SRC_URI[adler-1.0.2.sha256sum] = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
> -SRC_URI[cc-1.0.79.sha256sum] = "50d30906286121d95be3d479533b458f87493b30a4b5f79a607db8f5d11aa91f"
> -SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
> -SRC_URI[cloudflare-zlib-sys-0.3.0.sha256sum] = "2040b6d1edfee6d75f172d81e2d2a7807534f3f294ce18184c70e7bb0105cd6f"
> -SRC_URI[cmake-0.1.50.sha256sum] = "a31c789563b815f77f4250caee12365734369f942439b7defd71e18a48197130"
> -SRC_URI[crc32fast-1.3.2.sha256sum] = "b540bd8bc810d3885c6ea91e2018302f68baba2129ab3e88f32389ee9370880d"
> -SRC_URI[getrandom-0.2.9.sha256sum] = "c85e1d9ab2eadba7e5040d4e09cbd6d072b76a557ad64e797c2cb9d4da21d7e4"
> -SRC_URI[libc-0.2.144.sha256sum] = "2b00cc1c228a6782d0f076e7b232802e0c5689d41bb5df366f2a6b6621cfdfe1"
> -SRC_URI[libz-ng-sys-1.1.10.sha256sum] = "425fb6808068335c8c7c69d1cff0a7d1ed8f681e9ac040272f160a89e6f43b8b"
> -SRC_URI[libz-sys-1.1.10.sha256sum] = "24e6ab01971eb092ffe6a7d42f49f9ff42662f17604681e2843ad65077ba47dc"
> -SRC_URI[miniz_oxide-0.7.1.sha256sum] = "e7810e0be55b428ada41041c41f32c9f1a42817901b4ccf45fa3d4b6561e74c7"
> -SRC_URI[pkg-config-0.3.27.sha256sum] = "26072860ba924cbfa98ea39c8c19b4dd6a4a25423dbdf219c1eca91aa0cf6964"
> -SRC_URI[ppv-lite86-0.2.17.sha256sum] = "5b40af805b3121feab8a3c29f04d8ad262fa8e0561883e7653e024ae4479e6de"
> -SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
> -SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
> -SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
> -SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
> -SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
> -SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
> diff --git a/recipes-ids/suricata/suricata_7.0.12.bb b/recipes-ids/suricata/suricata_7.0.13.bb
> similarity index 98%
> rename from recipes-ids/suricata/suricata_7.0.12.bb
> rename to recipes-ids/suricata/suricata_7.0.13.bb
> index ff022e0..75e523e 100644
> --- a/recipes-ids/suricata/suricata_7.0.12.bb
> +++ b/recipes-ids/suricata/suricata_7.0.13.bb
> @@ -5,7 +5,7 @@ require suricata.inc
>   LIC_FILES_CHKSUM ="file://LICENSE;beginline=1;endline=2;md5=c70d8d3310941dcdfcd1e02800a1f548"
>   
>   SRC_URI ="http://www.openinfosecfoundation.org/download/suricata-${PV}.tar.gz"
> -SRC_URI[sha256sum] = "da5a591c749fed2bd986fc3b3cac25d9cfd3b453f57becf14610746999d3c5dd"
> +SRC_URI[sha256sum] = "bbc94cf0a297f4560c64569ed72867c799287defdaf6e6572ce769f48dd2559b"
>   
>   DEPENDS = "lz4 libhtp"
>   
-- 
Regards,
Hitendra Prajapati
MontaVista Software LLC
Mo: +91 9998906483
--------------jT0hXWsRfjrhPD3q545rlzHR
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><font size="2">Hi Team,</font></p>
    <p><font size="2">Any update ?<br>
      </font></p>
    <div class="moz-cite-prefix">On 16/02/26 4:58 pm, Hitendra Prajapati
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20260216112838.17952-1-hprajapati@mvista.com">
      <pre class="moz-quote-pre" wrap="">Release notes:
<a class="moz-txt-link-freetext" href="https://suricata.io/2025/11/06/suricata-8-0-2-and-7-0-13-released/">https://suricata.io/2025/11/06/suricata-8-0-2-and-7-0-13-released/</a>

See suricata release notes for more details about changes and CVEs
fixed.

Signed-off-by: Hitendra Prajapati <a class="moz-txt-link-rfc2396E" href="mailto:hprajapati@mvista.com">&lt;hprajapati@mvista.com&gt;</a>
---
 recipes-ids/suricata/suricata-crates.inc      | 1437 +++++++++--------
 ...{suricata_7.0.12.bb =&gt; suricata_7.0.13.bb} |    2 +-
 2 files changed, 734 insertions(+), 705 deletions(-)
 rename recipes-ids/suricata/{suricata_7.0.12.bb =&gt; suricata_7.0.13.bb} (98%)

diff --git a/recipes-ids/suricata/suricata-crates.inc b/recipes-ids/suricata/suricata-crates.inc
index 0755302..9c65acf 100644
--- a/recipes-ids/suricata/suricata-crates.inc
+++ b/recipes-ids/suricata/suricata-crates.inc
@@ -1,547 +1,125 @@
 # Autogenerated with 'bitbake -c update_crates suricata'
 
 # from rust/Cargo.lock
-SRC_URI += "crate://crates.io/adler/1.0.2 \
-           crate://crates.io/aead/0.4.3 \
-           crate://crates.io/aes/0.7.5 \
-           crate://crates.io/aes-gcm/0.9.4 \
-           crate://crates.io/aho-corasick/0.7.20 \
-           crate://crates.io/alloc-no-stdlib/2.0.4 \
-           crate://crates.io/alloc-stdlib/0.2.2 \
-           crate://crates.io/asn1-rs/0.5.2 \
-           crate://crates.io/asn1-rs-derive/0.4.0 \
-           crate://crates.io/asn1-rs-impl/0.1.0 \
-           crate://crates.io/autocfg/1.1.0 \
-           crate://crates.io/base64/0.13.1 \
-           crate://crates.io/bendy/0.3.3 \
-           crate://crates.io/bitflags/1.2.1 \
-           crate://crates.io/block-buffer/0.10.4 \
-           crate://crates.io/brotli/8.0.1 \
-           crate://crates.io/brotli-decompressor/5.0.0 \
-           crate://crates.io/build_const/0.2.2 \
-           crate://crates.io/byteorder/1.4.3 \
-           crate://crates.io/cfg-if/1.0.0 \
-           crate://crates.io/cipher/0.3.0 \
-           crate://crates.io/cpufeatures/0.2.11 \
-           crate://crates.io/crc/1.8.1 \
-           crate://crates.io/crc32fast/1.3.2 \
-           crate://crates.io/crypto-common/0.1.6 \
-           crate://crates.io/ctr/0.8.0 \
-           crate://crates.io/data-encoding/2.4.0 \
-           crate://crates.io/der-oid-macro/0.5.0 \
-           crate://crates.io/der-parser/6.0.1 \
-           crate://crates.io/der-parser/8.2.0 \
-           crate://crates.io/digest/0.10.7 \
-           crate://crates.io/displaydoc/0.2.4 \
-           crate://crates.io/enum_primitive/0.1.1 \
-           crate://crates.io/failure/0.1.8 \
-           crate://crates.io/failure_derive/0.1.8 \
-           crate://crates.io/flate2/1.0.28 \
-           crate://crates.io/generic-array/0.14.7 \
-           crate://crates.io/getrandom/0.2.11 \
-           crate://crates.io/ghash/0.4.4 \
-           crate://crates.io/hex/0.4.3 \
-           crate://crates.io/hkdf/0.12.3 \
-           crate://crates.io/hmac/0.12.1 \
-           crate://crates.io/ipsec-parser/0.7.0 \
-           crate://crates.io/itoa/1.0.9 \
-           crate://crates.io/kerberos-parser/0.7.1 \
-           crate://crates.io/lazy_static/1.4.0 \
-           crate://crates.io/libc/0.2.150 \
-           crate://crates.io/lzma-rs/0.2.0 \
-           crate://crates.io/md-5/0.10.6 \
-           crate://crates.io/memchr/2.4.1 \
-           crate://crates.io/minimal-lexical/0.2.1 \
-           crate://crates.io/miniz_oxide/0.7.1 \
-           crate://crates.io/nom/7.1.3 \
-           crate://crates.io/nom-derive/0.10.1 \
-           crate://crates.io/nom-derive-impl/0.10.1 \
-           crate://crates.io/ntp-parser/0.6.0 \
-           crate://crates.io/num/0.2.1 \
-           crate://crates.io/num-bigint/0.2.6 \
-           crate://crates.io/num-bigint/0.4.4 \
-           crate://crates.io/num-complex/0.2.4 \
-           crate://crates.io/num-derive/0.4.2 \
-           crate://crates.io/num-integer/0.1.45 \
-           crate://crates.io/num-iter/0.1.43 \
-           crate://crates.io/num-rational/0.2.4 \
-           crate://crates.io/num-traits/0.1.43 \
-           crate://crates.io/num-traits/0.2.17 \
-           crate://crates.io/num_enum/0.5.11 \
-           crate://crates.io/num_enum_derive/0.5.11 \
-           crate://crates.io/num_threads/0.1.6 \
-           crate://crates.io/oid-registry/0.6.1 \
-           crate://crates.io/opaque-debug/0.3.0 \
-           crate://crates.io/phf/0.10.1 \
-           crate://crates.io/phf_codegen/0.10.0 \
-           crate://crates.io/phf_generator/0.10.0 \
-           crate://crates.io/phf_shared/0.10.0 \
-           crate://crates.io/polyval/0.5.3 \
-           crate://crates.io/ppv-lite86/0.2.17 \
-           crate://crates.io/proc-macro-crate/1.1.0 \
-           crate://crates.io/proc-macro2/1.0.69 \
-           crate://crates.io/quote/1.0.33 \
-           crate://crates.io/rand/0.8.5 \
-           crate://crates.io/rand_chacha/0.3.1 \
-           crate://crates.io/rand_core/0.6.4 \
-           crate://crates.io/regex/1.5.6 \
-           crate://crates.io/regex-syntax/0.6.29 \
-           crate://crates.io/rusticata-macros/4.1.0 \
-           crate://crates.io/rustversion/1.0.14 \
-           crate://crates.io/sawp/0.12.1 \
-           crate://crates.io/sawp-flags/0.12.1 \
-           crate://crates.io/sawp-flags-derive/0.12.1 \
-           crate://crates.io/sawp-modbus/0.12.1 \
-           crate://crates.io/serde/1.0.192 \
-           crate://crates.io/serde_derive/1.0.192 \
-           crate://crates.io/sha1/0.10.6 \
-           crate://crates.io/sha2/0.10.8 \
-           crate://crates.io/siphasher/0.3.11 \
-           crate://crates.io/snmp-parser/0.9.0 \
-           crate://crates.io/subtle/2.4.1 \
-           crate://crates.io/syn/1.0.109 \
-           crate://crates.io/syn/2.0.39 \
-           crate://crates.io/synstructure/0.12.6 \
-           crate://crates.io/test-case/1.1.0 \
-           crate://crates.io/thiserror/1.0.50 \
-           crate://crates.io/thiserror-impl/1.0.50 \
-           crate://crates.io/time/0.3.13 \
-           crate://crates.io/time-macros/0.2.4 \
-           crate://crates.io/tls-parser/0.11.0 \
-           crate://crates.io/toml/0.5.11 \
-           crate://crates.io/typenum/1.17.0 \
-           crate://crates.io/unicode-ident/1.0.12 \
-           crate://crates.io/unicode-xid/0.2.4 \
-           crate://crates.io/universal-hash/0.4.1 \
-           crate://crates.io/uuid/0.8.2 \
-           crate://crates.io/version_check/0.9.4 \
-           crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
-           crate://crates.io/widestring/0.4.3 \
-           crate://crates.io/x509-parser/0.15.1 \
-           crate://crates.io/ansi_term/0.12.1 \
-           crate://crates.io/atty/0.2.14 \
-           crate://crates.io/autocfg/0.1.8 \
-           crate://crates.io/autocfg/1.1.0 \
-           crate://crates.io/bitflags/1.3.2 \
-           crate://crates.io/bstr/0.2.17 \
-           crate://crates.io/bumpalo/3.11.1 \
-           crate://crates.io/cast/0.2.7 \
-           crate://crates.io/cast/0.3.0 \
-           crate://crates.io/cfg-if/1.0.0 \
-           crate://crates.io/clap/2.34.0 \
-           crate://crates.io/cloudabi/0.0.3 \
-           crate://crates.io/criterion/0.3.2 \
-           crate://crates.io/criterion-plot/0.4.5 \
-           crate://crates.io/crossbeam-channel/0.5.6 \
-           crate://crates.io/crossbeam-deque/0.8.2 \
-           crate://crates.io/crossbeam-epoch/0.9.11 \
-           crate://crates.io/crossbeam-utils/0.8.12 \
-           crate://crates.io/csv/1.1.6 \
-           crate://crates.io/csv-core/0.1.10 \
-           crate://crates.io/either/1.8.0 \
-           crate://crates.io/fuchsia-cprng/0.1.1 \
-           crate://crates.io/heck/0.3.3 \
-           crate://crates.io/hermit-abi/0.1.19 \
-           crate://crates.io/itertools/0.9.0 \
-           crate://crates.io/itertools/0.10.5 \
-           crate://crates.io/itoa/0.4.8 \
-           crate://crates.io/itoa/1.0.4 \
-           crate://crates.io/js-sys/0.3.60 \
-           crate://crates.io/lazy_static/1.4.0 \
-           crate://crates.io/libc/0.2.135 \
-           crate://crates.io/log/0.4.17 \
-           crate://crates.io/memchr/2.5.0 \
-           crate://crates.io/memoffset/0.6.5 \
-           crate://crates.io/num-traits/0.2.15 \
-           crate://crates.io/num_cpus/1.13.1 \
-           crate://crates.io/once_cell/1.15.0 \
-           crate://crates.io/oorandom/11.1.3 \
-           crate://crates.io/plotters/0.2.15 \
-           crate://crates.io/proc-macro-error/1.0.4 \
-           crate://crates.io/proc-macro-error-attr/1.0.4 \
-           crate://crates.io/proc-macro2/1.0.47 \
-           crate://crates.io/quote/1.0.21 \
-           crate://crates.io/rand/0.6.5 \
-           crate://crates.io/rand_chacha/0.1.1 \
-           crate://crates.io/rand_core/0.3.1 \
-           crate://crates.io/rand_core/0.4.2 \
-           crate://crates.io/rand_hc/0.1.0 \
-           crate://crates.io/rand_isaac/0.1.1 \
-           crate://crates.io/rand_jitter/0.1.4 \
-           crate://crates.io/rand_os/0.1.3 \
-           crate://crates.io/rand_pcg/0.1.2 \
-           crate://crates.io/rand_xorshift/0.1.1 \
-           crate://crates.io/rayon/1.5.3 \
-           crate://crates.io/rayon-core/1.9.3 \
-           crate://crates.io/rdrand/0.4.0 \
-           crate://crates.io/regex/1.6.0 \
-           crate://crates.io/regex-automata/0.1.10 \
-           crate://crates.io/regex-syntax/0.6.27 \
-           crate://crates.io/rustc_version/0.4.0 \
-           crate://crates.io/ryu/1.0.11 \
-           crate://crates.io/same-file/1.0.6 \
-           crate://crates.io/scopeguard/1.1.0 \
-           crate://crates.io/semver/1.0.14 \
-           crate://crates.io/serde/1.0.146 \
-           crate://crates.io/serde_derive/1.0.146 \
-           crate://crates.io/serde_json/1.0.87 \
-           crate://crates.io/strsim/0.8.0 \
-           crate://crates.io/structopt/0.3.26 \
-           crate://crates.io/structopt-derive/0.4.18 \
-           crate://crates.io/syn/1.0.103 \
-           crate://crates.io/textwrap/0.11.0 \
-           crate://crates.io/tinytemplate/1.2.1 \
-           crate://crates.io/unicode-ident/1.0.5 \
-           crate://crates.io/unicode-segmentation/1.10.0 \
-           crate://crates.io/unicode-width/0.1.10 \
-           crate://crates.io/vec_map/0.8.2 \
-           crate://crates.io/version_check/0.9.4 \
-           crate://crates.io/walkdir/2.3.2 \
-           crate://crates.io/wasm-bindgen/0.2.83 \
-           crate://crates.io/wasm-bindgen-backend/0.2.83 \
-           crate://crates.io/wasm-bindgen-macro/0.2.83 \
-           crate://crates.io/wasm-bindgen-macro-support/0.2.83 \
-           crate://crates.io/wasm-bindgen-shared/0.2.83 \
-           crate://crates.io/web-sys/0.3.60 \
-           crate://crates.io/winapi/0.3.9 \
-           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-           crate://crates.io/winapi-util/0.1.5 \
-           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
-           crate://crates.io/backtrace/0.3.46 \
-           crate://crates.io/backtrace-sys/0.1.37 \
-           crate://crates.io/cc/1.0.52 \
-           crate://crates.io/cfg-if/0.1.10 \
-           crate://crates.io/failure_derive/0.1.7 \
-           crate://crates.io/libc/0.2.69 \
-           crate://crates.io/proc-macro2/1.0.12 \
-           crate://crates.io/quote/1.0.4 \
-           crate://crates.io/rustc-demangle/0.1.16 \
-           crate://crates.io/syn/1.0.18 \
-           crate://crates.io/synstructure/0.12.3 \
-           crate://crates.io/unicode-xid/0.2.0 \
-           crate://crates.io/autocfg/1.1.0 \
-           crate://crates.io/hashbrown/0.12.3 \
-           crate://crates.io/indexmap/1.9.2 \
-           crate://crates.io/itoa/1.0.5 \
-           crate://crates.io/proc-macro2/1.0.50 \
-           crate://crates.io/quote/1.0.23 \
-           crate://crates.io/ryu/1.0.12 \
-           crate://crates.io/serde/1.0.152 \
-           crate://crates.io/serde_derive/1.0.152 \
-           crate://crates.io/serde_json/1.0.91 \
-           crate://crates.io/syn/1.0.107 \
-           crate://crates.io/unicode-ident/1.0.6 \
-           crate://crates.io/autocfg/1.0.1 \
-           crate://crates.io/bit-set/0.5.2 \
-           crate://crates.io/bit-vec/0.6.3 \
-           crate://crates.io/bitflags/1.3.2 \
-           crate://crates.io/byteorder/1.4.3 \
-           crate://crates.io/cfg-if/1.0.0 \
-           crate://crates.io/doc-comment/0.3.3 \
-           crate://crates.io/fnv/1.0.7 \
-           crate://crates.io/getrandom/0.2.3 \
-           crate://crates.io/lazy_static/1.4.0 \
-           crate://crates.io/libc/0.2.106 \
-           crate://crates.io/memchr/2.4.1 \
-           crate://crates.io/minimal-lexical/0.2.1 \
-           crate://crates.io/num-traits/0.2.14 \
-           crate://crates.io/ppv-lite86/0.2.15 \
-           crate://crates.io/proptest/1.0.0 \
-           crate://crates.io/quick-error/1.2.3 \
-           crate://crates.io/quick-error/2.0.1 \
-           crate://crates.io/rand/0.8.4 \
-           crate://crates.io/rand_chacha/0.3.1 \
-           crate://crates.io/rand_core/0.6.3 \
-           crate://crates.io/rand_hc/0.3.1 \
-           crate://crates.io/rand_xorshift/0.3.0 \
-           crate://crates.io/redox_syscall/0.2.10 \
-           crate://crates.io/regex-syntax/0.6.25 \
-           crate://crates.io/remove_dir_all/0.5.3 \
-           crate://crates.io/rusty-fork/0.3.0 \
-           crate://crates.io/tempfile/3.2.0 \
-           crate://crates.io/wait-timeout/0.2.0 \
-           crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
-           crate://crates.io/winapi/0.3.9 \
-           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
-           crate://crates.io/alloc-no-stdlib/2.0.4 \
-           crate://crates.io/alloc-stdlib/0.2.2 \
-           crate://crates.io/ansi_term/0.11.0 \
-           crate://crates.io/basic-toml/0.1.2 \
-           crate://crates.io/ctor/0.1.26 \
-           crate://crates.io/difference/2.0.0 \
-           crate://crates.io/glob/0.3.1 \
-           crate://crates.io/itoa/1.0.6 \
-           crate://crates.io/libc/0.2.142 \
-           crate://crates.io/once_cell/1.17.1 \
-           crate://crates.io/output_vt100/0.1.3 \
-           crate://crates.io/pretty_assertions/0.6.1 \
-           crate://crates.io/proc-macro2/1.0.56 \
-           crate://crates.io/quote/1.0.26 \
-           crate://crates.io/rustversion/1.0.12 \
-           crate://crates.io/ryu/1.0.13 \
-           crate://crates.io/serde/1.0.160 \
-           crate://crates.io/serde_derive/1.0.160 \
-           crate://crates.io/serde_json/1.0.96 \
-           crate://crates.io/static_assertions/1.1.0 \
-           crate://crates.io/syn/1.0.109 \
-           crate://crates.io/syn/2.0.15 \
-           crate://crates.io/termcolor/1.2.0 \
-           crate://crates.io/thiserror/1.0.40 \
-           crate://crates.io/thiserror-impl/1.0.40 \
-           crate://crates.io/trybuild/1.0.80 \
-           crate://crates.io/unicode-ident/1.0.8 \
-           crate://crates.io/winapi/0.3.9 \
-           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-           crate://crates.io/winapi-util/0.1.5 \
-           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
-           crate://crates.io/asn1-rs/0.5.1 \
-           crate://crates.io/asn1-rs-derive/0.4.0 \
-           crate://crates.io/asn1-rs-impl/0.1.0 \
-           crate://crates.io/atty/0.2.14 \
-           crate://crates.io/autocfg/1.1.0 \
-           crate://crates.io/base64/0.13.1 \
-           crate://crates.io/basic-toml/0.1.2 \
-           crate://crates.io/bitvec/1.0.1 \
-           crate://crates.io/colored/2.0.0 \
-           crate://crates.io/cookie-factory/0.3.2 \
-           crate://crates.io/displaydoc/0.2.3 \
-           crate://crates.io/funty/2.0.0 \
-           crate://crates.io/glob/0.3.1 \
-           crate://crates.io/hermit-abi/0.1.19 \
-           crate://crates.io/hex-literal/0.3.4 \
-           crate://crates.io/itoa/1.0.6 \
-           crate://crates.io/lazy_static/1.4.0 \
-           crate://crates.io/libc/0.2.139 \
-           crate://crates.io/memchr/2.5.0 \
-           crate://crates.io/minimal-lexical/0.2.1 \
-           crate://crates.io/nom/7.1.3 \
-           crate://crates.io/num-bigint/0.4.3 \
-           crate://crates.io/num-integer/0.1.45 \
-           crate://crates.io/num-traits/0.2.15 \
-           crate://crates.io/oid-registry/0.6.1 \
-           crate://crates.io/once_cell/1.17.1 \
-           crate://crates.io/pem/1.1.1 \
-           crate://crates.io/proc-macro2/1.0.51 \
-           crate://crates.io/quote/1.0.23 \
-           crate://crates.io/radium/0.7.0 \
-           crate://crates.io/rusticata-macros/4.1.0 \
-           crate://crates.io/ryu/1.0.13 \
-           crate://crates.io/serde/1.0.152 \
-           crate://crates.io/serde_derive/1.0.152 \
-           crate://crates.io/serde_json/1.0.94 \
-           crate://crates.io/syn/1.0.109 \
-           crate://crates.io/synstructure/0.12.6 \
-           crate://crates.io/tap/1.0.1 \
-           crate://crates.io/termcolor/1.2.0 \
-           crate://crates.io/thiserror/1.0.39 \
-           crate://crates.io/thiserror-impl/1.0.39 \
-           crate://crates.io/time/0.3.20 \
-           crate://crates.io/time-core/0.1.0 \
-           crate://crates.io/time-macros/0.2.8 \
-           crate://crates.io/trybuild/1.0.79 \
-           crate://crates.io/unicode-ident/1.0.8 \
-           crate://crates.io/unicode-xid/0.2.4 \
-           crate://crates.io/winapi/0.3.9 \
-           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-           crate://crates.io/winapi-util/0.1.5 \
-           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
-           crate://crates.io/wyz/0.5.1 \
-           crate://crates.io/alloc-no-stdlib/2.0.4 \
-           crate://crates.io/alloc-stdlib/0.2.2 \
-           crate://crates.io/block-buffer/0.10.4 \
-           crate://crates.io/brotli-decompressor/5.0.0 \
-           crate://crates.io/cfg-if/1.0.0 \
-           crate://crates.io/cpufeatures/0.2.17 \
-           crate://crates.io/crypto-common/0.1.6 \
-           crate://crates.io/digest/0.10.7 \
-           crate://crates.io/generic-array/0.14.7 \
-           crate://crates.io/libc/0.2.172 \
-           crate://crates.io/sha2/0.10.9 \
-           crate://crates.io/typenum/1.18.0 \
-           crate://crates.io/version_check/0.9.5 \
-           crate://crates.io/atty/0.2.14 \
-           crate://crates.io/autocfg/1.0.1 \
-           crate://crates.io/bitflags/1.2.1 \
-           crate://crates.io/bstr/0.2.16 \
-           crate://crates.io/bumpalo/3.7.0 \
-           crate://crates.io/cast/0.2.7 \
-           crate://crates.io/cfg-if/1.0.0 \
-           crate://crates.io/clap/2.33.3 \
-           crate://crates.io/criterion/0.3.4 \
-           crate://crates.io/criterion-plot/0.4.4 \
-           crate://crates.io/crossbeam-channel/0.5.1 \
-           crate://crates.io/crossbeam-deque/0.8.1 \
-           crate://crates.io/crossbeam-epoch/0.9.5 \
-           crate://crates.io/crossbeam-utils/0.8.5 \
-           crate://crates.io/csv/1.1.6 \
-           crate://crates.io/csv-core/0.1.10 \
-           crate://crates.io/either/1.6.1 \
-           crate://crates.io/getrandom/0.2.3 \
-           crate://crates.io/half/1.7.1 \
-           crate://crates.io/hermit-abi/0.1.19 \
-           crate://crates.io/itertools/0.10.1 \
-           crate://crates.io/itoa/0.4.7 \
-           crate://crates.io/js-sys/0.3.52 \
-           crate://crates.io/lazy_static/1.4.0 \
-           crate://crates.io/libc/0.2.99 \
-           crate://crates.io/log/0.4.14 \
-           crate://crates.io/memchr/2.4.0 \
-           crate://crates.io/memoffset/0.6.4 \
-           crate://crates.io/num-traits/0.2.14 \
-           crate://crates.io/num_cpus/1.13.0 \
-           crate://crates.io/oorandom/11.1.3 \
-           crate://crates.io/phf_shared/0.10.0 \
-           crate://crates.io/plotters/0.3.1 \
-           crate://crates.io/plotters-backend/0.3.2 \
-           crate://crates.io/plotters-svg/0.3.1 \
-           crate://crates.io/ppv-lite86/0.2.10 \
-           crate://crates.io/proc-macro2/1.0.28 \
-           crate://crates.io/quote/1.0.9 \
-           crate://crates.io/rand/0.8.4 \
-           crate://crates.io/rand_chacha/0.3.1 \
-           crate://crates.io/rand_core/0.6.3 \
-           crate://crates.io/rand_hc/0.3.1 \
-           crate://crates.io/rayon/1.5.1 \
-           crate://crates.io/rayon-core/1.9.1 \
-           crate://crates.io/regex/1.5.4 \
-           crate://crates.io/regex-automata/0.1.10 \
-           crate://crates.io/regex-syntax/0.6.25 \
-           crate://crates.io/rustc_version/0.4.0 \
-           crate://crates.io/ryu/1.0.5 \
-           crate://crates.io/same-file/1.0.6 \
-           crate://crates.io/scopeguard/1.1.0 \
-           crate://crates.io/semver/1.0.4 \
-           crate://crates.io/serde/1.0.127 \
-           crate://crates.io/serde_cbor/0.11.1 \
-           crate://crates.io/serde_derive/1.0.127 \
-           crate://crates.io/serde_json/1.0.66 \
-           crate://crates.io/siphasher/0.3.6 \
-           crate://crates.io/syn/1.0.74 \
-           crate://crates.io/textwrap/0.11.0 \
-           crate://crates.io/tinytemplate/1.2.1 \
-           crate://crates.io/unicode-width/0.1.8 \
-           crate://crates.io/unicode-xid/0.2.2 \
-           crate://crates.io/walkdir/2.3.2 \
-           crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
-           crate://crates.io/wasm-bindgen/0.2.75 \
-           crate://crates.io/wasm-bindgen-backend/0.2.75 \
-           crate://crates.io/wasm-bindgen-macro/0.2.75 \
-           crate://crates.io/wasm-bindgen-macro-support/0.2.75 \
-           crate://crates.io/wasm-bindgen-shared/0.2.75 \
-           crate://crates.io/web-sys/0.3.52 \
-           crate://crates.io/winapi/0.3.9 \
-           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-           crate://crates.io/winapi-util/0.1.5 \
-           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
-           crate://crates.io/alloc-no-stdlib/2.0.4 \
-           crate://crates.io/asn1-rs/0.5.2 \
-           crate://crates.io/asn1-rs-derive/0.4.0 \
-           crate://crates.io/asn1-rs-impl/0.1.0 \
-           crate://crates.io/autocfg/1.1.0 \
-           crate://crates.io/bumpalo/3.13.0 \
-           crate://crates.io/cc/1.0.81 \
-           crate://crates.io/cfg-if/1.0.0 \
-           crate://crates.io/data-encoding/2.4.0 \
-           crate://crates.io/der-parser/8.2.0 \
-           crate://crates.io/deranged/0.3.7 \
-           crate://crates.io/displaydoc/0.2.4 \
-           crate://crates.io/itoa/1.0.9 \
-           crate://crates.io/js-sys/0.3.64 \
-           crate://crates.io/lazy_static/1.4.0 \
-           crate://crates.io/libc/0.2.147 \
-           crate://crates.io/log/0.4.19 \
-           crate://crates.io/memchr/2.5.0 \
-           crate://crates.io/minimal-lexical/0.2.1 \
-           crate://crates.io/nom/7.1.3 \
-           crate://crates.io/num-bigint/0.4.3 \
-           crate://crates.io/num-integer/0.1.45 \
-           crate://crates.io/num-traits/0.2.16 \
-           crate://crates.io/oid-registry/0.6.1 \
-           crate://crates.io/once_cell/1.18.0 \
-           crate://crates.io/proc-macro2/1.0.66 \
-           crate://crates.io/quote/1.0.32 \
-           crate://crates.io/ring/0.16.20 \
-           crate://crates.io/rusticata-macros/4.1.0 \
-           crate://crates.io/serde/1.0.180 \
-           crate://crates.io/spin/0.5.2 \
-           crate://crates.io/syn/1.0.109 \
-           crate://crates.io/syn/2.0.28 \
-           crate://crates.io/synstructure/0.12.6 \
-           crate://crates.io/thiserror/1.0.44 \
-           crate://crates.io/thiserror-impl/1.0.44 \
-           crate://crates.io/time/0.3.25 \
-           crate://crates.io/time-core/0.1.1 \
-           crate://crates.io/time-macros/0.2.11 \
-           crate://crates.io/unicode-ident/1.0.11 \
-           crate://crates.io/unicode-xid/0.2.4 \
-           crate://crates.io/untrusted/0.7.1 \
-           crate://crates.io/wasm-bindgen/0.2.87 \
-           crate://crates.io/wasm-bindgen-backend/0.2.87 \
-           crate://crates.io/wasm-bindgen-macro/0.2.87 \
-           crate://crates.io/wasm-bindgen-macro-support/0.2.87 \
-           crate://crates.io/wasm-bindgen-shared/0.2.87 \
-           crate://crates.io/web-sys/0.3.64 \
-           crate://crates.io/winapi/0.3.9 \
-           crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
-           crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
-           crate://crates.io/aho-corasick/0.7.18 \
-           crate://crates.io/cfg-if/1.0.0 \
-           crate://crates.io/getrandom/0.2.6 \
-           crate://crates.io/lazy_static/1.4.0 \
-           crate://crates.io/libc/0.2.125 \
-           crate://crates.io/memchr/2.5.0 \
-           crate://crates.io/quickcheck/1.0.3 \
-           crate://crates.io/rand/0.8.5 \
-           crate://crates.io/rand_core/0.6.3 \
-           crate://crates.io/regex-syntax/0.6.26 \
-           crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
-           crate://crates.io/addr2line/0.14.0 \
-           crate://crates.io/adler/0.2.3 \
-           crate://crates.io/aho-corasick/0.7.15 \
-           crate://crates.io/autocfg/1.0.1 \
-           crate://crates.io/backtrace/0.3.54 \
-           crate://crates.io/cfg-if/1.0.0 \
-           crate://crates.io/failure/0.1.8 \
-           crate://crates.io/failure_derive/0.1.8 \
-           crate://crates.io/gimli/0.23.0 \
-           crate://crates.io/lazy_static/1.4.0 \
-           crate://crates.io/libc/0.2.80 \
-           crate://crates.io/memchr/2.3.4 \
-           crate://crates.io/miniz_oxide/0.4.3 \
-           crate://crates.io/object/0.22.0 \
-           crate://crates.io/proc-macro2/1.0.24 \
-           crate://crates.io/quote/1.0.7 \
-           crate://crates.io/regex/1.4.2 \
-           crate://crates.io/regex-syntax/0.6.21 \
-           crate://crates.io/rustc-demangle/0.1.18 \
-           crate://crates.io/serde/1.0.117 \
-           crate://crates.io/serde_bytes/0.11.5 \
-           crate://crates.io/serde_derive/1.0.117 \
-           crate://crates.io/syn/1.0.48 \
-           crate://crates.io/synstructure/0.12.4 \
-           crate://crates.io/thread_local/1.0.1 \
-           crate://crates.io/unicode-xid/0.2.1 \
-           crate://crates.io/adler/1.0.2 \
-           crate://crates.io/cc/1.0.79 \
-           crate://crates.io/cfg-if/1.0.0 \
-           crate://crates.io/cloudflare-zlib-sys/0.3.0 \
-           crate://crates.io/cmake/0.1.50 \
-           crate://crates.io/crc32fast/1.3.2 \
-           crate://crates.io/getrandom/0.2.9 \
-           crate://crates.io/libc/0.2.144 \
-           crate://crates.io/libz-ng-sys/1.1.10 \
-           crate://crates.io/libz-sys/1.1.10 \
-           crate://crates.io/miniz_oxide/0.7.1 \
-           crate://crates.io/pkg-config/0.3.27 \
-           crate://crates.io/ppv-lite86/0.2.17 \
-           crate://crates.io/quickcheck/1.0.3 \
-           crate://crates.io/rand/0.8.5 \
-           crate://crates.io/rand_chacha/0.3.1 \
-           crate://crates.io/rand_core/0.6.4 \
-           crate://crates.io/vcpkg/0.2.15 \
-           crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
-           "
+SRC_URI += " \
+    crate://crates.io/adler/1.0.2 \
+    crate://crates.io/aead/0.4.3 \
+    crate://crates.io/aes/0.7.5 \
+    crate://crates.io/aes-gcm/0.9.4 \
+    crate://crates.io/aho-corasick/0.7.20 \
+    crate://crates.io/alloc-no-stdlib/2.0.4 \
+    crate://crates.io/alloc-stdlib/0.2.2 \
+    crate://crates.io/asn1-rs/0.5.2 \
+    crate://crates.io/asn1-rs-derive/0.4.0 \
+    crate://crates.io/asn1-rs-impl/0.1.0 \
+    crate://crates.io/autocfg/1.1.0 \
+    crate://crates.io/base64/0.13.1 \
+    crate://crates.io/bendy/0.3.3 \
+    crate://crates.io/bitflags/1.2.1 \
+    crate://crates.io/block-buffer/0.10.4 \
+    crate://crates.io/brotli/8.0.1 \
+    crate://crates.io/brotli-decompressor/5.0.0 \
+    crate://crates.io/build_const/0.2.2 \
+    crate://crates.io/byteorder/1.4.3 \
+    crate://crates.io/cfg-if/1.0.0 \
+    crate://crates.io/cipher/0.3.0 \
+    crate://crates.io/cpufeatures/0.2.11 \
+    crate://crates.io/crc/1.8.1 \
+    crate://crates.io/crc32fast/1.3.2 \
+    crate://crates.io/crypto-common/0.1.6 \
+    crate://crates.io/ctr/0.8.0 \
+    crate://crates.io/data-encoding/2.4.0 \
+    crate://crates.io/der-oid-macro/0.5.0 \
+    crate://crates.io/der-parser/6.0.1 \
+    crate://crates.io/der-parser/8.2.0 \
+    crate://crates.io/digest/0.10.7 \
+    crate://crates.io/displaydoc/0.2.4 \
+    crate://crates.io/enum_primitive/0.1.1 \
+    crate://crates.io/failure/0.1.8 \
+    crate://crates.io/failure_derive/0.1.8 \
+    crate://crates.io/flate2/1.0.28 \
+    crate://crates.io/generic-array/0.14.7 \
+    crate://crates.io/getrandom/0.2.11 \
+    crate://crates.io/ghash/0.4.4 \
+    crate://crates.io/hex/0.4.3 \
+    crate://crates.io/hkdf/0.12.3 \
+    crate://crates.io/hmac/0.12.1 \
+    crate://crates.io/ipsec-parser/0.7.0 \
+    crate://crates.io/itoa/1.0.9 \
+    crate://crates.io/kerberos-parser/0.7.1 \
+    crate://crates.io/lazy_static/1.4.0 \
+    crate://crates.io/libc/0.2.150 \
+    crate://crates.io/lzma-rs/0.2.0 \
+    crate://crates.io/md-5/0.10.6 \
+    crate://crates.io/memchr/2.4.1 \
+    crate://crates.io/minimal-lexical/0.2.1 \
+    crate://crates.io/miniz_oxide/0.7.1 \
+    crate://crates.io/nom/7.1.3 \
+    crate://crates.io/nom-derive/0.10.1 \
+    crate://crates.io/nom-derive-impl/0.10.1 \
+    crate://crates.io/ntp-parser/0.6.0 \
+    crate://crates.io/num/0.2.1 \
+    crate://crates.io/num-bigint/0.2.6 \
+    crate://crates.io/num-bigint/0.4.4 \
+    crate://crates.io/num-complex/0.2.4 \
+    crate://crates.io/num-derive/0.4.2 \
+    crate://crates.io/num-integer/0.1.45 \
+    crate://crates.io/num-iter/0.1.43 \
+    crate://crates.io/num-rational/0.2.4 \
+    crate://crates.io/num-traits/0.1.43 \
+    crate://crates.io/num-traits/0.2.17 \
+    crate://crates.io/num_enum/0.5.11 \
+    crate://crates.io/num_enum_derive/0.5.11 \
+    crate://crates.io/num_threads/0.1.6 \
+    crate://crates.io/oid-registry/0.6.1 \
+    crate://crates.io/opaque-debug/0.3.0 \
+    crate://crates.io/phf/0.10.1 \
+    crate://crates.io/phf_codegen/0.10.0 \
+    crate://crates.io/phf_generator/0.10.0 \
+    crate://crates.io/phf_shared/0.10.0 \
+    crate://crates.io/polyval/0.5.3 \
+    crate://crates.io/ppv-lite86/0.2.17 \
+    crate://crates.io/proc-macro-crate/1.1.0 \
+    crate://crates.io/proc-macro2/1.0.69 \
+    crate://crates.io/quote/1.0.33 \
+    crate://crates.io/rand/0.8.5 \
+    crate://crates.io/rand_chacha/0.3.1 \
+    crate://crates.io/rand_core/0.6.4 \
+    crate://crates.io/regex/1.5.6 \
+    crate://crates.io/regex-syntax/0.6.29 \
+    crate://crates.io/rusticata-macros/4.1.0 \
+    crate://crates.io/rustversion/1.0.14 \
+    crate://crates.io/sawp/0.12.1 \
+    crate://crates.io/sawp-flags/0.12.1 \
+    crate://crates.io/sawp-flags-derive/0.12.1 \
+    crate://crates.io/sawp-modbus/0.12.1 \
+    crate://crates.io/serde/1.0.192 \
+    crate://crates.io/serde_derive/1.0.192 \
+    crate://crates.io/sha1/0.10.6 \
+    crate://crates.io/sha2/0.10.8 \
+    crate://crates.io/siphasher/0.3.11 \
+    crate://crates.io/snmp-parser/0.9.0 \
+    crate://crates.io/subtle/2.4.1 \
+    crate://crates.io/syn/1.0.109 \
+    crate://crates.io/syn/2.0.39 \
+    crate://crates.io/synstructure/0.12.6 \
+    crate://crates.io/test-case/1.1.0 \
+    crate://crates.io/thiserror/1.0.50 \
+    crate://crates.io/thiserror-impl/1.0.50 \
+    crate://crates.io/time/0.3.13 \
+    crate://crates.io/time-macros/0.2.4 \
+    crate://crates.io/tls-parser/0.11.0 \
+    crate://crates.io/toml/0.5.11 \
+    crate://crates.io/typenum/1.17.0 \
+    crate://crates.io/unicode-ident/1.0.12 \
+    crate://crates.io/unicode-xid/0.2.4 \
+    crate://crates.io/universal-hash/0.4.1 \
+    crate://crates.io/uuid/0.8.2 \
+    crate://crates.io/version_check/0.9.4 \
+    crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
+    crate://crates.io/widestring/0.4.3 \
+    crate://crates.io/x509-parser/0.15.1 \
+"
 
 SRC_URI[adler-1.0.2.sha256sum] = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
 SRC_URI[aead-0.4.3.sha256sum] = "0b613b8e1e3cf911a086f53f03bf286f52fd7a7258e4fa606f0ef220d39d8877<a class="moz-txt-link-rfc2396E" href="mailto:@@-661,6+239,97@@SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum]=">"
@@ -661,6 +239,97 @@ SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "</a>9c8d87e72b64a3b4db28d11
 SRC_URI[widestring-0.4.3.sha256sum] = "c168940144dd21fd8046987c16a46a33d5fc84eec29ef9dcddc2ac9e31526b7c"
 SRC_URI[x509-parser-0.15.1.sha256sum] = "7069fba5b66b9193bd2c5d3d4ff12b839118f6bcbef5328efafafb5395cf63da"
 # from rust/vendor/base64/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/ansi_term/0.12.1 \
+    crate://crates.io/atty/0.2.14 \
+    crate://crates.io/autocfg/0.1.8 \
+    crate://crates.io/autocfg/1.1.0 \
+    crate://crates.io/bitflags/1.3.2 \
+    crate://crates.io/bstr/0.2.17 \
+    crate://crates.io/bumpalo/3.11.1 \
+    crate://crates.io/cast/0.2.7 \
+    crate://crates.io/cast/0.3.0 \
+    crate://crates.io/cfg-if/1.0.0 \
+    crate://crates.io/clap/2.34.0 \
+    crate://crates.io/cloudabi/0.0.3 \
+    crate://crates.io/criterion/0.3.2 \
+    crate://crates.io/criterion-plot/0.4.5 \
+    crate://crates.io/crossbeam-channel/0.5.6 \
+    crate://crates.io/crossbeam-deque/0.8.2 \
+    crate://crates.io/crossbeam-epoch/0.9.11 \
+    crate://crates.io/crossbeam-utils/0.8.12 \
+    crate://crates.io/csv/1.1.6 \
+    crate://crates.io/csv-core/0.1.10 \
+    crate://crates.io/either/1.8.0 \
+    crate://crates.io/fuchsia-cprng/0.1.1 \
+    crate://crates.io/heck/0.3.3 \
+    crate://crates.io/hermit-abi/0.1.19 \
+    crate://crates.io/itertools/0.9.0 \
+    crate://crates.io/itertools/0.10.5 \
+    crate://crates.io/itoa/0.4.8 \
+    crate://crates.io/itoa/1.0.4 \
+    crate://crates.io/js-sys/0.3.60 \
+    crate://crates.io/lazy_static/1.4.0 \
+    crate://crates.io/libc/0.2.135 \
+    crate://crates.io/log/0.4.17 \
+    crate://crates.io/memchr/2.5.0 \
+    crate://crates.io/memoffset/0.6.5 \
+    crate://crates.io/num-traits/0.2.15 \
+    crate://crates.io/num_cpus/1.13.1 \
+    crate://crates.io/once_cell/1.15.0 \
+    crate://crates.io/oorandom/11.1.3 \
+    crate://crates.io/plotters/0.2.15 \
+    crate://crates.io/proc-macro-error/1.0.4 \
+    crate://crates.io/proc-macro-error-attr/1.0.4 \
+    crate://crates.io/proc-macro2/1.0.47 \
+    crate://crates.io/quote/1.0.21 \
+    crate://crates.io/rand/0.6.5 \
+    crate://crates.io/rand_chacha/0.1.1 \
+    crate://crates.io/rand_core/0.3.1 \
+    crate://crates.io/rand_core/0.4.2 \
+    crate://crates.io/rand_hc/0.1.0 \
+    crate://crates.io/rand_isaac/0.1.1 \
+    crate://crates.io/rand_jitter/0.1.4 \
+    crate://crates.io/rand_os/0.1.3 \
+    crate://crates.io/rand_pcg/0.1.2 \
+    crate://crates.io/rand_xorshift/0.1.1 \
+    crate://crates.io/rayon/1.5.3 \
+    crate://crates.io/rayon-core/1.9.3 \
+    crate://crates.io/rdrand/0.4.0 \
+    crate://crates.io/regex/1.6.0 \
+    crate://crates.io/regex-automata/0.1.10 \
+    crate://crates.io/regex-syntax/0.6.27 \
+    crate://crates.io/rustc_version/0.4.0 \
+    crate://crates.io/ryu/1.0.11 \
+    crate://crates.io/same-file/1.0.6 \
+    crate://crates.io/scopeguard/1.1.0 \
+    crate://crates.io/semver/1.0.14 \
+    crate://crates.io/serde/1.0.146 \
+    crate://crates.io/serde_derive/1.0.146 \
+    crate://crates.io/serde_json/1.0.87 \
+    crate://crates.io/strsim/0.8.0 \
+    crate://crates.io/structopt/0.3.26 \
+    crate://crates.io/structopt-derive/0.4.18 \
+    crate://crates.io/syn/1.0.103 \
+    crate://crates.io/textwrap/0.11.0 \
+    crate://crates.io/tinytemplate/1.2.1 \
+    crate://crates.io/unicode-ident/1.0.5 \
+    crate://crates.io/unicode-segmentation/1.10.0 \
+    crate://crates.io/unicode-width/0.1.10 \
+    crate://crates.io/vec_map/0.8.2 \
+    crate://crates.io/version_check/0.9.4 \
+    crate://crates.io/walkdir/2.3.2 \
+    crate://crates.io/wasm-bindgen/0.2.83 \
+    crate://crates.io/wasm-bindgen-backend/0.2.83 \
+    crate://crates.io/wasm-bindgen-macro/0.2.83 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.83 \
+    crate://crates.io/wasm-bindgen-shared/0.2.83 \
+    crate://crates.io/web-sys/0.3.60 \
+    crate://crates.io/winapi/0.3.9 \
+    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
+    crate://crates.io/winapi-util/0.1.5 \
+    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+"
 
 SRC_URI[ansi_term-0.12.1.sha256sum] = "d52a9bb7ec0cf484c551830a7ce27bd20d67eac647e1befb56b0be4ee39a55d2"
 SRC_URI[atty-0.2.14.sha256sum] = "d9b39be18770d11421cdb1b9947a45dd3f37e93092cbf377614828a319d5fee8<a class="moz-txt-link-rfc2396E" href="mailto:@@-751,7+420,29@@SRC_URI[winapi-0.3.9.sha256sum]=">"
@@ -751,7 +420,29 @@ SRC_URI[winapi-0.3.9.sha256sum] = "</a>5c839a674fcd7a98952e593242ea400abe93992746761
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
 SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
+# from rust/vendor/brotli-decompressor/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/alloc-no-stdlib/2.0.4 \
+    crate://crates.io/alloc-stdlib/0.2.2 \
+"
+
+SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
+SRC_URI[alloc-stdlib-0.2.2.sha256sum] = "94fb8275041c72129eb51b7d0322c29b8387a0386127718b096429201a5d6ece"
 # from rust/vendor/failure/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/backtrace/0.3.46 \
+    crate://crates.io/backtrace-sys/0.1.37 \
+    crate://crates.io/cc/1.0.52 \
+    crate://crates.io/cfg-if/0.1.10 \
+    crate://crates.io/failure_derive/0.1.7 \
+    crate://crates.io/libc/0.2.69 \
+    crate://crates.io/proc-macro2/1.0.12 \
+    crate://crates.io/quote/1.0.4 \
+    crate://crates.io/rustc-demangle/0.1.16 \
+    crate://crates.io/syn/1.0.18 \
+    crate://crates.io/synstructure/0.12.3 \
+    crate://crates.io/unicode-xid/0.2.0 \
+"
 
 SRC_URI[backtrace-0.3.46.sha256sum] = "b1e692897359247cc6bb902933361652380af0f1b7651ae5c5013407f30e109e"
 SRC_URI[backtrace-sys-0.1.37.sha256sum] = "18fbebbe1c9d1f383a9cc7e8ccdb471b91c8d024ee9c2ca5b5346121fe8b4399<a class="moz-txt-link-rfc2396E" href="mailto:@@-765,21+456,104@@SRC_URI[rustc-demangle-0.1.16.sha256sum]=">"
@@ -765,21 +456,104 @@ SRC_URI[rustc-demangle-0.1.16.sha256sum] = "</a>4c691c0e608126e00913e33f0ccf3727d5fc
 SRC_URI[syn-1.0.18.sha256sum] = "410a7488c0a728c7ceb4ad59b9567eb4053d02e8cc7f5c0e0eeeb39518369213"
 SRC_URI[synstructure-0.12.3.sha256sum] = "67656ea1dc1b41b1451851562ea232ec2e5a80242139f7e679ceccfb5d61f545"
 SRC_URI[unicode-xid-0.2.0.sha256sum] = "826e7639553986605ec5979c7dd957c7895e93eabed50ab2ffa7f6128a75097c"
-# from rust/vendor/toml/Cargo.lock
+# from rust/vendor/bendy/Cargo.lock
+SRC_URI += " \
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
+"
 
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
+# from rust/vendor/alloc-stdlib/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/alloc-no-stdlib/2.0.4 \
+"
+
+SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
 # from rust/vendor/nom/Cargo.lock
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
+    crate://crates.io/winapi/0.3.9 \
+    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
+    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+"
 
 SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a"
 SRC_URI[bit-set-0.5.2.sha256sum] = "6e11e16035ea35e4e5997b393eacbf6f63983188f7a2ad25bfb13465f5ad59de<a class="moz-txt-link-rfc2396E" href="mailto:@@-814,42+588,129@@SRC_URI[wasi-0.10.2+wasi-snapshot-preview1.sha256sum]=">"
@@ -814,42 +588,129 @@ SRC_URI[wasi-0.10.2+wasi-snapshot-preview1.sha256sum] = "</a>fd6fbd9a79829dd1ad0cc20
 SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
-# from rust/vendor/brotli-decompressor/Cargo.lock
+# from rust/vendor/flate2/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/adler/1.0.2 \
+    crate://crates.io/cc/1.0.79 \
+    crate://crates.io/cfg-if/1.0.0 \
+    crate://crates.io/cloudflare-zlib-sys/0.3.0 \
+    crate://crates.io/cmake/0.1.50 \
+    crate://crates.io/crc32fast/1.3.2 \
+    crate://crates.io/getrandom/0.2.9 \
+    crate://crates.io/libc/0.2.144 \
+    crate://crates.io/libz-ng-sys/1.1.10 \
+    crate://crates.io/libz-sys/1.1.10 \
+    crate://crates.io/miniz_oxide/0.7.1 \
+    crate://crates.io/pkg-config/0.3.27 \
+    crate://crates.io/ppv-lite86/0.2.17 \
+    crate://crates.io/quickcheck/1.0.3 \
+    crate://crates.io/rand/0.8.5 \
+    crate://crates.io/rand_chacha/0.3.1 \
+    crate://crates.io/rand_core/0.6.4 \
+    crate://crates.io/vcpkg/0.2.15 \
+    crate://crates.io/wasi/0.11.0+wasi-snapshot-preview1 \
+"
 
-SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
-SRC_URI[alloc-stdlib-0.2.2.sha256sum] = "94fb8275041c72129eb51b7d0322c29b8387a0386127718b096429201a5d6ece"
-# from rust/vendor/displaydoc/Cargo.lock
+SRC_URI[adler-1.0.2.sha256sum] = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
+SRC_URI[cc-1.0.79.sha256sum] = "50d30906286121d95be3d479533b458f87493b30a4b5f79a607db8f5d11aa91f"
+SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+SRC_URI[cloudflare-zlib-sys-0.3.0.sha256sum] = "2040b6d1edfee6d75f172d81e2d2a7807534f3f294ce18184c70e7bb0105cd6f"
+SRC_URI[cmake-0.1.50.sha256sum] = "a31c789563b815f77f4250caee12365734369f942439b7defd71e18a48197130"
+SRC_URI[crc32fast-1.3.2.sha256sum] = "b540bd8bc810d3885c6ea91e2018302f68baba2129ab3e88f32389ee9370880d"
+SRC_URI[getrandom-0.2.9.sha256sum] = "c85e1d9ab2eadba7e5040d4e09cbd6d072b76a557ad64e797c2cb9d4da21d7e4"
+SRC_URI[libc-0.2.144.sha256sum] = "2b00cc1c228a6782d0f076e7b232802e0c5689d41bb5df366f2a6b6621cfdfe1"
+SRC_URI[libz-ng-sys-1.1.10.sha256sum] = "425fb6808068335c8c7c69d1cff0a7d1ed8f681e9ac040272f160a89e6f43b8b"
+SRC_URI[libz-sys-1.1.10.sha256sum] = "24e6ab01971eb092ffe6a7d42f49f9ff42662f17604681e2843ad65077ba47dc"
+SRC_URI[miniz_oxide-0.7.1.sha256sum] = "e7810e0be55b428ada41041c41f32c9f1a42817901b4ccf45fa3d4b6561e74c7"
+SRC_URI[pkg-config-0.3.27.sha256sum] = "26072860ba924cbfa98ea39c8c19b4dd6a4a25423dbdf219c1eca91aa0cf6964"
+SRC_URI[ppv-lite86-0.2.17.sha256sum] = "5b40af805b3121feab8a3c29f04d8ad262fa8e0561883e7653e024ae4479e6de"
+SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
+SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
+SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
+SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
+SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
+SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
+# from rust/vendor/regex/Cargo.lock
+SRC_URI += " \
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
+"
 
-SRC_URI[ansi_term-0.11.0.sha256sum] = "ee49baf6cb617b853aa8d93bf420db2383fab46d314482ca2803b40d5fde979b"
-SRC_URI[basic-toml-0.1.2.sha256sum] = "5c0de75129aa8d0cceaf750b89013f0e08804d6ec61416da787b35ad0d7cddf1"
-SRC_URI[ctor-0.1.26.sha256sum] = "6d2301688392eb071b0bf1a37be05c469d3cc4dbbd95df672fe28ab021e6a096"
-SRC_URI[difference-2.0.0.sha256sum] = "524cbf6897b527295dff137cec09ecf3a05f4fddffd7dfcd1585403449e74198"
-SRC_URI[glob-0.3.1.sha256sum] = "d2fabcfbdc87f4758337ca535fb41a6d701b65693ce38287d856d1674551ec9b"
-SRC_URI[itoa-1.0.6.sha256sum] = "453ad9f582a441959e5f0d088b02ce04cfe8d51a8eaf077f12ac6d3e94164ca6"
-SRC_URI[libc-0.2.142.sha256sum] = "6a987beff54b60ffa6d51982e1aa1146bc42f19bd26be28b0586f252fccf5317"
-SRC_URI[once_cell-1.17.1.sha256sum] = "b7e5500299e16ebb147ae15a00a942af264cf3688f47923b8fc2cd5858f23ad3"
-SRC_URI[output_vt100-0.1.3.sha256sum] = "628223faebab4e3e40667ee0b2336d34a5b960ff60ea743ddfdbcf7770bcfb66"
-SRC_URI[pretty_assertions-0.6.1.sha256sum] = "3f81e1644e1b54f5a68959a29aa86cde704219254669da328ecfdf6a1f09d427"
-SRC_URI[proc-macro2-1.0.56.sha256sum] = "2b63bdb0cd06f1f4dedf69b254734f9b45af66e4a031e42a7480257d9898b435"
-SRC_URI[quote-1.0.26.sha256sum] = "4424af4bf778aae2051a77b60283332f386554255d722233d09fbfc7e30da2fc"
-SRC_URI[rustversion-1.0.12.sha256sum] = "4f3208ce4d8448b3f3e7d168a73f5e0c43a61e32930de3bceeccedb388b6bf06"
-SRC_URI[ryu-1.0.13.sha256sum] = "f91339c0467de62360649f8d3e185ca8de4224ff281f66000de5eb2a77a79041"
-SRC_URI[serde-1.0.160.sha256sum] = "bb2f3770c8bce3bcda7e149193a069a0f4365bda1fa5cd88e03bca26afc1216c"
-SRC_URI[serde_derive-1.0.160.sha256sum] = "291a097c63d8497e00160b166a967a4a79c64f3facdd01cbd7502231688d77df"
-SRC_URI[serde_json-1.0.96.sha256sum] = "057d394a50403bcac12672b2b18fb387ab6d289d957dab67dd201875391e52f1"
-SRC_URI[static_assertions-1.1.0.sha256sum] = "a2eb9349b6444b326872e140eb1cf5e7c522154d69e7a0ffb0fb81c06b37543f"
-SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
-SRC_URI[syn-2.0.15.sha256sum] = "a34fcf3e8b60f57e6a14301a2e916d323af98b0ea63c599441eec8558660c822"
-SRC_URI[termcolor-1.2.0.sha256sum] = "be55cf8942feac5c765c2c993422806843c9a9a45d4d5c407ad6dd2ea95eb9b6"
-SRC_URI[thiserror-1.0.40.sha256sum] = "978c9a314bd8dc99be594bc3c175faaa9794be04a5a5e153caba6915336cebac"
-SRC_URI[thiserror-impl-1.0.40.sha256sum] = "f9456a42c5b0d803c8cd86e73dd7cc9edd429499f37a3550d286d5e86720569f"
-SRC_URI[trybuild-1.0.80.sha256sum] = "501dbdbb99861e4ab6b60eb6a7493956a9defb644fd034bc4a5ef27c693c8a3a"
-SRC_URI[unicode-ident-1.0.8.sha256sum] = "e5464a87b239f13a63a501f2701565754bae92d243d4bb7eb12f6d57d2269bf4"
-SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
-SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
-SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
-SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
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
 # from rust/vendor/asn1-rs/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/asn1-rs/0.5.1 \
+    crate://crates.io/asn1-rs-derive/0.4.0 \
+    crate://crates.io/asn1-rs-impl/0.1.0 \
+    crate://crates.io/atty/0.2.14 \
+    crate://crates.io/autocfg/1.1.0 \
+    crate://crates.io/base64/0.13.1 \
+    crate://crates.io/basic-toml/0.1.2 \
+    crate://crates.io/bitvec/1.0.1 \
+    crate://crates.io/colored/2.0.0 \
+    crate://crates.io/cookie-factory/0.3.2 \
+    crate://crates.io/displaydoc/0.2.3 \
+    crate://crates.io/funty/2.0.0 \
+    crate://crates.io/glob/0.3.1 \
+    crate://crates.io/hermit-abi/0.1.19 \
+    crate://crates.io/hex-literal/0.3.4 \
+    crate://crates.io/itoa/1.0.6 \
+    crate://crates.io/lazy_static/1.4.0 \
+    crate://crates.io/libc/0.2.139 \
+    crate://crates.io/memchr/2.5.0 \
+    crate://crates.io/minimal-lexical/0.2.1 \
+    crate://crates.io/nom/7.1.3 \
+    crate://crates.io/num-bigint/0.4.3 \
+    crate://crates.io/num-integer/0.1.45 \
+    crate://crates.io/num-traits/0.2.15 \
+    crate://crates.io/oid-registry/0.6.1 \
+    crate://crates.io/once_cell/1.17.1 \
+    crate://crates.io/pem/1.1.1 \
+    crate://crates.io/proc-macro2/1.0.51 \
+    crate://crates.io/quote/1.0.23 \
+    crate://crates.io/radium/0.7.0 \
+    crate://crates.io/rusticata-macros/4.1.0 \
+    crate://crates.io/ryu/1.0.13 \
+    crate://crates.io/serde/1.0.152 \
+    crate://crates.io/serde_derive/1.0.152 \
+    crate://crates.io/serde_json/1.0.94 \
+    crate://crates.io/syn/1.0.109 \
+    crate://crates.io/synstructure/0.12.6 \
+    crate://crates.io/tap/1.0.1 \
+    crate://crates.io/termcolor/1.2.0 \
+    crate://crates.io/thiserror/1.0.39 \
+    crate://crates.io/thiserror-impl/1.0.39 \
+    crate://crates.io/time/0.3.20 \
+    crate://crates.io/time-core/0.1.0 \
+    crate://crates.io/time-macros/0.2.8 \
+    crate://crates.io/trybuild/1.0.79 \
+    crate://crates.io/unicode-ident/1.0.8 \
+    crate://crates.io/unicode-xid/0.2.4 \
+    crate://crates.io/winapi/0.3.9 \
+    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
+    crate://crates.io/winapi-util/0.1.5 \
+    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+    crate://crates.io/wyz/0.5.1 \
+"
 
 SRC_URI[asn1-rs-0.5.1.sha256sum] = "cf6690c370453db30743b373a60ba498fc0d6d83b11f4abfd87a84a075db5dd4"
 SRC_URI[asn1-rs-derive-0.4.0.sha256sum] = "726535892e8eae7e70657b4c8ea93d26b8553afb1ce617caee529ef96d7dee6c<a class="moz-txt-link-rfc2396E" href="mailto:@@-903,7+764,216@@SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum]=">"
@@ -903,7 +764,216 @@ SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "</a>ac3b87c63620426dd9b991e5c
 SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
 SRC_URI[wyz-0.5.1.sha256sum] = "05f360fc0b24296329c78fda852a1e9ae82de9cf7b27dae4b7f62f118f77b9ed"
+# from rust/vendor/x509-parser/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/asn1-rs/0.5.2 \
+    crate://crates.io/asn1-rs-derive/0.4.0 \
+    crate://crates.io/asn1-rs-impl/0.1.0 \
+    crate://crates.io/autocfg/1.1.0 \
+    crate://crates.io/bumpalo/3.13.0 \
+    crate://crates.io/cc/1.0.81 \
+    crate://crates.io/cfg-if/1.0.0 \
+    crate://crates.io/data-encoding/2.4.0 \
+    crate://crates.io/der-parser/8.2.0 \
+    crate://crates.io/deranged/0.3.7 \
+    crate://crates.io/displaydoc/0.2.4 \
+    crate://crates.io/itoa/1.0.9 \
+    crate://crates.io/js-sys/0.3.64 \
+    crate://crates.io/lazy_static/1.4.0 \
+    crate://crates.io/libc/0.2.147 \
+    crate://crates.io/log/0.4.19 \
+    crate://crates.io/memchr/2.5.0 \
+    crate://crates.io/minimal-lexical/0.2.1 \
+    crate://crates.io/nom/7.1.3 \
+    crate://crates.io/num-bigint/0.4.3 \
+    crate://crates.io/num-integer/0.1.45 \
+    crate://crates.io/num-traits/0.2.16 \
+    crate://crates.io/oid-registry/0.6.1 \
+    crate://crates.io/once_cell/1.18.0 \
+    crate://crates.io/proc-macro2/1.0.66 \
+    crate://crates.io/quote/1.0.32 \
+    crate://crates.io/ring/0.16.20 \
+    crate://crates.io/rusticata-macros/4.1.0 \
+    crate://crates.io/serde/1.0.180 \
+    crate://crates.io/spin/0.5.2 \
+    crate://crates.io/syn/1.0.109 \
+    crate://crates.io/syn/2.0.28 \
+    crate://crates.io/synstructure/0.12.6 \
+    crate://crates.io/thiserror/1.0.44 \
+    crate://crates.io/thiserror-impl/1.0.44 \
+    crate://crates.io/time/0.3.25 \
+    crate://crates.io/time-core/0.1.1 \
+    crate://crates.io/time-macros/0.2.11 \
+    crate://crates.io/unicode-ident/1.0.11 \
+    crate://crates.io/unicode-xid/0.2.4 \
+    crate://crates.io/untrusted/0.7.1 \
+    crate://crates.io/wasm-bindgen/0.2.87 \
+    crate://crates.io/wasm-bindgen-backend/0.2.87 \
+    crate://crates.io/wasm-bindgen-macro/0.2.87 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.87 \
+    crate://crates.io/wasm-bindgen-shared/0.2.87 \
+    crate://crates.io/web-sys/0.3.64 \
+    crate://crates.io/winapi/0.3.9 \
+    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
+    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+"
+
+SRC_URI[asn1-rs-0.5.2.sha256sum] = "7f6fd5ddaf0351dff5b8da21b2fb4ff8e08ddd02857f0bf69c47639106c0fff0"
+SRC_URI[asn1-rs-derive-0.4.0.sha256sum] = "726535892e8eae7e70657b4c8ea93d26b8553afb1ce617caee529ef96d7dee6c"
+SRC_URI[asn1-rs-impl-0.1.0.sha256sum] = "2777730b2039ac0f95f093556e61b6d26cebed5393ca6f152717777cec3a42ed"
+SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
+SRC_URI[bumpalo-3.13.0.sha256sum] = "a3e2c3daef883ecc1b5d58c15adae93470a91d425f3532ba1695849656af3fc1"
+SRC_URI[cc-1.0.81.sha256sum] = "6c6b2562119bf28c3439f7f02db99faf0aa1a8cdfe5772a2ee155d32227239f0"
+SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+SRC_URI[data-encoding-2.4.0.sha256sum] = "c2e66c9d817f1720209181c316d28635c050fa304f9c79e47a520882661b7308"
+SRC_URI[der-parser-8.2.0.sha256sum] = "dbd676fbbab537128ef0278adb5576cf363cff6aa22a7b24effe97347cfab61e"
+SRC_URI[deranged-0.3.7.sha256sum] = "7684a49fb1af197853ef7b2ee694bc1f5b4179556f1e5710e1760c5db6f5e929"
+SRC_URI[displaydoc-0.2.4.sha256sum] = "487585f4d0c6655fe74905e2504d8ad6908e4db67f744eb140876906c2f3175d"
+SRC_URI[itoa-1.0.9.sha256sum] = "af150ab688ff2122fcef229be89cb50dd66af9e01a4ff320cc137eecc9bacc38"
+SRC_URI[js-sys-0.3.64.sha256sum] = "c5f195fe497f702db0f318b07fdd68edb16955aed830df8363d837542f8f935a"
+SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
+SRC_URI[libc-0.2.147.sha256sum] = "b4668fb0ea861c1df094127ac5f1da3409a82116a4ba74fca2e58ef927159bb3"
+SRC_URI[log-0.4.19.sha256sum] = "b06a4cde4c0f271a446782e3eff8de789548ce57dbc8eca9292c27f4a42004b4"
+SRC_URI[memchr-2.5.0.sha256sum] = "2dffe52ecf27772e601905b7522cb4ef790d2cc203488bbd0e2fe85fcb74566d"
+SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
+SRC_URI[nom-7.1.3.sha256sum] = "d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
+SRC_URI[num-bigint-0.4.3.sha256sum] = "f93ab6289c7b344a8a9f60f88d80aa20032336fe78da341afc91c8a2341fc75f"
+SRC_URI[num-integer-0.1.45.sha256sum] = "225d3389fb3509a24c93f5c29eb6bde2586b98d9f016636dff58d7c6f7569cd9"
+SRC_URI[num-traits-0.2.16.sha256sum] = "f30b0abd723be7e2ffca1272140fac1a2f084c77ec3e123c192b66af1ee9e6c2"
+SRC_URI[oid-registry-0.6.1.sha256sum] = "9bedf36ffb6ba96c2eb7144ef6270557b52e54b20c0a8e1eb2ff99a6c6959bff"
+SRC_URI[once_cell-1.18.0.sha256sum] = "dd8b5dd2ae5ed71462c540258bedcb51965123ad7e7ccf4b9a8cafaa4a63576d"
+SRC_URI[proc-macro2-1.0.66.sha256sum] = "18fb31db3f9bddb2ea821cde30a9f70117e3f119938b5ee630b7403aa6e2ead9"
+SRC_URI[quote-1.0.32.sha256sum] = "50f3b39ccfb720540debaa0164757101c08ecb8d326b15358ce76a62c7e85965"
+SRC_URI[ring-0.16.20.sha256sum] = "3053cf52e236a3ed746dfc745aa9cacf1b791d846bdaf412f60a8d7d6e17c8fc"
+SRC_URI[rusticata-macros-4.1.0.sha256sum] = "faf0c4a6ece9950b9abdb62b1cfcf2a68b3b67a10ba445b3bb85be2a293d0632"
+SRC_URI[serde-1.0.180.sha256sum] = "0ea67f183f058fe88a4e3ec6e2788e003840893b91bac4559cabedd00863b3ed"
+SRC_URI[spin-0.5.2.sha256sum] = "6e63cff320ae2c57904679ba7cb63280a3dc4613885beafb148ee7bf9aa9042d"
+SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
+SRC_URI[syn-2.0.28.sha256sum] = "04361975b3f5e348b2189d8dc55bc942f278b2d482a6a0365de5bdd62d351567"
+SRC_URI[synstructure-0.12.6.sha256sum] = "f36bdaa60a83aca3921b5259d5400cbf5e90fc51931376a9bd4a0eb79aa7210f"
+SRC_URI[thiserror-1.0.44.sha256sum] = "611040a08a0439f8248d1990b111c95baa9c704c805fa1f62104b39655fd7f90"
+SRC_URI[thiserror-impl-1.0.44.sha256sum] = "090198534930841fab3a5d1bb637cde49e339654e606195f8d9c76eeb081dc96"
+SRC_URI[time-0.3.25.sha256sum] = "b0fdd63d58b18d663fbdf70e049f00a22c8e42be082203be7f26589213cd75ea"
+SRC_URI[time-core-0.1.1.sha256sum] = "7300fbefb4dadc1af235a9cef3737cea692a9d97e1b9cbcd4ebdae6f8868e6fb"
+SRC_URI[time-macros-0.2.11.sha256sum] = "eb71511c991639bb078fd5bf97757e03914361c48100d52878b8e52b46fb92cd"
+SRC_URI[unicode-ident-1.0.11.sha256sum] = "301abaae475aa91687eb82514b328ab47a211a533026cb25fc3e519b86adfc3c"
+SRC_URI[unicode-xid-0.2.4.sha256sum] = "f962df74c8c05a667b5ee8bcf162993134c104e96440b663c8daa176dc772d8c"
+SRC_URI[untrusted-0.7.1.sha256sum] = "a156c684c91ea7d62626509bce3cb4e1d9ed5c4d978f7b4352658f96a4c26b4a"
+SRC_URI[wasm-bindgen-0.2.87.sha256sum] = "7706a72ab36d8cb1f80ffbf0e071533974a60d0a308d01a5d0375bf60499a342"
+SRC_URI[wasm-bindgen-backend-0.2.87.sha256sum] = "5ef2b6d3c510e9625e5fe6f509ab07d66a760f0885d858736483c32ed7809abd"
+SRC_URI[wasm-bindgen-macro-0.2.87.sha256sum] = "dee495e55982a3bd48105a7b947fd2a9b4a8ae3010041b9e0faab3f9cd028f1d"
+SRC_URI[wasm-bindgen-macro-support-0.2.87.sha256sum] = "54681b18a46765f095758388f2d0cf16eb8d4169b639ab575a8f5693af210c7b"
+SRC_URI[wasm-bindgen-shared-0.2.87.sha256sum] = "ca6ad05a4870b2bf5fe995117d3728437bd27d7cd5f06f13c17443ef369775a1"
+SRC_URI[web-sys-0.3.64.sha256sum] = "9b85cbef8c220a6abc02aefd892dfc0fc23afb1c6a426316ec33253a3877249b"
+SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
+SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
+SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
+# from rust/vendor/displaydoc/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/ansi_term/0.11.0 \
+    crate://crates.io/basic-toml/0.1.2 \
+    crate://crates.io/ctor/0.1.26 \
+    crate://crates.io/difference/2.0.0 \
+    crate://crates.io/glob/0.3.1 \
+    crate://crates.io/itoa/1.0.6 \
+    crate://crates.io/libc/0.2.142 \
+    crate://crates.io/once_cell/1.17.1 \
+    crate://crates.io/output_vt100/0.1.3 \
+    crate://crates.io/pretty_assertions/0.6.1 \
+    crate://crates.io/proc-macro2/1.0.56 \
+    crate://crates.io/quote/1.0.26 \
+    crate://crates.io/rustversion/1.0.12 \
+    crate://crates.io/ryu/1.0.13 \
+    crate://crates.io/serde/1.0.160 \
+    crate://crates.io/serde_derive/1.0.160 \
+    crate://crates.io/serde_json/1.0.96 \
+    crate://crates.io/static_assertions/1.1.0 \
+    crate://crates.io/syn/1.0.109 \
+    crate://crates.io/syn/2.0.15 \
+    crate://crates.io/termcolor/1.2.0 \
+    crate://crates.io/thiserror/1.0.40 \
+    crate://crates.io/thiserror-impl/1.0.40 \
+    crate://crates.io/trybuild/1.0.80 \
+    crate://crates.io/unicode-ident/1.0.8 \
+    crate://crates.io/winapi/0.3.9 \
+    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
+    crate://crates.io/winapi-util/0.1.5 \
+    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+"
+
+SRC_URI[ansi_term-0.11.0.sha256sum] = "ee49baf6cb617b853aa8d93bf420db2383fab46d314482ca2803b40d5fde979b"
+SRC_URI[basic-toml-0.1.2.sha256sum] = "5c0de75129aa8d0cceaf750b89013f0e08804d6ec61416da787b35ad0d7cddf1"
+SRC_URI[ctor-0.1.26.sha256sum] = "6d2301688392eb071b0bf1a37be05c469d3cc4dbbd95df672fe28ab021e6a096"
+SRC_URI[difference-2.0.0.sha256sum] = "524cbf6897b527295dff137cec09ecf3a05f4fddffd7dfcd1585403449e74198"
+SRC_URI[glob-0.3.1.sha256sum] = "d2fabcfbdc87f4758337ca535fb41a6d701b65693ce38287d856d1674551ec9b"
+SRC_URI[itoa-1.0.6.sha256sum] = "453ad9f582a441959e5f0d088b02ce04cfe8d51a8eaf077f12ac6d3e94164ca6"
+SRC_URI[libc-0.2.142.sha256sum] = "6a987beff54b60ffa6d51982e1aa1146bc42f19bd26be28b0586f252fccf5317"
+SRC_URI[once_cell-1.17.1.sha256sum] = "b7e5500299e16ebb147ae15a00a942af264cf3688f47923b8fc2cd5858f23ad3"
+SRC_URI[output_vt100-0.1.3.sha256sum] = "628223faebab4e3e40667ee0b2336d34a5b960ff60ea743ddfdbcf7770bcfb66"
+SRC_URI[pretty_assertions-0.6.1.sha256sum] = "3f81e1644e1b54f5a68959a29aa86cde704219254669da328ecfdf6a1f09d427"
+SRC_URI[proc-macro2-1.0.56.sha256sum] = "2b63bdb0cd06f1f4dedf69b254734f9b45af66e4a031e42a7480257d9898b435"
+SRC_URI[quote-1.0.26.sha256sum] = "4424af4bf778aae2051a77b60283332f386554255d722233d09fbfc7e30da2fc"
+SRC_URI[rustversion-1.0.12.sha256sum] = "4f3208ce4d8448b3f3e7d168a73f5e0c43a61e32930de3bceeccedb388b6bf06"
+SRC_URI[ryu-1.0.13.sha256sum] = "f91339c0467de62360649f8d3e185ca8de4224ff281f66000de5eb2a77a79041"
+SRC_URI[serde-1.0.160.sha256sum] = "bb2f3770c8bce3bcda7e149193a069a0f4365bda1fa5cd88e03bca26afc1216c"
+SRC_URI[serde_derive-1.0.160.sha256sum] = "291a097c63d8497e00160b166a967a4a79c64f3facdd01cbd7502231688d77df"
+SRC_URI[serde_json-1.0.96.sha256sum] = "057d394a50403bcac12672b2b18fb387ab6d289d957dab67dd201875391e52f1"
+SRC_URI[static_assertions-1.1.0.sha256sum] = "a2eb9349b6444b326872e140eb1cf5e7c522154d69e7a0ffb0fb81c06b37543f"
+SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
+SRC_URI[syn-2.0.15.sha256sum] = "a34fcf3e8b60f57e6a14301a2e916d323af98b0ea63c599441eec8558660c822"
+SRC_URI[termcolor-1.2.0.sha256sum] = "be55cf8942feac5c765c2c993422806843c9a9a45d4d5c407ad6dd2ea95eb9b6"
+SRC_URI[thiserror-1.0.40.sha256sum] = "978c9a314bd8dc99be594bc3c175faaa9794be04a5a5e153caba6915336cebac"
+SRC_URI[thiserror-impl-1.0.40.sha256sum] = "f9456a42c5b0d803c8cd86e73dd7cc9edd429499f37a3550d286d5e86720569f"
+SRC_URI[trybuild-1.0.80.sha256sum] = "501dbdbb99861e4ab6b60eb6a7493956a9defb644fd034bc4a5ef27c693c8a3a"
+SRC_URI[unicode-ident-1.0.8.sha256sum] = "e5464a87b239f13a63a501f2701565754bae92d243d4bb7eb12f6d57d2269bf4"
+SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
+SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
+SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
+SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
+# from rust/vendor/toml/Cargo.lock
+SRC_URI += " \
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
 # from rust/vendor/brotli/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/alloc-no-stdlib/2.0.4 \
+    crate://crates.io/alloc-stdlib/0.2.2 \
+    crate://crates.io/block-buffer/0.10.4 \
+    crate://crates.io/brotli-decompressor/5.0.0 \
+    crate://crates.io/cfg-if/1.0.0 \
+    crate://crates.io/cpufeatures/0.2.17 \
+    crate://crates.io/crypto-common/0.1.6 \
+    crate://crates.io/digest/0.10.7 \
+    crate://crates.io/generic-array/0.14.7 \
+    crate://crates.io/libc/0.2.172 \
+    crate://crates.io/sha2/0.10.9 \
+    crate://crates.io/typenum/1.18.0 \
+    crate://crates.io/version_check/0.9.5 \
+"
 
 SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
 SRC_URI[alloc-stdlib-0.2.2.sha256sum] = "94fb8275041c72129eb51b7d0322c29b8387a0386127718b096429201a5d6ece<a class="moz-txt-link-rfc2396E" href="mailto:@@-919,6+989,82@@SRC_URI[sha2-0.10.9.sha256sum]=">"
@@ -919,6 +989,82 @@ SRC_URI[sha2-0.10.9.sha256sum] = "</a>a7507d819769d01a365ab707794a4084392c824f54a7a6
 SRC_URI[typenum-1.18.0.sha256sum] = "1dccffe3ce07af9386bfd29e80c0ab1a8205a2fc34e4bcd40364df902cfa8f3f"
 SRC_URI[version_check-0.9.5.sha256sum] = "0b928f33d975fc6ad9f86c8f283853ad26bdd5b10b7f1542aa2fa15e2289105a"
 # from rust/vendor/phf_generator/Cargo.lock
+SRC_URI += " \
+    crate://crates.io/atty/0.2.14 \
+    crate://crates.io/autocfg/1.0.1 \
+    crate://crates.io/bitflags/1.2.1 \
+    crate://crates.io/bstr/0.2.16 \
+    crate://crates.io/bumpalo/3.7.0 \
+    crate://crates.io/cast/0.2.7 \
+    crate://crates.io/cfg-if/1.0.0 \
+    crate://crates.io/clap/2.33.3 \
+    crate://crates.io/criterion/0.3.4 \
+    crate://crates.io/criterion-plot/0.4.4 \
+    crate://crates.io/crossbeam-channel/0.5.1 \
+    crate://crates.io/crossbeam-deque/0.8.1 \
+    crate://crates.io/crossbeam-epoch/0.9.5 \
+    crate://crates.io/crossbeam-utils/0.8.5 \
+    crate://crates.io/csv/1.1.6 \
+    crate://crates.io/csv-core/0.1.10 \
+    crate://crates.io/either/1.6.1 \
+    crate://crates.io/getrandom/0.2.3 \
+    crate://crates.io/half/1.7.1 \
+    crate://crates.io/hermit-abi/0.1.19 \
+    crate://crates.io/itertools/0.10.1 \
+    crate://crates.io/itoa/0.4.7 \
+    crate://crates.io/js-sys/0.3.52 \
+    crate://crates.io/lazy_static/1.4.0 \
+    crate://crates.io/libc/0.2.99 \
+    crate://crates.io/log/0.4.14 \
+    crate://crates.io/memchr/2.4.0 \
+    crate://crates.io/memoffset/0.6.4 \
+    crate://crates.io/num-traits/0.2.14 \
+    crate://crates.io/num_cpus/1.13.0 \
+    crate://crates.io/oorandom/11.1.3 \
+    crate://crates.io/phf_shared/0.10.0 \
+    crate://crates.io/plotters/0.3.1 \
+    crate://crates.io/plotters-backend/0.3.2 \
+    crate://crates.io/plotters-svg/0.3.1 \
+    crate://crates.io/ppv-lite86/0.2.10 \
+    crate://crates.io/proc-macro2/1.0.28 \
+    crate://crates.io/quote/1.0.9 \
+    crate://crates.io/rand/0.8.4 \
+    crate://crates.io/rand_chacha/0.3.1 \
+    crate://crates.io/rand_core/0.6.3 \
+    crate://crates.io/rand_hc/0.3.1 \
+    crate://crates.io/rayon/1.5.1 \
+    crate://crates.io/rayon-core/1.9.1 \
+    crate://crates.io/regex/1.5.4 \
+    crate://crates.io/regex-automata/0.1.10 \
+    crate://crates.io/regex-syntax/0.6.25 \
+    crate://crates.io/rustc_version/0.4.0 \
+    crate://crates.io/ryu/1.0.5 \
+    crate://crates.io/same-file/1.0.6 \
+    crate://crates.io/scopeguard/1.1.0 \
+    crate://crates.io/semver/1.0.4 \
+    crate://crates.io/serde/1.0.127 \
+    crate://crates.io/serde_cbor/0.11.1 \
+    crate://crates.io/serde_derive/1.0.127 \
+    crate://crates.io/serde_json/1.0.66 \
+    crate://crates.io/siphasher/0.3.6 \
+    crate://crates.io/syn/1.0.74 \
+    crate://crates.io/textwrap/0.11.0 \
+    crate://crates.io/tinytemplate/1.2.1 \
+    crate://crates.io/unicode-width/0.1.8 \
+    crate://crates.io/unicode-xid/0.2.2 \
+    crate://crates.io/walkdir/2.3.2 \
+    crate://crates.io/wasi/0.10.2+wasi-snapshot-preview1 \
+    crate://crates.io/wasm-bindgen/0.2.75 \
+    crate://crates.io/wasm-bindgen-backend/0.2.75 \
+    crate://crates.io/wasm-bindgen-macro/0.2.75 \
+    crate://crates.io/wasm-bindgen-macro-support/0.2.75 \
+    crate://crates.io/wasm-bindgen-shared/0.2.75 \
+    crate://crates.io/web-sys/0.3.52 \
+    crate://crates.io/winapi/0.3.9 \
+    crate://crates.io/winapi-i686-pc-windows-gnu/0.4.0 \
+    crate://crates.io/winapi-util/0.1.5 \
+    crate://crates.io/winapi-x86_64-pc-windows-gnu/0.4.0 \
+"
 
 SRC_URI[atty-0.2.14.sha256sum] = "d9b39be18770d11421cdb1b9947a45dd3f37e93092cbf377614828a319d5fee8"
 SRC_URI[autocfg-1.0.1.sha256sum] = "cdb031dd78e28731d87d56cc8ffef4a8f36ca26c38fe2de700543e627f8a464a<a class="moz-txt-link-rfc2396E" href="mailto:@@-994,120+1140,3@@SRC_URI[winapi-0.3.9.sha256sum]=">"
@@ -994,120 +1140,3 @@ SRC_URI[winapi-0.3.9.sha256sum] = "</a>5c839a674fcd7a98952e593242ea400abe93992746761
 SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
 SRC_URI[winapi-util-0.1.5.sha256sum] = "70ec6ce85bb158151cae5e5c87f95a8e97d2c0c4b001223f33a334e3ce5de178"
 SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
-# from rust/vendor/alloc-stdlib/Cargo.lock
-
-SRC_URI[alloc-no-stdlib-2.0.4.sha256sum] = "cc7bb162ec39d46ab1ca8c77bf72e890535becd1751bb45f64c597edb4c8c6b3"
-# from rust/vendor/x509-parser/Cargo.lock
-
-SRC_URI[asn1-rs-0.5.2.sha256sum] = "7f6fd5ddaf0351dff5b8da21b2fb4ff8e08ddd02857f0bf69c47639106c0fff0"
-SRC_URI[asn1-rs-derive-0.4.0.sha256sum] = "726535892e8eae7e70657b4c8ea93d26b8553afb1ce617caee529ef96d7dee6c"
-SRC_URI[asn1-rs-impl-0.1.0.sha256sum] = "2777730b2039ac0f95f093556e61b6d26cebed5393ca6f152717777cec3a42ed"
-SRC_URI[autocfg-1.1.0.sha256sum] = "d468802bab17cbc0cc575e9b053f41e72aa36bfa6b7f55e3529ffa43161b97fa"
-SRC_URI[bumpalo-3.13.0.sha256sum] = "a3e2c3daef883ecc1b5d58c15adae93470a91d425f3532ba1695849656af3fc1"
-SRC_URI[cc-1.0.81.sha256sum] = "6c6b2562119bf28c3439f7f02db99faf0aa1a8cdfe5772a2ee155d32227239f0"
-SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[data-encoding-2.4.0.sha256sum] = "c2e66c9d817f1720209181c316d28635c050fa304f9c79e47a520882661b7308"
-SRC_URI[der-parser-8.2.0.sha256sum] = "dbd676fbbab537128ef0278adb5576cf363cff6aa22a7b24effe97347cfab61e"
-SRC_URI[deranged-0.3.7.sha256sum] = "7684a49fb1af197853ef7b2ee694bc1f5b4179556f1e5710e1760c5db6f5e929"
-SRC_URI[displaydoc-0.2.4.sha256sum] = "487585f4d0c6655fe74905e2504d8ad6908e4db67f744eb140876906c2f3175d"
-SRC_URI[itoa-1.0.9.sha256sum] = "af150ab688ff2122fcef229be89cb50dd66af9e01a4ff320cc137eecc9bacc38"
-SRC_URI[js-sys-0.3.64.sha256sum] = "c5f195fe497f702db0f318b07fdd68edb16955aed830df8363d837542f8f935a"
-SRC_URI[lazy_static-1.4.0.sha256sum] = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646"
-SRC_URI[libc-0.2.147.sha256sum] = "b4668fb0ea861c1df094127ac5f1da3409a82116a4ba74fca2e58ef927159bb3"
-SRC_URI[log-0.4.19.sha256sum] = "b06a4cde4c0f271a446782e3eff8de789548ce57dbc8eca9292c27f4a42004b4"
-SRC_URI[memchr-2.5.0.sha256sum] = "2dffe52ecf27772e601905b7522cb4ef790d2cc203488bbd0e2fe85fcb74566d"
-SRC_URI[minimal-lexical-0.2.1.sha256sum] = "68354c5c6bd36d73ff3feceb05efa59b6acb7626617f4962be322a825e61f79a"
-SRC_URI[nom-7.1.3.sha256sum] = "d273983c5a657a70a3e8f2a01329822f3b8c8172b73826411a55751e404a0a4a"
-SRC_URI[num-bigint-0.4.3.sha256sum] = "f93ab6289c7b344a8a9f60f88d80aa20032336fe78da341afc91c8a2341fc75f"
-SRC_URI[num-integer-0.1.45.sha256sum] = "225d3389fb3509a24c93f5c29eb6bde2586b98d9f016636dff58d7c6f7569cd9"
-SRC_URI[num-traits-0.2.16.sha256sum] = "f30b0abd723be7e2ffca1272140fac1a2f084c77ec3e123c192b66af1ee9e6c2"
-SRC_URI[oid-registry-0.6.1.sha256sum] = "9bedf36ffb6ba96c2eb7144ef6270557b52e54b20c0a8e1eb2ff99a6c6959bff"
-SRC_URI[once_cell-1.18.0.sha256sum] = "dd8b5dd2ae5ed71462c540258bedcb51965123ad7e7ccf4b9a8cafaa4a63576d"
-SRC_URI[proc-macro2-1.0.66.sha256sum] = "18fb31db3f9bddb2ea821cde30a9f70117e3f119938b5ee630b7403aa6e2ead9"
-SRC_URI[quote-1.0.32.sha256sum] = "50f3b39ccfb720540debaa0164757101c08ecb8d326b15358ce76a62c7e85965"
-SRC_URI[ring-0.16.20.sha256sum] = "3053cf52e236a3ed746dfc745aa9cacf1b791d846bdaf412f60a8d7d6e17c8fc"
-SRC_URI[rusticata-macros-4.1.0.sha256sum] = "faf0c4a6ece9950b9abdb62b1cfcf2a68b3b67a10ba445b3bb85be2a293d0632"
-SRC_URI[serde-1.0.180.sha256sum] = "0ea67f183f058fe88a4e3ec6e2788e003840893b91bac4559cabedd00863b3ed"
-SRC_URI[spin-0.5.2.sha256sum] = "6e63cff320ae2c57904679ba7cb63280a3dc4613885beafb148ee7bf9aa9042d"
-SRC_URI[syn-1.0.109.sha256sum] = "72b64191b275b66ffe2469e8af2c1cfe3bafa67b529ead792a6d0160888b4237"
-SRC_URI[syn-2.0.28.sha256sum] = "04361975b3f5e348b2189d8dc55bc942f278b2d482a6a0365de5bdd62d351567"
-SRC_URI[synstructure-0.12.6.sha256sum] = "f36bdaa60a83aca3921b5259d5400cbf5e90fc51931376a9bd4a0eb79aa7210f"
-SRC_URI[thiserror-1.0.44.sha256sum] = "611040a08a0439f8248d1990b111c95baa9c704c805fa1f62104b39655fd7f90"
-SRC_URI[thiserror-impl-1.0.44.sha256sum] = "090198534930841fab3a5d1bb637cde49e339654e606195f8d9c76eeb081dc96"
-SRC_URI[time-0.3.25.sha256sum] = "b0fdd63d58b18d663fbdf70e049f00a22c8e42be082203be7f26589213cd75ea"
-SRC_URI[time-core-0.1.1.sha256sum] = "7300fbefb4dadc1af235a9cef3737cea692a9d97e1b9cbcd4ebdae6f8868e6fb"
-SRC_URI[time-macros-0.2.11.sha256sum] = "eb71511c991639bb078fd5bf97757e03914361c48100d52878b8e52b46fb92cd"
-SRC_URI[unicode-ident-1.0.11.sha256sum] = "301abaae475aa91687eb82514b328ab47a211a533026cb25fc3e519b86adfc3c"
-SRC_URI[unicode-xid-0.2.4.sha256sum] = "f962df74c8c05a667b5ee8bcf162993134c104e96440b663c8daa176dc772d8c"
-SRC_URI[untrusted-0.7.1.sha256sum] = "a156c684c91ea7d62626509bce3cb4e1d9ed5c4d978f7b4352658f96a4c26b4a"
-SRC_URI[wasm-bindgen-0.2.87.sha256sum] = "7706a72ab36d8cb1f80ffbf0e071533974a60d0a308d01a5d0375bf60499a342"
-SRC_URI[wasm-bindgen-backend-0.2.87.sha256sum] = "5ef2b6d3c510e9625e5fe6f509ab07d66a760f0885d858736483c32ed7809abd"
-SRC_URI[wasm-bindgen-macro-0.2.87.sha256sum] = "dee495e55982a3bd48105a7b947fd2a9b4a8ae3010041b9e0faab3f9cd028f1d"
-SRC_URI[wasm-bindgen-macro-support-0.2.87.sha256sum] = "54681b18a46765f095758388f2d0cf16eb8d4169b639ab575a8f5693af210c7b"
-SRC_URI[wasm-bindgen-shared-0.2.87.sha256sum] = "ca6ad05a4870b2bf5fe995117d3728437bd27d7cd5f06f13c17443ef369775a1"
-SRC_URI[web-sys-0.3.64.sha256sum] = "9b85cbef8c220a6abc02aefd892dfc0fc23afb1c6a426316ec33253a3877249b"
-SRC_URI[winapi-0.3.9.sha256sum] = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419"
-SRC_URI[winapi-i686-pc-windows-gnu-0.4.0.sha256sum] = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6"
-SRC_URI[winapi-x86_64-pc-windows-gnu-0.4.0.sha256sum] = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f"
-# from rust/vendor/regex/Cargo.lock
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
-# from rust/vendor/flate2/Cargo.lock
-
-SRC_URI[adler-1.0.2.sha256sum] = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
-SRC_URI[cc-1.0.79.sha256sum] = "50d30906286121d95be3d479533b458f87493b30a4b5f79a607db8f5d11aa91f"
-SRC_URI[cfg-if-1.0.0.sha256sum] = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
-SRC_URI[cloudflare-zlib-sys-0.3.0.sha256sum] = "2040b6d1edfee6d75f172d81e2d2a7807534f3f294ce18184c70e7bb0105cd6f"
-SRC_URI[cmake-0.1.50.sha256sum] = "a31c789563b815f77f4250caee12365734369f942439b7defd71e18a48197130"
-SRC_URI[crc32fast-1.3.2.sha256sum] = "b540bd8bc810d3885c6ea91e2018302f68baba2129ab3e88f32389ee9370880d"
-SRC_URI[getrandom-0.2.9.sha256sum] = "c85e1d9ab2eadba7e5040d4e09cbd6d072b76a557ad64e797c2cb9d4da21d7e4"
-SRC_URI[libc-0.2.144.sha256sum] = "2b00cc1c228a6782d0f076e7b232802e0c5689d41bb5df366f2a6b6621cfdfe1"
-SRC_URI[libz-ng-sys-1.1.10.sha256sum] = "425fb6808068335c8c7c69d1cff0a7d1ed8f681e9ac040272f160a89e6f43b8b"
-SRC_URI[libz-sys-1.1.10.sha256sum] = "24e6ab01971eb092ffe6a7d42f49f9ff42662f17604681e2843ad65077ba47dc"
-SRC_URI[miniz_oxide-0.7.1.sha256sum] = "e7810e0be55b428ada41041c41f32c9f1a42817901b4ccf45fa3d4b6561e74c7"
-SRC_URI[pkg-config-0.3.27.sha256sum] = "26072860ba924cbfa98ea39c8c19b4dd6a4a25423dbdf219c1eca91aa0cf6964"
-SRC_URI[ppv-lite86-0.2.17.sha256sum] = "5b40af805b3121feab8a3c29f04d8ad262fa8e0561883e7653e024ae4479e6de"
-SRC_URI[quickcheck-1.0.3.sha256sum] = "588f6378e4dd99458b60ec275b4477add41ce4fa9f64dcba6f15adccb19b50d6"
-SRC_URI[rand-0.8.5.sha256sum] = "34af8d1a0e25924bc5b7c43c079c942339d8f0a8b57c39049bef581b46327404"
-SRC_URI[rand_chacha-0.3.1.sha256sum] = "e6c10a63a0fa32252be49d21e7709d4d4baf8d231c2dbce1eaa8141b9b127d88"
-SRC_URI[rand_core-0.6.4.sha256sum] = "ec0be4795e2f6a28069bec0b5ff3e2ac9bafc99e6a9a7dc3547996c5c816922c"
-SRC_URI[vcpkg-0.2.15.sha256sum] = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
-SRC_URI[wasi-0.11.0+wasi-snapshot-preview1.sha256sum] = "9c8d87e72b64a3b4db28d11ce29237c246188f4f51057d65a7eab63b7987e423"
diff --git a/recipes-ids/suricata/suricata_7.0.12.bb b/recipes-ids/suricata/suricata_7.0.13.bb
similarity index 98%
rename from recipes-ids/suricata/suricata_7.0.12.bb
rename to recipes-ids/suricata/suricata_7.0.13.bb
index ff022e0..75e523e 100644
--- a/recipes-ids/suricata/suricata_7.0.12.bb
+++ b/recipes-ids/suricata/suricata_7.0.13.bb
@@ -5,7 +5,7 @@ require suricata.inc
 LIC_FILES_CHKSUM = <a class="moz-txt-link-rfc2396E" href="file://LICENSE;beginline=1;endline=2;md5=c70d8d3310941dcdfcd1e02800a1f548">"file://LICENSE;beginline=1;endline=2;md5=c70d8d3310941dcdfcd1e02800a1f548"</a>
 
 SRC_URI = <a class="moz-txt-link-rfc2396E" href="http://www.openinfosecfoundation.org/download/suricata-${PV}.tar.gz">"http://www.openinfosecfoundation.org/download/suricata-${PV}.tar.gz"</a>
-SRC_URI[sha256sum] = "da5a591c749fed2bd986fc3b3cac25d9cfd3b453f57becf14610746999d3c5dd"
+SRC_URI[sha256sum] = "bbc94cf0a297f4560c64569ed72867c799287defdaf6e6572ce769f48dd2559b"
 
 DEPENDS = "lz4 libhtp"
 
</pre>
    </blockquote>
    <div class="moz-signature">-- <br>
      <font color="#0000FF">
        Regards,<br>
        Hitendra Prajapati<br>
        MontaVista Software LLC<br>
        Mo: +91 9998906483 <br>
      </font></div>
  </body>
</html>

--------------jT0hXWsRfjrhPD3q545rlzHR--

