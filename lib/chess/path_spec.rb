# frozen_string_literal: true

module Chess
  RSpec.describe Path do
    describe '#include?' do
      context 'when given point on vertical path' do
        it 'includes that point' do
          from = Vector.new(0, 0)
          to = Vector.new(0, 2)
          path = described_class.new(from, to)

          expect(path).to include(Vector.new(0, 1))
        end
      end

      context 'when given point before vertical path' do
        it 'does not include that point' do
          from = Vector.new(0, 1)
          to = Vector.new(0, 2)
          path = described_class.new(from, to)

          expect(path).not_to include(Vector.new(0, 0))
        end
      end

      context 'when given point beside vertical path' do
        it 'does not include that point' do
          from = Vector.new(0, 0)
          to = Vector.new(0, 2)
          path = described_class.new(from, to)

          expect(path).not_to include(Vector.new(1, 0))
        end
      end

      context 'when given point on diagonal path' do
        it 'includes that point' do
          from = Vector.new(0, 0)
          to = Vector.new(2, 2)
          path = described_class.new(from, to)

          expect(path).to include(Vector.new(1, 1))
        end
      end

      context 'when given point above diagonal path' do
        it 'does not include that point' do
          from = Vector.new(0, 0)
          to = Vector.new(2, 2)
          path = described_class.new(from, to)

          expect(path).not_to include(Vector.new(0, 2))
        end
      end

      context 'when given point past diagonal path' do
        it 'does not include that point' do
          from = Vector.new(0, 0)
          to = Vector.new(2, 2)
          path = described_class.new(from, to)

          expect(path).not_to include(Vector.new(3, 3))
        end
      end

      context 'when given point before diagonal path' do
        it 'does not include that point' do
          from = Vector.new(1, 1)
          to = Vector.new(2, 2)
          path = described_class.new(from, to)

          expect(path).not_to include(Vector.new(0, 0))
        end
      end

      context 'when given point on horizontal path' do
        it 'includes that point' do
          from = Vector.new(0, 0)
          to = Vector.new(2, 0)
          path = described_class.new(from, to)

          expect(path).to include(Vector.new(1, 0))
        end
      end

      context 'when given point on negative horizontal path' do
        it 'includes that point' do
          from = Vector.new(2, 0)
          to = Vector.new(0, 0)
          path = described_class.new(from, to)

          expect(path).to include(Vector.new(1, 0))
        end
      end

      context 'when given point above horizontal path' do
        it 'does not include that point' do
          from = Vector.new(0, 0)
          to = Vector.new(2, 0)
          path = described_class.new(from, to)

          expect(path).not_to include(Vector.new(0, 1))
        end
      end

      context 'when given point past horizontal path' do
        it 'does not include that point' do
          from = Vector.new(0, 0)
          to = Vector.new(1, 0)
          path = described_class.new(from, to)

          expect(path).not_to include(Vector.new(2, 0))
        end
      end
    end
  end
end
