#!/usr/bin/env python3
"""Module docstring"""
import sys
import dns.resolver
import dns.exception


def query_dns_records(domain_name: str, record_type: str):
    try:
        answer = dns.resolver.resolve(domain_name, record_type)
        return answer
    except dns.exception.DNSException:
        return None


if __name__ == "__main__":

    domain_name = sys.argv[1]
    print("=" * 70)
    print(f"DNS Record Enumeration: {domain_name}")
    print("=" * 70)

    record_types = ['A', 'AAAA', 'MX', 'NS', 'TXT', 'SOA']
    found_record_types = []
    total_records = 0

    for record_type in record_types:
        result = query_dns_records(domain_name, record_type)
        if result:
            print(f"\n{record_type} Records ({len(result)}):")
            for r in result:
                print(f"  • {r}")
            found_record_types.append(record_type)
            total_records += len(result)

    print("=" * 70)
    print(
        f"Summary: Found {len(found_record_types)} record types "
        f"with {total_records} total records"
         )
    print("=" * 70)
    print()
