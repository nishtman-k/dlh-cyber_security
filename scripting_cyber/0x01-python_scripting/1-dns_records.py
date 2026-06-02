#!/usr/bin/env python3
"""Module docstring"""
import sys
import dns.resolver
import dns.exception


def query_dns_records(domain_name):
    record_types = ['A', 'AAAA', 'MX', 'NS', 'TXT', 'SOA']
    results = {}
    for record_type in record_types:
        try:
            answers = dns.resolver.resolve(domain_name, record_type)
            results[record_type] = answers
        except (dns.resolver.NoAnswer,
                dns.resolver.NXDOMAIN,
                dns.resolver.NoNameservers):
            pass
    return results


if __name__ == "__main__":
    domain_name = sys.argv[1]
    print("=" * 70)
    print(f"DNS Record Enumeration: {domain_name}")
    print("=" * 70)

    record_types = query_dns_records(domain_name)
    total_records = 0

    for record_type in record_types:
        answers = dns.resolver.resolve(domain_name, record_type)
        print(f"\n{record_type} Records ({len(answers)}):")
        for r in answers:
            print(f"  • {r}")
        total_records += len(answers)

    print("=" * 70)
    print(
        f"Summary: Found {len(record_types)} record types "
        f"with {total_records} total records"
         )
    print("=" * 70)
    print()
