require 'spine/restrictions'

module Spine
  module Restrictions
    describe Collection do
      let(:restriction) { double(restricted?: true) }
      let(:context) { double }

      it 'registers restriction' do
        subject.register(restriction).restrict(:read, :all)
        expect(subject.registrations.size).to be > 0
      end

      it 'registers restriction on specific action and specific resource' do
        subject.register(restriction).restrict(:read, :data)
        expect(subject.restricted?(context, :read, :data)).to be
      end

      it 'registers restriction on all actions and specific resource' do
        subject.register(restriction).restrict(:all, :data)
        expect(subject.restricted?(context, :read, :data)).to be
      end

      it 'registers restriction on specific action and all resources' do
        subject.register(restriction).restrict(:read, :all)
        expect(subject.restricted?(context, :read, :data)).to be
      end

      it 'registers restriction on all actions and all resources' do
        subject.register(restriction).restrict(:all, :all)
        expect(subject.restricted?(context, :read, :data)).to be
      end

      it 'registers exception' do
        subject.register(restriction)
          .restrict(:read, :all)
          .except(:read, :data)
        expect(subject.restricted?(context, :read, :data)).to be_falsy
      end

      it 'restricts' do
        subject.register(restriction).restrict(:read, :all)
        expect(subject.restricted?(context, :read, :data)).to be
      end
    end
  end
end
